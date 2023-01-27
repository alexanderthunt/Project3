FROM maven:3-adoptopenjdk-11 as builder
COPY ./src src
COPY ./pom.xml pom.xml
RUN mvn package
FROM openjdk:11-jdk-slim
COPY --from=builder target/planetarium-1.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]