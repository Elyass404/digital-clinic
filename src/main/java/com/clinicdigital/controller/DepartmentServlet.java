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

    private final  DepartmentRepository repo = new DepartmentRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        List<Department> departments = repo.findAll();

        request.setAttribute("departments",departments);

        request.getRequestDispatcher("/WEB-INF/views/departments.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String name = request.getParameter("name");
        if(name != null && !name.trim().isEmpty()){
            Department dep = new Department(name.trim());
            repo.save(dep);
        }

        response.sendRedirect(request.getContextPath()+"/departments");
    }
}
