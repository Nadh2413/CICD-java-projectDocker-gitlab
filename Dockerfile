### Project shoeshop - Spring Boot
#Build stage

FROM maven:3.5.3-jdk-8-alpine as build
  
WORKDIR /app
#copy foder hien tai o server vao trong container
COPY . .
#thuc hien lenh build  
RUN mvn install -DskipTests=true

#Run stage

FROM alpine:3.19.1
# create user
RUN adduser -D shoeshop

RUN apk add openjdk8

WORKDIR /run
COPY --from=build /app/target/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar
# change quyen so huu
RUN chown -R shoeshop:shoeshop /run
# sử dụng user shoeshop để run
USER shoeshop


EXPOSE 8080
ENTRYPOINT java -jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar
