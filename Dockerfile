# syntax=docker/dockerfile:1.7
#########################################################
# 목적 : egovframe-portal-site-template WAR 를 구동하는 도커 이미지 생성 (멀티 스테이지 빌드)
#   1단계(build)   : Maven 으로 WAR 빌드 후 ROOT 로 전개 (사전에 mvn package 불필요)
#   2단계(runtime) : Tomcat 10.1(JRE 17) 에 배포, root 가 아닌 계정(UID/GID 1000)으로 구동
#   컨텍스트 경로 : / (ROOT)
#   DB : 기본 내장 HSQLDB, GLOBALS_* 환경변수 지정 시 외부 DB (globals.properties 보다 우선)
# 실행방법 : 프로젝트 루트디렉토리에서(Dockerfile 경로) 아래 명령어 실행
# (명령어) docker build -t egovframe-portal-site-template:5.1.0 .
# 접속 URL : http://localhost:8080/
#########################################################

# ---------- Build ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /workspace

COPY pom.xml ./
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -ntp dependency:go-offline

COPY src ./src
# 내장 HSQL DB 초기화 스크립트 (pom.xml 에서 classpath:/db/hsql 로 패키징)
COPY DATABASE/hsql ./DATABASE/hsql
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -ntp -DskipTests -Dmaven.javadoc.skip=true -Dpmd.skip=true package && \
    mkdir -p /workspace/ROOT && \
    cd /workspace/ROOT && jar xf /workspace/target/*.war

# ---------- Runtime ----------
FROM tomcat:10.1-jre17 AS runtime

LABEL org.opencontainers.image.title="egovframe-portal-site-template" \
      org.opencontainers.image.version="5.1.0" \
      org.opencontainers.image.url="https://www.egovframe.go.kr" \
      org.opencontainers.image.licenses="Apache-2.0"

# 기본 webapps 제거, 첨부파일 경로 생성 및 실행 계정(UID/GID 1000) 권한 부여 (k8s runAsUser 와 동일)
RUN rm -rf /usr/local/tomcat/webapps/* && \
    mkdir -p /upload/pst && \
    chown -R 1000:1000 /upload /usr/local/tomcat/webapps /usr/local/tomcat/work \
        /usr/local/tomcat/temp /usr/local/tomcat/logs

COPY --from=build --chown=1000:1000 /workspace/ROOT /usr/local/tomcat/webapps/ROOT
USER 1000:1000

ENV JAVA_OPTS="-XX:MaxRAMPercentage=75 -XX:+ExitOnOutOfMemoryError"

# 첨부파일 저장 경로 (Globals.fileStorePath)
VOLUME ["/upload"]

# 웹서버 포트
EXPOSE 8080

# 헬스체크
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD curl -fsS -o /dev/null http://127.0.0.1:8080/ || exit 1

# 컨테이너 시작 시 Tomcat 구동
ENTRYPOINT ["catalina.sh","run"]
