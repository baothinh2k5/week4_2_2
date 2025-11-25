package murach.download;

import java.io.*;
import jakarta.servlet.*;      // Thay đổi từ javax sang jakarta
import jakarta.servlet.http.*; // Thay đổi từ javax sang jakarta

public class DownloadServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "viewAlbums";  
        }

        String url = "/index.jsp";
        
        if (action.equals("viewAlbums")) {
            url = "/index.jsp";
        } 
        else if (action.equals("checkUser")) {
            String productCode = request.getParameter("productCode");
            HttpSession session = request.getSession();
            session.setAttribute("productCode", productCode);
            
            User user = (User) session.getAttribute("user");

            Cookie[] cookies = request.getCookies();
            String emailAddress = CookieUtil.getCookieValue(cookies, "emailCookie");

            if (emailAddress == null || emailAddress.equals("")) {
                url = "/register.jsp";
            } 
            else {
                url = "/download.jsp";
            }
        } 
        else if (action.equals("registerUser")) {
            String email = request.getParameter("email");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");

            User user = new User(firstName, lastName, email);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            Cookie c = new Cookie("emailCookie", email);
            c.setMaxAge(60 * 60 * 24 * 365 * 3); 
            c.setPath("/"); 
            response.addCookie(c);

            url = "/download.jsp";
        }

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request, response);
    }
}