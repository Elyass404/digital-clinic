package com.clinicdigital.controller;

import com.clinicdigital.model.Patient;
import com.clinicdigital.repository.PatientRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {

    private final PatientRepository repo = new PatientRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            List<Patient> patients = repo.findAll();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/WEB-INF/views/patients.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "create":
                request.getRequestDispatcher("/WEB-INF/views/create_patient.jsp").forward(request, response);
                break;

            case "edit": {
                String idStr = request.getParameter("id");
                if (idStr == null) {
                    response.sendRedirect(request.getContextPath() + "/patients");
                    return;
                }
                try {
                    Long id = Long.parseLong(idStr);
                    Patient patient = repo.findById(id);
                    if (patient == null) {
                        response.sendRedirect(request.getContextPath() + "/patients");
                        return;
                    }
                    request.setAttribute("patient", patient);
                    request.getRequestDispatcher("/WEB-INF/views/edit_patient.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/patients");
                }
                break;
            }

            case "delete": {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    try {
                        Long id = Long.parseLong(idStr);
                        repo.delete(id);
                    } catch (NumberFormatException ignored) {}
                }
                response.sendRedirect(request.getContextPath() + "/patients");
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/patients");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("create")) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password"); // hash in real app
            String weightStr = request.getParameter("weight");
            String heightStr = request.getParameter("height");

            Double weight = null;
            Double height = null;
            try {
                if (weightStr != null && !weightStr.isEmpty()) weight = Double.parseDouble(weightStr);
                if (heightStr != null && !heightStr.isEmpty()) height = Double.parseDouble(heightStr);
            } catch (NumberFormatException ignored) {}

            if (firstName == null || lastName == null || firstName.trim().isEmpty() || lastName.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/patients");
                return;
            }

            Patient p = new Patient(firstName.trim(), lastName.trim(), email != null ? email.trim() : "",
                    password != null ? password : "", weight, height);
            repo.save(p);
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }

        if (action.equals("update")) {
            String idStr = request.getParameter("id");
            if (idStr == null) {
                response.sendRedirect(request.getContextPath() + "/patients");
                return;
            }
            try {
                Long id = Long.parseLong(idStr);
                Patient patient = repo.findById(id);
                if (patient == null) {
                    response.sendRedirect(request.getContextPath() + "/patients");
                    return;
                }

                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String weightStr = request.getParameter("weight");
                String heightStr = request.getParameter("height");

                if (firstName != null && !firstName.trim().isEmpty()) patient.setFirstName(firstName.trim());
                if (lastName != null && !lastName.trim().isEmpty()) patient.setLastName(lastName.trim());
                if (email != null) patient.setEmail(email.trim());
                if (password != null) patient.setPassword(password); // hash in real app

                try {
                    if (weightStr != null && !weightStr.isEmpty()) patient.setWeight(Double.parseDouble(weightStr));
                    if (heightStr != null && !heightStr.isEmpty()) patient.setHeight(Double.parseDouble(heightStr));
                } catch (NumberFormatException ignored) {}

                repo.update(patient);
            } catch (NumberFormatException ignored) {}

            response.sendRedirect(request.getContextPath() + "/patients");
        }
    }
}
