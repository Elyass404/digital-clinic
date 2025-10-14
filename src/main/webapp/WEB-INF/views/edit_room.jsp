<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Room - Clinic System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --primary-light: #34495e;
            --secondary: #3498db;
            --success: #27ae60;
            --danger: #e74c3c;
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
            background-color: #f8f9fa;
            color: var(--dark);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 600px;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .header h1 {
            color: var(--primary);
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
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
            padding: 2rem;
            transition: var(--transition);
        }

        .card:hover {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
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

        .form-hint {
            display: block;
            margin-top: 0.5rem;
            font-size: 0.875rem;
            color: var(--gray);
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
        }

        .btn-secondary {
            background-color: var(--light);
            color: var(--dark);
        }

        .btn-secondary:hover {
            background-color: #d5dbdb;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 2rem;
        }

        .actions .btn {
            flex: 1;
        }

        .id-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background-color: var(--light);
            color: var(--primary);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
        }

        .capacity-info {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--gray);
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }

            .card {
                padding: 1.5rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .actions {
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {
            .header h1 {
                font-size: 1.8rem;
            }

            .header p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-edit"></i> Edit Room</h1>
        <p>Update room information and capacity</p>
    </div>

    <div class="card">
        <div class="id-badge">
            <i class="fas fa-door-open"></i> Room ID: ${room.idRoom}
        </div>

        <form action="${pageContext.request.contextPath}/rooms" method="post">
            <!-- Hidden field for room ID -->
            <input type="hidden" name="idRoom" value="${room.idRoom}">
            <input type="hidden" name="action" value="update">


            <div class="form-grid">
                <div class="form-group">
                    <label for="name" class="form-label">Room Name</label>
                    <input type="text" id="name" name="name" class="form-control"
                           value="${room.name}" required
                           placeholder="Enter room name">
                    <span class="form-hint">e.g., Operation Room, Consultation Room</span>
                </div>

                <div class="form-group">
                    <label for="capacity" class="form-label">Capacity</label>
                    <input type="number" id="capacity" name="capacity" class="form-control"
                           value="${room.capacity}" required
                           placeholder="Enter capacity" min="1" max="100">
                    <span class="form-hint">Maximum number of people</span>
                </div>
            </div>

            <div class="capacity-info">
                <i class="fas fa-info-circle"></i>
                <span>This room can accommodate up to ${room.capacity} people</span>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
                <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    // Add form interactions and validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const capacityInput = document.getElementById('capacity');
        const nameInput = document.getElementById('name');

        // Capacity validation
        capacityInput.addEventListener('input', function() {
            const value = parseInt(this.value);
            if (value < 1) {
                this.setCustomValidity('Capacity must be at least 1');
                this.style.borderColor = 'var(--danger)';
            } else if (value > 100) {
                this.setCustomValidity('Capacity cannot exceed 100');
                this.style.borderColor = 'var(--danger)';
            } else {
                this.setCustomValidity('');
                this.style.borderColor = 'var(--border)';
            }
        });

        // Name input validation
        nameInput.addEventListener('input', function() {
            if (this.value.trim().length < 2) {
                this.setCustomValidity('Room name must be at least 2 characters long');
                this.style.borderColor = 'var(--danger)';
            } else {
                this.setCustomValidity('');
                this.style.borderColor = 'var(--border)';
            }
        });

        // Form submission enhancement
        form.addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;

            // Validate form before submission
            if (!nameInput.value.trim() || !capacityInput.value) {
                return; // Let browser handle validation
            }

            // Show loading state
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            submitBtn.disabled = true;

            // In a real application, you would handle the form submission here
            // For demo purposes, we'll revert after a short delay
            setTimeout(() => {
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            }, 1500);
        });

        // Add focus effects
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.borderColor = 'var(--secondary)';
                this.style.boxShadow = '0 0 0 3px rgba(52, 152, 219, 0.2)';
            });

            input.addEventListener('blur', function() {
                this.style.boxShadow = 'none';
                if (this.validity.valid) {
                    this.style.borderColor = 'var(--border)';
                }
            });
        });
    });
</script>
</body>
</html>