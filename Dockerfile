# --- GIAI ĐOẠN 1: BUILD ỨNG DỤNG (Dùng Maven) ---
# Sử dụng image chứa sẵn Maven và Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Tạo thư mục làm việc trong container
WORKDIR /app

# Copy file cấu hình maven trước để tận dụng cache
COPY pom.xml .

# Copy toàn bộ source code vào container
COPY src ./src

# Chạy lệnh build (bỏ qua test unit để build nhanh hơn và tránh lỗi test vặt)
# Lệnh này sẽ tạo ra file .war trong thư mục /app/target/
RUN mvn clean package -DskipTests

# --- GIAI ĐOẠN 2: CHẠY ỨNG DỤNG (Dùng Tomcat) ---
# Sử dụng Tomcat 10 (Hỗ trợ Jakarta EE) và Java 17
FROM tomcat:10.1-jdk17

# Xóa các ứng dụng mặc định của Tomcat để sạch sẽ
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR từ GIAI ĐOẠN 1 sang thư mục webapps của Tomcat
# Đổi tên thành ROOT.war để truy cập trực tiếp qua http://localhost:8080/
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Mở port 8080
EXPOSE 8080

# Lệnh khởi động Tomcat
CMD ["catalina.sh", "run"]