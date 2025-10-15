package com.clinicdigital.controller;

import com.clinicdigital.model.Doctor;
import com.clinicdigital.model.Department;
import com.clinicdigital.repository.DoctorRepository;
import com.clinicdigital.repository.DepartmentRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/doctors")
public class DoctorServlet extends HttpServlet {

    private final DoctorRepository doctorRepo = new DoctorRepository();
    private final DepartmentRepository departmentRepo = new DepartmentRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // List all doctors
            List<Doctor> doctors = doctorRepo.findAll();
            List<Department> departments = departmentRepo.findAll();
            request.setAttribute("doctors", doctors);
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("/WEB-INF/views/doctors.jsp").forward(request, response);
            return;
        }

        switch (action) {

            case "create": {
                // Show the page to add a new doctor
                List<Department> departments = departmentRepo.findAll();
                request.setAttribute("departments", departments);
                request.getRequestDispatcher("/WEB-INF/views/create_doctor.jsp").forward(request, response);
                break;
            }

            case "edit": {
                String idStr = request.getParameter("id");
                if (idStr == null) {
                    response.sendRedirect(request.getContextPath() + "/doctors");
                    return;
                }
                try {
                    Long id = Long.parseLong(idStr);
                    Doctor doctor = doctorRepo.findById(id);
                    if (doctor == null) {
                        response.sendRedirect(request.getContextPath() + "/doctors");
                        return;
                    }
                    List<Department> departments = departmentRepo.findAll();
                    request.setAttribute("doctor", doctor);
                    request.setAttribute("departments", departments);
                    request.getRequestDispatcher("/WEB-INF/views/edit_doctor.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/doctors");
                }
                break;
            }

            case "delete": {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    try {
                        Long id = Long.parseLong(idStr);
                        doctorRepo.delete(id);
                    } catch (NumberFormatException ignored) {}
                }
                response.sendRedirect(request.getContextPath() + "/doctors");
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/doctors");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("create")) {
            // CREATE doctor
            String firstname = request.getParameter("firstName");
            String lastname = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String speciality = request.getParameter("speciality");
            String deptIdStr = request.getParameter("departmentId");

            if (firstname == null || lastname == null || deptIdStr == null
                    || firstname.trim().isEmpty() || lastname.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/doctors");
                return;
            }

            try {
                int deptId = Integer.parseInt(deptIdStr);
                Department department = departmentRepo.findDepartmentById(deptId);
                if (department != null) {
                    Doctor doctor = new Doctor();
                    doctor.setFirstName(firstname.trim());
                    doctor.setLastName(lastname.trim());
                    doctor.setEmail(email != null ? email.trim() : "");
                    doctor.setPassword(password != null ? password.trim() : "");
                    doctor.setSpecialty(speciality != null ? speciality.trim() : "");
                    doctor.setDepartment(department);
                    doctorRepo.save(doctor);
                }
            } catch (NumberFormatException ignored) {}

            response.sendRedirect(request.getContextPath() + "/doctors");
            return;
        }

        if (action.equals("update")) {
            // UPDATE doctor
            String idStr = request.getParameter("id");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String speciality = request.getParameter("speciality");
            String deptIdStr = request.getParameter("department_id");

            if (idStr == null) {
                response.sendRedirect(request.getContextPath() + "/doctors");
                return;
            }

            try {
                Long id = Long.parseLong(idStr);
                Doctor doctor = doctorRepo.findById(id);
                if (doctor == null) {
                    response.sendRedirect(request.getContextPath() + "/doctors");
                    return;
                }

                if (firstname != null && !firstname.trim().isEmpty())
                    doctor.setFirstName(firstname.trim());
                if (lastname != null && !lastname.trim().isEmpty())
                    doctor.setLastName(lastname.trim());
                if (email != null)
                    doctor.setEmail(email.trim());
                if (speciality != null)
                    doctor.setSpecialty(speciality.trim());
                if (deptIdStr != null && !deptIdStr.isEmpty()) {
                    try {
                        int deptId = Integer.parseInt(deptIdStr);
                        Department department = departmentRepo.findDepartmentById(deptId);
                        if (department != null) {
                            doctor.setDepartment(department);
                        }
                    } catch (NumberFormatException ignored) {}
                }

                doctorRepo.update(doctor);
            } catch (NumberFormatException ignored) {}

            response.sendRedirect(request.getContextPath() + "/doctors");
        }
    }
}
