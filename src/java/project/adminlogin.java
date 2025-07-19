package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "adminlogin", urlPatterns = {"/adminlogin"})
public class adminlogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String driverName = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/ejproj"; // ✅ Ensure database name is correct
            String dbuser = "root";
            String dbpass = "";
            String sql = "SELECT id, email FROM adminlog WHERE email=? AND password=?";

            try {
                if (email != null && pass != null) {
                    Class.forName(driverName);
                    conn = DriverManager.getConnection(url, dbuser, dbpass);
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, email);
                    ps.setString(2, pass);
                    
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String id = rs.getString("id"); // ✅ Getting ID from database
                        String emailid = rs.getString("email"); // ✅ Getting Email from database

                        // ✅ Debugging output
                        System.out.println("DEBUG: Admin found. ID: " + id + ", Email: " + emailid);

                        HttpSession hs = request.getSession();
                        hs.setAttribute("id", id);
                        hs.setAttribute("email", emailid);

                        // ✅ Redirecting properly
                        response.sendRedirect("adminhome.jsp");
                    } else {
                        System.out.println("DEBUG: Login failed for email: " + email);

                        HttpSession hs = request.getSession();
                        hs.setAttribute("err", "User Credentials Incorrect");
                        response.sendRedirect("adminlogin.jsp"); // ✅ Redirect to login page with error
                    }
                } else {
                    System.out.println("DEBUG: Email or Password is NULL");
                    response.getWriter().println("Error: Email or Password cannot be empty.");
                }
            } catch (Exception e) {
                e.printStackTrace(); // ✅ Print error details to console
                response.getWriter().println("Error: " + e.getMessage()); // ✅ Show error in browser
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
