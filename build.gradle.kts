import org.gradle.jvm.toolchain.JavaLanguageVersion

val egovVersion = "4.3.0"
val springFrameworkVersion = "5.3.37"
val springSecurityVersion = "5.7.11"
val junitVersion = "5.11.0"
val seleniumVersion = "4.13.0"
val lombokVersion = "1.18.34"

plugins {
    kotlin("jvm") version "1.9.24"
    kotlin("plugin.spring") version "1.9.24"
    kotlin("plugin.jpa") version "1.9.24"
    war
}

group = "egov"
version = "1.0.0"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(11))
    }
}

repositories {
    mavenCentral()
    maven {
        url = uri("https://maven.egovframe.go.kr/maven/")
    }
}

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

dependencies {
    // eGovFrame dependencies
    implementation("org.egovframe.rte:org.egovframe.rte.ptl.mvc:$egovVersion")
    implementation("org.egovframe.rte:org.egovframe.rte.psl.dataaccess:$egovVersion")
    implementation("org.egovframe.rte:org.egovframe.rte.fdl.idgnr:$egovVersion")
    implementation("org.egovframe.rte:org.egovframe.rte.fdl.property:$egovVersion")
    implementation("org.egovframe.rte:org.egovframe.rte.fdl.crypto:$egovVersion")

    implementation("org.egovframe.rte:org.egovframe.rte.fdl.security:$egovVersion") {
        exclude(group = "org.springframework", module = "spring-jdbc")
    }

    implementation(platform("org.springframework:spring-framework-bom:$springFrameworkVersion"))
    implementation(platform("org.springframework.security:spring-security-bom:$springSecurityVersion"))

    // Spring Security
    implementation("org.springframework.security:spring-security-core")
    implementation("org.springframework.security:spring-security-config")
    implementation("org.springframework.security:spring-security-web")

    // Database
    implementation("com.h2database:h2:2.1.214")
    implementation("com.mysql:mysql-connector-j:8.0.33")
    implementation("org.apache.commons:commons-dbcp2:2.12.0")

    // Servlet & JSP
    compileOnly("javax.servlet:javax.servlet-api:4.0.1")
    compileOnly("javax.servlet.jsp:javax.servlet.jsp-api:2.3.3")
    implementation("javax.servlet.jsp.jstl:jstl-api:1.2")
    implementation("org.apache.taglibs:taglibs-standard-impl:1.2.5")

    // Utilities
    implementation("commons-codec:commons-codec:1.17.0")
    implementation("cglib:cglib:3.3.0")
    implementation("org.antlr:antlr:3.5")
    implementation("org.apache.commons:commons-compress:1.26.2")
    implementation("commons-fileupload:commons-fileupload:1.5")
    implementation("com.ibm.icu:icu4j:75.1")
    implementation("org.jdom:jdom2:2.0.6.1")

    // JSON processing
    implementation("org.eclipse:yasson:1.0.2")
    implementation("org.glassfish:javax.json:1.1.4")

    // Logging
    implementation("com.googlecode.log4jdbc:log4jdbc:1.2") {
        exclude(group = "org.slf4j", module = "slf4j-api")
    }

    // Kotlin dependencies
    implementation("org.jetbrains.kotlin:kotlin-reflect")

    // Development tools
    compileOnly("org.projectlombok:lombok:$lombokVersion")
    annotationProcessor("org.projectlombok:lombok:$lombokVersion")
    testCompileOnly("org.projectlombok:lombok:$lombokVersion")
    testAnnotationProcessor("org.projectlombok:lombok:$lombokVersion")

    // Test dependencies
    testImplementation("org.junit.jupiter:junit-jupiter-api:$junitVersion")
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:$junitVersion")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit")
    testImplementation("org.seleniumhq.selenium:selenium-java:$seleniumVersion")
    testImplementation("org.springframework:spring-test:$springFrameworkVersion")
}

tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = "11"
    }
}

tasks.withType<JavaCompile> {
    options.release.set(11)
    options.encoding = "UTF-8"
}

tasks.withType<Test> {
    useJUnitPlatform()
    if (!project.hasProperty("runIntegrationTests")) {
        // Skip tests that require external services unless explicitly enabled.
        exclude("egovframework/let/cop/bbs/**")
        exclude("egovframework/let/uat/uia/web/EgovLoginControllerTestSelenium*")
    }
}

tasks.war {
    archiveBaseName.set("pst_webapp")
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
}

// Configure source sets to include both Java and Kotlin
sourceSets {
    main {
        java.srcDirs("src/main/java", "src/main/kotlin")
        resources.srcDirs("src/main/resources")
    }
    test {
        java.srcDirs("src/test/java", "src/test/kotlin")
        resources.srcDirs("src/test/resources")
    }
}

tasks.processResources {
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
}

tasks.processTestResources {
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
}
