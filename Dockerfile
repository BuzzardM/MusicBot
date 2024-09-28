# Stage 1: Build the JMusicBot application using a full JDK
FROM maven:3.9.9-eclipse-temurin-17 as build

# Set the working directory in the container
WORKDIR /build

# Copy the source code into the container
COPY . .

# Build the application using Maven
RUN mvn clean package -DskipTests

# Stage 2: Create the final image with only the built JAR file using a lightweight JRE
FROM eclipse-temurin:17-jre-alpine

# Set the working directory for the final image
WORKDIR /app

# Copy only the built JAR file from the build stage
COPY --from=build /build/target/JMusicBot-*.jar /app/JMusicBot.jar

# Set the default command to run the bot
CMD ["java", "-jar", "/app/JMusicBot.jar"]

# Expose the port (adjust if needed, depending on your bot's config)
EXPOSE 80
