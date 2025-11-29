package murach.download;

import java.sql.*;

public class UserDB {

    public static int insert(User user) {
        // [Cite Slide 34] Lấy ConnectionPool instance
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;

        String query = "INSERT INTO users (email, first_name, last_name) " +
                       "VALUES (?, ?, ?)";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            
            return ps.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            // [Cite Slide 37] Đóng Statement và trả kết nối về Pool
            closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }

    private static void closePreparedStatement(Statement ps) {
        try {
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public static String htmlTableFromQuery(String query) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        StringBuilder html = new StringBuilder();

        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            
            // Lấy thông tin cột (Metadata)
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            // Bắt đầu tạo bảng HTML
            html.append("<table>");
            
            // Tạo hàng tiêu đề
            html.append("<tr>");
            for (int i = 1; i <= columnCount; i++) {
                html.append("<th>").append(metaData.getColumnName(i)).append("</th>");
            }
            html.append("</tr>");

            // Tạo các hàng dữ liệu
            while (rs.next()) {
                html.append("<tr>");
                for (int i = 1; i <= columnCount; i++) {
                    html.append("<td>").append(rs.getString(i)).append("</td>");
                }
                html.append("</tr>");
            }
            html.append("</table>");
            
            return html.toString();

        } catch (SQLException e) {
            return "<p style='color:red'>Lỗi SQL: " + e.getMessage() + "</p>";
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            pool.freeConnection(connection);
        }
    }
}