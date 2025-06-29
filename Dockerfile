# ----------- Stage 1: Build ----------------
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build

WORKDIR /app

COPY . /app

# Create a directory for the JAR file
RUN mvn clean install -DskipTests=true

# ----------- Stage 2: Runtime --------------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the built JAR file from the build stage
# Adjust the path if your JAR file is located elsewhere
COPY --from=build /app/target/spring-boot-crud-example-2-0.0.1-SNAPSHOT.jar /app/target/productApp.jar

# Expose the port the app runs on
EXPOSE 8080

CMD ["java", "-jar", "/app/target/productApp.jar"]