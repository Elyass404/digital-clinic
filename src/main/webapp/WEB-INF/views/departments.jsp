<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --success: #4cc9f0;
            --danger: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --border: #dee2e6;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --radius: 8px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: var(--dark);
            line-height: 1.6;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .header h1 {
            color: var(--primary);
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .header p {
            color: var(--gray);
            font-size: 1.1rem;
        }

        .card {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .card-title {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-title i {
            font-size: 1.3rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid var(--border);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
            outline: none;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            border: none;
            border-radius: var(--radius);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-edit {
            background: var(--success);
            color: white;
            padding: 8px 15px;
            font-size: 0.9rem;
        }

        .btn-delete {
            background: var(--danger);
            color: white;
            padding: 8px 15px;
            font-size: 0.9rem;
        }

        .btn-edit:hover, .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .table-responsive {
            overflow-x: auto;
            border-radius: var(--radius);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .table th {
            background: var(--primary);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .table td {
            padding: 15px;
            border-bottom: 1px solid var(--border);
        }

        .table tr {
            transition: background 0.3s ease;
        }

        .table tr:hover {
            background: rgba(67, 97, 238, 0.05);
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--gray);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--border);
        }

        .notification {
            padding: 12px 20px;
            border-radius: var(--radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .notification-success {
            background: rgba(76, 201, 240, 0.1);
            border-left: 4px solid var(--success);
            color: #0a58ca;
        }

        .notification-error {
            background: rgba(247, 37, 133, 0.1);
            border-left: 4px solid var(--danger);
            color: #dc3545;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }

            .actions {
                flex-direction: column;
            }

            .btn-edit, .btn-delete {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header Section -->
    <div class="header">
        <h1><i class="fas fa-building"></i> Department Management</h1>
        <p>Manage your clinic's departments efficiently</p>
    </div>

    <!-- Add Department Form -->
    <div class="card">
        <h2 class="card-title"><i class="fas fa-plus-circle"></i> Add New Department</h2>
        <form action="${pageContext.request.contextPath}/departments" method="post">
            <div class="form-group">
                <input type="text" name="name" class="form-control" placeholder="Enter department name" required>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Department
            </button>
        </form>
    </div>

    <!-- Department List -->
    <div class="card">
        <h2 class="card-title"><i class="fas fa-list"></i> Department List</h2>

        <c:if test="${empty departments}">
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <h3>No Departments Found</h3>
                <p>Get started by adding your first department using the form above.</p>
            </div>
        </c:if>

        <c:if test="${not empty departments}">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="dep" items="${departments}">
                        <tr>
                            <td><strong>#${dep.id}</strong></td>
                            <td>${dep.name}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/departments?action=edit&id=${dep.id}"
                                   class="btn btn-edit">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/departments?action=delete&id=${dep.id}"
                                   class="btn btn-delete"
                                   onclick="return confirm('Are you sure you want to delete the ${dep.name} department?')">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>

<script>
    // Add some interactive animations
    document.addEventListener('DOMContentLoaded', function() {
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });
            button.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        // Add fade-in animation to table rows
        const tableRows = document.querySelectorAll('.table tbody tr');
        tableRows.forEach((row, index) => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            setTimeout(() => {
                row.style.transition = 'all 0.5s ease';
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>
</body>
</html>