package com.clinicdigital.controller;

import com.clinicdigital.model.enums.RoleEnum;
import com.clinicdigital.model.User;
import com.clinicdigital.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "logout" -> {
                HttpSession session = request.getSession(false);
                if (session != null) session.invalidate();
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
            case "register" -> request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            default -> request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "login" -> handleLogin(request, response);
            case "register" -> handleRegister(request, response);
            default -> request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userService.logIn(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(60 * 60); //  60 min session timeout

            switch (user.getRole()) {
                case ADMIN -> response.sendRedirect("admin-dashboard.jsp");
                case DOCTOR -> response.sendRedirect("doctor-dashboard.jsp");
                case PATIENT -> response.sendRedirect("patient-dashboard.jsp");
                default -> request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPassword(password);

        try {
            user.setRole(RoleEnum.valueOf(role.toUpperCase()));
        } catch (IllegalArgumentException | NullPointerException e) {
            request.setAttribute("error", "Invalid role selection.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        boolean isRegistered = userService.register(user);

        if (isRegistered) {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Email already exists or registration failed.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}
