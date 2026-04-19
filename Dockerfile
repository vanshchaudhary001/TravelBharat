# Stage 1: Build the Java application using Maven
FROM maven:3.9-amazoncorretto-11 AS build
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jre11
WORKDIR /usr/local/tomcat

# Remove the default ROOT application to avoid conflicts
RUN rm -rf webapps/ROOT

# Copy the WAR file from the build stage and rename it to ROOT.war
# This ensures your app is accessible at the root URL (e.g., your-app.onrender.com/)
COPY --from=build /app/target/TravelPlanner.war webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
