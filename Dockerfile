FROM eclipse-temurin:21-jre

WORKDIR /app

COPY target/java-demo-1.0.0.jar app.jar

EXPOSE 9091

ENTRYPOINT ["java", "-jar", "app.jar"]
