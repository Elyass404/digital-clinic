<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; padding: 20px; color: #2c3e50; }
        .container { max-width: 900px; margin: auto; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        h1 { text-align: center; margin-bottom: 1rem; }
        .info { display: flex; justify-content: space-between; flex-wrap: wrap; gap: 1rem; margin-bottom: 2rem; }
        .info div { flex: 1 1 200px; background: #ecf0f1; padding: 1rem; border-radius: 6px; text-align: center; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; border-bottom: 1px solid #bdc3c7; text-align: center; }
        th { background-color: #3498db; color: #fff; }
        tr:hover { background-color: #f1f1f1; }
        .btn { padding: 6px 12px; border-radius: 4px; text-decoration: none; color: #fff; margin: 0 2px; font-size: 0.9rem; }
        .btn-edit { background-color: #f39c12; }
        .btn-delete { background-color: #e74c3c; }
        .btn-back { background-color: #95a5a6; margin-bottom: 1rem; display: inline-block; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/doctors" class="btn btn-back"><i class="fas fa-arrow-left"></i> Back to Doctors</a>
    <h1>Doctor Details</h1>

    <div class="info">
        <div><strong>First Name:</strong> ${doctor.firstName}</div>
        <div><strong>Last Name:</strong> ${doctor.lastName}</div>
        <div><strong>Email:</strong> ${doctor.email}</div>
        <div><strong>Specialty:</strong> ${doctor.specialty}</div>
        <div><strong>Department:</strong> ${doctor.department.name}</div>
    </div>

    <h2>Upcoming Consultations</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Patient</th>
            <th>Room</th>
            <th>Date</th>
            <th>Report</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${consultations}">
            <tr>
                <td>${c.id}</td>
                <td>${c.patient.firstName} ${c.patient.lastName}</td>
                <td>${c.room.name}</td>
                <td>${c.date}</td>
                <td>${c.report}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
