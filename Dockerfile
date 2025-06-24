# Stage 1: Build the Java app
FROM maven:3.8.6-openjdk-17 AS builder
WORKDIR /app

# Copy source code
COPY . .

# Build the application using Maven
RUN mvn clean package -DskipTests

# Stage 2: Run the app using JDK (no Maven)
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the JAR from the builder stage
COPY --from=builder /app/target/demo-helloworld-webapp-0.0.1-SNAPSHOT.jar app.jar

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
