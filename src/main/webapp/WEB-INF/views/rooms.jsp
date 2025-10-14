<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management - Clinic System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --primary-light: #34495e;
            --secondary: #3498db;
            --success: #27ae60;
            --danger: #e74c3c;
            --warning: #f39c12;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gray: #95a5a6;
            --border: #bdc3c7;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --radius: 6px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
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
            transition: var(--transition);
        }

        .card:hover {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
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

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--primary);
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: var(--transition);
            background-color: white;
        }

        .form-control:focus {
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            outline: none;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: var(--radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
        }

        .btn-primary {
            background-color: var(--secondary);
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-edit {
            background-color: var(--success);
            color: white;
            padding: 8px 15px;
            font-size: 0.9rem;
        }

        .btn-delete {
            background-color: var(--danger);
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
            background: rgba(44, 62, 80, 0.05);
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .capacity-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: var(--light);
            color: var(--primary);
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
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

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
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
        <h1><i class="fas fa-door-open"></i> Room Management</h1>
        <p>Manage clinic rooms and their capacities</p>
    </div>

    <!-- Add Room Form -->
    <div class="card">
        <h2 class="card-title"><i class="fas fa-plus-circle"></i> Add New Room</h2>
        <form action="${pageContext.request.contextPath}/rooms" method="post">
            <div class="form-grid">
                <div class="form-group">
                    <label for="name" class="form-label">Room Name</label>
                    <input type="text" id="name" name="name" class="form-control"
                           placeholder="Enter room name (e.g., Operation Room 1)" required>
                </div>
                <div class="form-group">
                    <label for="capacity" class="form-label">Capacity</label>
                    <input type="number" id="capacity" name="capacity" class="form-control"
                           placeholder="Enter capacity" min="1" max="100" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Room
            </button>
        </form>
    </div>

    <!-- Room List -->
    <div class="card">
        <h2 class="card-title"><i class="fas fa-list"></i> Room List</h2>

        <c:if test="${empty rooms}">
            <div class="empty-state">
                <i class="fas fa-door-closed"></i>
                <h3>No Rooms Found</h3>
                <p>Get started by adding your first room using the form above.</p>
            </div>
        </c:if>

        <c:if test="${not empty rooms}">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Capacity</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="room" items="${rooms}">
                        <tr>
                            <td><strong>#${room.idRoom}</strong></td>
                            <td>${room.name}</td>
                            <td>
                                        <span class="capacity-badge">
                                            <i class="fas fa-users"></i> ${room.capacity}
                                        </span>
                            </td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.idRoom}"
                                   class="btn btn-edit">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.idRoom}"
                                   class="btn btn-delete"
                                   onclick="return confirm('Are you sure you want to delete the ${room.name} room?')">
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
    // Add interactive animations
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

        // Form validation for capacity
        const capacityInput = document.getElementById('capacity');
        if (capacityInput) {
            capacityInput.addEventListener('input', function() {
                if (this.value < 1) {
                    this.setCustomValidity('Capacity must be at least 1');
                } else if (this.value > 100) {
                    this.setCustomValidity('Capacity cannot exceed 100');
                } else {
                    this.setCustomValidity('');
                }
            });
        }
    });
</script>
</body>
</html>