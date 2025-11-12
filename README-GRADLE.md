# 전자정부 프레임워크 포털사이트 템플릿 - Gradle + Kotlin 버전

본 프로젝트는 기존 Maven 기반 전자정부 프레임워크 포털사이트 템플릿을 Gradle과 Kotlin으로 전환한 버전입니다.

## 📋 기술 스택

- **빌드 도구**: Gradle 8.5 (Kotlin DSL)
- **언어**: Java 11 + Kotlin 1.9.24
- **웹 프레임워크**: Spring MVC (전자정부 프레임워크 4.3.0)
- **뷰 기술**: JSP + JSTL
- **데이터베이스**: H2, MySQL 지원

## 🚀 빌드 및 실행

### 기본 빌드
```bash
./gradlew build
```

### 테스트 제외 빌드
```bash
./gradlew build -x test
```

### 컴파일만 실행
```bash
./gradlew compileKotlin compileJava
```

### WAR 패키지 생성
```bash
./gradlew war
```

### 클린 빌드
```bash
./gradlew clean build
```

## 📁 프로젝트 구조

```
src/
├── main/
│   ├── java/           # 기존 Java 소스
│   ├── kotlin/         # Kotlin으로 변환된 소스
│   ├── resources/      # 설정 파일, 프로퍼티
│   └── webapp/         # JSP, CSS, JS, 웹 리소스
└── test/
    ├── java/           # Java 테스트
    ├── kotlin/         # Kotlin 테스트
    └── resources/      # 테스트 리소스
```

## 🔄 Kotlin으로 변환된 클래스

1. **EgovMainController** - 메인 페이지 컨트롤러
   - `src/main/kotlin/egovframework/let/main/web/EgovMainController.kt`

2. **ComDefaultVO** - 공통 기본 VO
   - `src/main/kotlin/egovframework/com/cmm/ComDefaultVO.kt`

3. **LoginVO** - 로그인 VO
   - `src/main/kotlin/egovframework/com/cmm/LoginVO.kt`

## ⚙️ 주요 Gradle 설정

### 플러그인
- `kotlin("jvm")` - Kotlin JVM 플러그인
- `kotlin("plugin.spring")` - Spring 지원 플러그인
- `kotlin("plugin.jpa")` - JPA 지원 플러그인
- `war` - WAR 패키징 플러그인

### 의존성 관리
모든 전자정부 프레임워크 의존성이 Gradle 형태로 변환되었습니다:
- eGovFrame Runtime Environment
- Spring Security
- Database 드라이버 (H2, MySQL)
- Kotlin 표준 라이브러리

## 🔧 Maven에서 Gradle로 마이그레이션된 항목

1. **빌드 스크립트**: `pom.xml` → `build.gradle.kts`
2. **의존성 관리**: Maven 형식 → Gradle 형식
3. **플러그인 설정**: Maven 플러그인 → Gradle 플러그인
4. **리소스 처리**: Maven 리소스 → Gradle 리소스

## 📝 주요 변경사항

### Kotlin 코드 개선
- **Data Class 사용**: VO 클래스들을 Kotlin data class로 변환
- **Null Safety**: Kotlin의 null 안전성 적용
- **스코프 함수**: `apply`, `let` 등을 활용한 간결한 코드
- **타입 추론**: 명시적 타입 선언 최소화

### 빌드 설정
- Java 11 타겟으로 업그레이드
- Lombok 의존성 제거 (Kotlin에서는 불필요)
- 중복 파일 처리 전략 설정

## 🎯 다음 단계

더 많은 Java 클래스를 Kotlin으로 점진적 마이그레이션:
1. Service 계층 클래스들
2. DAO 계층 클래스들
3. VO/Entity 클래스들
4. Controller 클래스들

## ✅ 검증된 기능

- ✅ Kotlin + Java 혼합 컴파일
- ✅ WAR 패키징
- ✅ JSP와 Kotlin 클래스 연동
- ✅ Spring Bean 설정 호환
- ✅ eGovFrame 라이브러리 호환