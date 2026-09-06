package egovframework.test;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.InputStream;
import java.lang.reflect.GenericArrayType;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

import org.apache.ibatis.builder.xml.XMLConfigBuilder;
import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.mapping.ResultMap;
import org.apache.ibatis.mapping.ResultMapping;
import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaClass;
import org.apache.ibatis.reflection.ReflectorFactory;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.TypeHandler;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

/**
 * 결과매핑의 타입핸들러가 내놓는 값은 대상 프로퍼티에 담길 수 있어야 한다.
 *
 * 담기지 않으면 조회 시점에 {@code argument type mismatch}로 끊긴다.
 * 매퍼가 DB 변종마다 갈라져 있어 한 변종에서만 어긋나기 쉽다.
 *
 * @author 최완택
 * @since 2026-09-02
 */
@DisplayName("매퍼 타입핸들러")
class EgovMapperTypeHandlerTest {

	private static final Path MAPPER_DIR = Paths.get("src/main/resources/egovframework/mapper/let");

	private static final Pattern DB_TYPE = Pattern.compile("_([a-z]+)\\.xml$");

	private static final ReflectorFactory REFLECTOR_FACTORY = new DefaultReflectorFactory();

	@Test
	@DisplayName("핸들러가 내놓는 타입이 프로퍼티 타입에 담긴다")
	void resultMappingTypeHandlersFitTheirProperties() throws Exception {
		List<String> mismatches = new ArrayList<>();

		for (String dbType : dbTypes()) {
			for (Object candidate : configurationFor(dbType).getResultMaps()) {
				if (!(candidate instanceof ResultMap resultMap)) {
					continue;
				}
				collectMismatches(dbType, resultMap, mismatches);
			}
		}

		assertTrue(mismatches.isEmpty(), "핸들러 타입 불일치: " + mismatches);
	}

	private void collectMismatches(String dbType, ResultMap resultMap, List<String> mismatches) {
		Class<?> resultType = resultMap.getType();
		if (resultType == null || Map.class.isAssignableFrom(resultType)) {
			return;
		}
		MetaClass metaClass = MetaClass.forClass(resultType, REFLECTOR_FACTORY);

		for (ResultMapping mapping : resultMap.getResultMappings()) {
			if (mapping.getProperty() == null || mapping.getTypeHandler() == null) {
				continue;
			}
			Class<?> propertyType = metaClass.getSetterType(mapping.getProperty());
			Class<?> handledType = handledType(mapping.getTypeHandler());
			if (propertyType == null || handledType == null
					|| propertyType.isPrimitive() || handledType.isPrimitive()) {
				continue;
			}
			if (!propertyType.isAssignableFrom(handledType)) {
				mismatches.add("%s %s.%s %s -> %s".formatted(dbType, resultMap.getId(),
					mapping.getProperty(), handledType.getSimpleName(), propertyType.getSimpleName()));
			}
		}
	}

	/** {@code BaseTypeHandler<T>} 의 T. 알 수 없으면 null. */
	private Class<?> handledType(TypeHandler<?> typeHandler) {
		for (Class<?> type = typeHandler.getClass(); type != null; type = type.getSuperclass()) {
			if (!(type.getGenericSuperclass() instanceof ParameterizedType parameterized)
					|| parameterized.getRawType() != BaseTypeHandler.class) {
				continue;
			}
			Type argument = parameterized.getActualTypeArguments()[0];
			if (argument instanceof Class<?> resolved) {
				return resolved;
			}
			if (argument instanceof GenericArrayType array && array.getGenericComponentType() == byte.class) {
				return byte[].class;
			}
		}
		return null;
	}

	private Configuration configurationFor(String dbType) throws Exception {
		Configuration configuration;
		try (InputStream config = getClass()
				.getResourceAsStream("/egovframework/mapper/config/mapper-config.xml")) {
			configuration = new XMLConfigBuilder(config).parse();
		}
		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
		for (Resource mapper : resolver
				.getResources("classpath*:/egovframework/mapper/let/**/*_" + dbType + ".xml")) {
			try (InputStream in = mapper.getInputStream()) {
				new XMLMapperBuilder(in, configuration, mapper.getURI().toString(),
					configuration.getSqlFragments()).parse();
			}
		}
		return configuration;
	}

	private Set<String> dbTypes() throws Exception {
		Set<String> dbTypes = new TreeSet<>();
		try (Stream<Path> paths = Files.walk(MAPPER_DIR)) {
			for (Path path : paths.filter(Files::isRegularFile).toList()) {
				Matcher matcher = DB_TYPE.matcher(path.getFileName().toString());
				if (matcher.find()) {
					dbTypes.add(matcher.group(1));
				}
			}
		}
		return dbTypes;
	}

}
