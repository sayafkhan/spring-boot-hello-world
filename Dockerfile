FROM maven:3.8.7-openjdk-17 AS build

WORKDIR /home/app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

# Use a slim runtime image
FROM openjdk:17-jdk-slim

WORKDIR /home/app

COPY --from=build /home/app/target/spring-boot-hello-world-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
