package com.clinicdigital.controller;

import com.clinicdigital.model.Department;
import com.clinicdigital.repository.DepartmentRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/departments")
public class DepartmentServlet extends HttpServlet {

    private final DepartmentRepository repo = new DepartmentRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // normal thing to list all departments
            List<Department> departments = repo.findAll();
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("/WEB-INF/views/departments.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            // show edit form for a specific department
            int id = Integer.parseInt(request.getParameter("id"));
            Department department = repo.findDepartmentById(id);
            request.setAttribute("department", department);
            request.getRequestDispatcher("/WEB-INF/views/edit_department.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            // delete department
            int id = Integer.parseInt(request.getParameter("id"));
            repo.deleteDepartment(id);
            response.sendRedirect(request.getContextPath() + "/departments");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("create")) {
            // create a new department
            String name = request.getParameter("name");
            if (name != null && !name.trim().isEmpty()) {
                Department dep = new Department(name.trim());
                repo.save(dep);
            }
            response.sendRedirect(request.getContextPath() + "/departments");

        } else if (action.equals("update")) {
            //update an existing department
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            Department dep = repo.findDepartmentById(id);
            if (dep != null && name != null && !name.trim().isEmpty()) {
                dep.setName(name.trim());
                repo.updateDepartment(dep);
            }
            response.sendRedirect(request.getContextPath() + "/departments");
        }
    }
}
