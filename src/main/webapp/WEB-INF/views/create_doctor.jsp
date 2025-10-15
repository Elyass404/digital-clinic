<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinicdigital.model.Department" %>
<%@ page import="com.clinicdigital.repository.DepartmentRepository" %>

<%
    DepartmentRepository departmentRepo = new DepartmentRepository();
    List<Department> departments = departmentRepo.findAll();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Doctor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-primary">Add a New Doctor</h2>
        <a href="doctors.jsp" class="btn btn-secondary px-4">← Back to List</a>
    </div>

    <div class="card shadow-sm mx-auto" style="max-width: 700px;">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/doctors" method="post">
                <input type="hidden" name="action" value="create">

                <div class="row mb-3">
                    <div class="col">
                        <label for="firstName" class="form-label fw-semibold">First Name</label>
                        <input type="text" id="firstName" name="firstName" class="form-control" required>
                    </div>
                    <div class="col">
                        <label for="lastName" class="form-label fw-semibold">Last Name</label>
                        <input type="text" id="lastName" name="lastName" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label fw-semibold">Email</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label fw-semibold">Password</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="speciality" class="form-label fw-semibold">Speciality</label>
                    <input type="text" id="speciality" name="speciality" class="form-control" required>
                </div>

                <div class="mb-4">
                    <label for="departmentId" class="form-label fw-semibold">Department</label>
                    <select id="departmentId" name="departmentId" class="form-select" required>
                        <option value="">-- Select Department --</option>
                        <% for (Department dept : departments) { %>
                        <option value="<%= dept.getId() %>"><%= dept.getName() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-primary px-5">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
