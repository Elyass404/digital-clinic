<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Departments</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
</head>
<body>
<%-- header include (optional) --%>
<jsp:include page="header.jsp" />

<h1>Departments</h1>

<h3>Add a department</h3>
<form action="${pageContext.request.contextPath}/departments" method="post">
    <input type="text" name="name" required placeholder="Department name" />
    <button type="submit">Add</button>
</form>

<h3>Existing departments</h3>
<c:if test="${empty departments}">
    <p>No departments found.</p>
</c:if>

<c:if test="${not empty departments}">
    <table border="1" cellpadding="6" cellspacing="0">
        <thead>
        <tr><th>ID</th><th>Name</th></tr>
        </thead>
        <tbody>
        <c:forEach var="d" items="${departments}">
            <tr>
                <td>${d.id}</td>
                <td>${d.name}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>

<%-- footer include (optional) --%>
<jsp:include page="footer.jsp" />
</body>
</html>
