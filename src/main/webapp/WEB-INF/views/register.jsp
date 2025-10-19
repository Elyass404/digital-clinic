<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - ClinicDigital</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">

<div class="card shadow p-4" style="width: 450px;">
    <h3 class="text-center mb-4 text-primary fw-bold">Create Account</h3>

    <!-- Show error message if any -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/user" method="post">
        <input type="hidden" name="action" value="register">

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="firstName" class="form-label fw-semibold">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" required>
            </div>
            <div class="col-md-6 mb-3">
                <label for="lastName" class="form-label fw-semibold">Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label fw-semibold">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label fw-semibold">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <div class="mb-4">
            <label for="role" class="form-label fw-semibold">Role</label>
            <select id="role" name="role" class="form-select" required>
                <option value="">-- Select Role --</option>
                <option value="ADMIN">Admin</option>
                <option value="DOCTOR">Doctor</option>
                <option value="PATIENT">Patient</option>
            </select>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-success">Register</button>
        </div>

        <p class="mt-3 text-center">
            Already have an account?
            <a href="${pageContext.request.contextPath}/user" class="text-decoration-none">Login here</a>
        </p>
    </form>
</div>

</body>
</html>
