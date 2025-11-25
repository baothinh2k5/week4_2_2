# Bước 1: Build bằng Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Lệnh này sẽ tạo ra file download-app.war trong thư mục target/
RUN mvn clean package

# Bước 2: Chạy trên Tomcat 10
FROM tomcat:10.1-jdk17
# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy file war đã build ở bước 1 vào và đổi tên thành ROOT.war
COPY --from=build /app/target/download-app.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]