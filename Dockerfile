# syntax=docker/dockerfile:1.7
# Multi-stage build for egovframe-portal-site-template.
# Stage 1 builds the war with Maven.
# Stage 2 serves it from Tomcat 10.1 on Temurin JRE 17.

# ---------- Build ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /workspace

COPY pom.xml ./
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -ntp dependency:go-offline

COPY src ./src
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -ntp -DskipTests package && \
    cp target/*.war /workspace/ROOT.war

# ---------- Runtime ----------
FROM tomcat:10.1-jre17

RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build /workspace/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# globals.properties DB 접속정보를 환경변수로 치환하는 entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=70 -XX:+ExitOnOutOfMemoryError"

EXPOSE 8080

ENTRYPOINT ["docker-entrypoint.sh"]
