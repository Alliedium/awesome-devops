ARG BASE_IMAGE=gradle:7.5.1-jdk11-alpine
ARG PLATFORM=linux/amd64

FROM --platform=$PLATFORM $BASE_IMAGE AS compile
COPY complete /home/source/java
WORKDIR /home/source/java
# Default gradle user is `gradle`. We need to add permission on working directory for gradle to build.
USER root
RUN chown -R gradle /home/source/java
USER gradle
RUN gradle clean build

FROM --platform=$PLATFORM eclipse-temurin:11.0.16.1_1-jre-alpine
WORKDIR /home/application/java
COPY --from=compile "/home/source/java/build/libs/spring-boot-0.0.1-SNAPSHOT.jar" .
EXPOSE 8080
ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /home/application/java/spring-boot-0.0.1-SNAPSHOT.jar"]