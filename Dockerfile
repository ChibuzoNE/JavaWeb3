# Use Maven to build the app with JDK 17
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the project files
COPY . .

# Build the app and package it as a WAR
RUN mvn clean package -DskipTests

# Use Tomcat as base image to run the app
FROM tomcat:9.0

# Remove default web apps and deploy our WAR
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the build stage to Tomcat's webapps folder
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the application on port 8080
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]

