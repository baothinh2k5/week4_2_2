package murach.download;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.naming.Context;

public class ConnectionPool {

    private static ConnectionPool pool = null;
    private static DataSource dataSource = null;

    // Constructor private: Chỉ gọi JNDI lookup 1 lần duy nhất
    private ConnectionPool() {
    try {
        InitialContext ic = new InitialContext();
        Context envContext = (Context) ic.lookup("java:/comp/env");
        
        // SỬA TẠI ĐÂY
        dataSource = (DataSource) envContext.lookup("jdbc/musicDB");
        
    } catch (NamingException e) {
        System.out.println("Lỗi JNDI Lookup: " + e);
    }
}

    public static synchronized ConnectionPool getInstance() {
        if (pool == null) {
            pool = new ConnectionPool();
        }
        return pool;
    }

    // Sửa lại hàm này để hiện lỗi chi tiết ra màn hình
    public Connection getConnection() {
        try {
            return dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            // Ném lỗi ra ngoài để hiện lên trang web 500
            throw new RuntimeException("LỖI KẾT NỐI DATABASE: " + e.getMessage(), e);
        }
    }

    public void freeConnection(Connection c) {
        try {
            if (c != null) {
                c.close(); // Trả kết nối về bể chứa (không đóng hẳn)
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}