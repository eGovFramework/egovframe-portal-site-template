package egovframework.test;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * 같은 매퍼의 데이터베이스별 변종은 같은 쿼리 아이디 집합을 가져야 한다.
 *
 * 한 변종에만 쿼리가 빠지면 그 데이터베이스에서만 화면이 실패한다.
 *
 * @author 최완택
 * @since 2026-08-30
 */
@DisplayName("매퍼 변종")
class EgovMapperVariantTest {

	private static final Pattern FILE_NAME = Pattern
			.compile("(.+)_(mysql|oracle|postgres|cubrid|tibero|altibase|hsql)\\.xml$");

	private static final Pattern STATEMENT_ID = Pattern
			.compile("<(?:select|insert|update|delete)\\s+id=\"([^\"]+)\"");

	@Test
	@DisplayName("데이터베이스별 변종이 같은 쿼리 아이디를 선언한다")
	void mapperVariantsDeclareSameStatementIds() throws IOException {
		Map<String, Map<String, Set<String>>> groups = new LinkedHashMap<>();

		try (Stream<Path> paths = Files.walk(Paths.get("src/main/resources/egovframework/mapper"))) {
			for (Path path : paths.filter(Files::isRegularFile).toList()) {
				Matcher fileName = FILE_NAME.matcher(path.getFileName().toString());
				if (!fileName.matches()) {
					continue;
				}
				groups.computeIfAbsent(fileName.group(1), key -> new LinkedHashMap<>())
						.put(fileName.group(2), statementIds(path));
			}
		}

		List<String> missing = new ArrayList<>();

		for (Map.Entry<String, Map<String, Set<String>>> group : groups.entrySet()) {
			Set<String> union = new TreeSet<>();
			group.getValue().values().forEach(union::addAll);

			for (Map.Entry<String, Set<String>> variant : group.getValue().entrySet()) {
				Set<String> gap = new TreeSet<>(union);
				gap.removeAll(variant.getValue());
				if (!gap.isEmpty()) {
					missing.add(group.getKey() + "_" + variant.getKey() + ".xml " + gap);
				}
			}
		}

		assertTrue(missing.isEmpty(), "변종에 빠진 쿼리: " + missing);
	}

	private Set<String> statementIds(Path path) throws IOException {
		Set<String> ids = new HashSet<>();
		Matcher matcher = STATEMENT_ID.matcher(Files.readString(path, StandardCharsets.UTF_8));
		while (matcher.find()) {
			ids.add(matcher.group(1));
		}
		return ids;
	}

}
