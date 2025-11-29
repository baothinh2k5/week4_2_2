package murach.download;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class DownloadServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        // Lấy tham số action
        String action = request.getParameter("action");
        if (action == null) {
            action = "viewAlbums";
        }

        String url = "/index.jsp";

        // --- 1. XEM DANH SÁCH ALBUM ---
        if (action.equals("viewAlbums")) {
            url = "/index.jsp";
        }

        // --- 2. KIỂM TRA USER (KHI BẤM TẢI NHẠC) ---
        else if (action.equals("checkUser")) {
            String productCode = request.getParameter("productCode");
            HttpSession session = request.getSession();
            session.setAttribute("productCode", productCode);

            // Kiểm tra Cookie
            Cookie[] cookies = request.getCookies();
            String emailAddress = CookieUtil.getCookieValue(cookies, "emailCookie");

            if (emailAddress == null || emailAddress.equals("")) {
                url = "/register.jsp"; // Chưa đăng ký -> đi đăng ký
            } else {
                url = "/download.jsp"; // Đã có cookie -> cho tải
            }
        }

        // --- 3. ĐĂNG KÝ USER (LƯU VÀO SUPABASE) ---
        else if (action.equals("registerUser")) {
            String email = request.getParameter("email");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");

            User user = new User(firstName, lastName, email);

            // GỌI HÀM INSERT VÀO DB
            int result = UserDB.insert(user);
            if (result > 0) {
                System.out.println("Thành công: Đã lưu user " + email + " vào Supabase.");
            } else {
                System.err.println("Lỗi: Không thể lưu user (Kiểm tra Console log).");
            }

            // Lưu session và Cookie
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            Cookie c = new Cookie("emailCookie", email);
            c.setMaxAge(60 * 60 * 24 * 365 * 3); // 3 năm
            c.setPath("/");
            response.addCookie(c);

            url = "/download.jsp";
        }

        // --- 4. [MỚI] CHỨC NĂNG SQL GATEWAY (Hiện danh sách User) ---
        else if (action.equals("executeSql")) {
            String sql = request.getParameter("sqlStatement");
            
            // Gọi hàm trong UserDB để lấy bảng HTML
            String sqlResult = UserDB.htmlTableFromQuery(sql);

            // Gửi kết quả về lại trang JSP
            request.setAttribute("sqlStatement", sql);
            request.setAttribute("sqlResult", sqlResult);

            url = "/download.jsp";
        }

        // --- 5. [MỚI] CHỨC NĂNG ĐĂNG XUẤT ---
        else if (action.equals("logout")) {
            // Xóa Cookie (Set tuổi thọ = 0)
            Cookie c = new Cookie("emailCookie", "");
            c.setMaxAge(0);
            c.setPath("/");
            response.addCookie(c);

            // Hủy Session
            HttpSession session = request.getSession();
            session.invalidate();

            // Quay về trang chủ
            url = "/index.jsp";
        }

        // Chuyển hướng
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request, response);
    }
}