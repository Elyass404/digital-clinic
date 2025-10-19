<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - ClinicDigital</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">

<div class="card shadow p-4" style="width: 380px;">
    <h3 class="text-center mb-4 text-primary fw-bold">User Login</h3>

    <!-- Show error message if any -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/user" method="post">
        <input type="hidden" name="action" value="login">

        <div class="mb-3">
            <label for="email" class="form-label fw-semibold">Email</label>
            <input type="email" class="form-control" id="email" name="email" required placeholder="Enter your email">
        </div>

        <div class="mb-3">
            <label for="password" class="form-label fw-semibold">Password</label>
            <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Login</button>
        </div>

        <p class="mt-3 text-center">
            Don’t have an account?
            <a href="${pageContext.request.contextPath}/user?action=register" class="text-decoration-none">Register here</a>
        </p>
    </form>
</div>

</body>
</html>
