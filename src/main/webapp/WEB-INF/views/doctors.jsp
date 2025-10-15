<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinicdigital.model.Doctor" %>
<%@ page import="com.clinicdigital.repository.DoctorRepository" %>

<%
    DoctorRepository doctorRepo = new DoctorRepository();
    List<Doctor> doctors = doctorRepo.findAll();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctors Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-primary">Doctors</h2>
        <a href="doctors?action=create" class="btn btn-success px-4">+ Add Doctor</a>

    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-hover align-middle text-center">
                <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Speciality</th>
                    <th>Department</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Doctor doctor : doctors) {
                %>
                <tr>
                    <td><%= doctor.getId() %></td>
                    <td><%= doctor.getFirstName() %></td>
                    <td><%= doctor.getLastName() %></td>
                    <td><%= doctor.getEmail() %></td>
                    <td><%= doctor.getSpecialty() %></td>
                    <td><%= doctor.getDepartment() != null ? doctor.getDepartment().getName() : "hello" %></td>
                    <td>
                        <a href="DoctorServlet?action=show&id=<%= doctor.getId() %>" class="btn btn-info btn-sm me-1">Show</a>
                        <a href="DoctorServlet?action=edit&id=<%= doctor.getId() %>" class="btn btn-warning btn-sm me-1">Edit</a>
                        <a href="DoctorServlet?action=delete&id=<%= doctor.getId() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this doctor?');">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>
