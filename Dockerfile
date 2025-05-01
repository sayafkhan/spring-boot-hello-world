# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /home/app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

# Runtime stage
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /home/app

COPY --from=build /home/app/target/spring-boot-hello-world-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

