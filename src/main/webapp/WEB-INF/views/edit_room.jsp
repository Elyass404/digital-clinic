<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty room}">Edit Room</c:when><c:otherwise>Create Room</c:otherwise></c:choose> - Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', 'Roboto', Arial, sans-serif;
            background-color: #f8f9fa;
            color: #2c3e50;
            padding: 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 500px;
        }

        h1 {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .card {
            background: white;
            border-radius: 6px;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #bdc3c7;
            border-radius: 6px;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: #3498db;
            outline: none;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 1.5rem;
        }

        .actions .btn {
            flex: 1;
            padding: 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: #3498db;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-secondary {
            background-color: #95a5a6;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        @media (max-width: 576px) {
            .actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>
        <c:choose>
            <c:when test="${not empty room}"><i class="fas fa-edit"></i> Edit Room</c:when>
            <c:otherwise><i class="fas fa-plus"></i> Create Room</c:otherwise>
        </c:choose>
    </h1>

    <div class="card">
        <form action="${pageContext.request.contextPath}/rooms" method="post">
            <c:if test="${not empty room}">
                <input type="hidden" name="id" value="${room.id}">
                <input type="hidden" name="action" value="update">
            </c:if>
            <c:if test="${empty room}">
                <input type="hidden" name="action" value="create">
            </c:if>

            <div class="form-group">
                <label for="name" class="form-label">Room Name</label>
                <input type="text" id="name" name="name" class="form-control"
                       value="${room.name}" required placeholder="Enter room name">
            </div>

            <div class="form-group">
                <label for="capacity" class="form-label">Capacity</label>
                <input type="number" id="capacity" name="capacity" class="form-control"
                       value="${room.capacity}" required placeholder="Enter room capacity" min="1">
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-primary">
                    <c:choose>
                        <c:when test="${not empty room}"><i class="fas fa-save"></i> Save Changes</c:when>
                        <c:otherwise><i class="fas fa-plus"></i> Create Room</c:otherwise>
                    </c:choose>
                </button>
                <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
