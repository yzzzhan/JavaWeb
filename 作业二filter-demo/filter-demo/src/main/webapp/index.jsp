<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
</head>
<body>
<h2>登录页面</h2>
<!-- 登录表单，提交到/login路径 -->
<form action="login" method="post">
  <label for="username">用户名:</label>
  <input type="text" id="username" name="username" required><br>
  <label for="password">密码:</label>
  <input type="password" id="password" name="password" required><br>
  <button type="submit">登录</button>
</form>
<!-- 显示错误信息 -->
<c:if test="${not empty errorMessage}">
  <p style="color:red;">${errorMessage}</p>
</c:if>
</body>
</html>
