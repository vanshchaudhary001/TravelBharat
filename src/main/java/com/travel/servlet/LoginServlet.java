package com.travel.servlet;

import com.travel.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final Map<String, User> USERS = new HashMap<>();

    static {
        USERS.put("vansh", new User("vansh", "vansh123", "Vansh Kumar", "vansh@travel.com"));
        USERS.put("admin", new User("admin", "admin123", "Admin User", "admin@travel.com"));
        USERS.put("rahul", new User("rahul", "rahul123", "Rahul Sharma", "rahul@travel.com"));
        USERS.put("priya", new User("priya", "priya123", "Priya Singh", "priya@travel.com"));
        USERS.put("demo", new User("demo", "demo123", "Demo User", "demo@travel.com"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null) {
            request.setAttribute("error", "Please enter username and password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        username = username.trim().toLowerCase();
        User user = USERS.get(username);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            response.sendRedirect("planner.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password. Try: vansh / vansh123");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
