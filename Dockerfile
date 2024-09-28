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
COPY --from=build /build/target/JMusicBot-*.jar ./JMusicBot.jar
COPY --from=build /build/scripts/docker_entrypoint.sh ./docker_entrypoint.sh
COPY --from=build /build/example_config.txt ./config/example_config.txt

# Set the default command to run the bot
ENTRYPOINT ["sh", "docker_entrypoint.sh"]
