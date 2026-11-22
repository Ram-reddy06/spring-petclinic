FROM eclipse-temurin:21-jre-alpine AS build
COPY . /APP
WORKDIR /APP
RUN sudo apt install maven -y && \ mvn package -Dcheckstyle.skip

FROM eclipse-temurin:21-jre-alpine AS runtime
COPY --from=build /APP/target/*.jar devops/dev.jar
WORKDIR /devops
EXPOSE 8083
CMD ["java" , "-jar" , "dev.jar"]
