# Start from an official JAVA 17 Runtime Image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

#Copy the jar file
COPY demo-helloworld-webapp-0.0.1-SNAPSHOT.jar app.jar

#Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
