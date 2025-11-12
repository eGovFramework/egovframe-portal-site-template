# syntax=docker/dockerfile:1.6

##
## Build stage
##
ARG GRADLE_BASE_IMAGE=gradle:8.5-jdk11
FROM ${GRADLE_BASE_IMAGE} AS build

WORKDIR /workspace

# Copy the whole project (heavy artifacts are filtered via .dockerignore).
COPY . .

RUN chmod +x gradlew

# Skip integration tests by default; enable with --build-arg RUN_TESTS=true once external
# dependencies (MySQL, Selenium) are available in the build environment.
ARG RUN_TESTS=false
RUN --mount=type=cache,target=/home/gradle/.gradle \
    --mount=type=cache,target=/workspace/.gradle \
    if [ "$RUN_TESTS" = "true" ]; then \
        ./gradlew build ; \
    else \
        ./gradlew build -x test ; \
    fi

##
## Runtime stage
##
FROM tomcat:9.0-jdk11-temurin

ENV CATALINA_OPTS="-Xms512m -Xmx1024m"

WORKDIR /usr/local/tomcat

# Deploy the generated WAR as ROOT for convenience.
COPY --from=build /workspace/build/libs/pst_webapp-*.war ./webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
