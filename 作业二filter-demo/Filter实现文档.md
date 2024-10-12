
# 文档：用户登录系统实现

## 1. 概述

本项目实现了一个基本的用户登录系统，使用Java Servlet和JSP技术。系统包含用户登录过滤器、登录处理Servlet、登录页面（`index.jsp`）和登录成功页面（`home.jsp`）。

## 2. 主要组件

### 2.1 LoginFilter

**包名**: `com.gzu.filterdemo`
**功能**: 该过滤器用于检查用户是否已登录，拦截所有请求，并根据登录状态决定是否允许请求继续。

```java
@WebFilter("/*") // 过滤所有URL路径
public class LoginFilter implements Filter {
    // 省略其他代码...

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        if (check(httpRequest, requestURI)) {
            chain.doFilter(request, response);
        } else {
            HttpSession session = httpRequest.getSession(false);
            boolean loggedIn = (session != null && session.getAttribute("user") != null);
            if (loggedIn) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            }
        }
    }

    private boolean check(HttpServletRequest request, String path) {
        final List<String> STATIC_LIST = Arrays.asList(
                request.getContextPath() + "/login",
                request.getContextPath() + "/register",
                request.getContextPath() + "/public",
                request.getContextPath() + "/servlet",
                request.getContextPath() + "/"
        );
        return STATIC_LIST.contains(path);
    }
}
```

**功能解释**:

- `init()`: 初始化过滤器。
- `doFilter()`: 核心方法，检查请求的URI是否在允许的静态列表中。如果不在，检查用户的登录状态，决定是否重定向到登录页面。
- `check()`: 用于判断请求的路径是否在静态资源列表中。

### 2.2 LoginServlet

**包名**: `com.gzu.filterdemo`
**功能**: 处理用户登录请求，包括显示登录页面和处理登录表单提交。

```java
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("user".equals(username) && "pass".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            response.sendRedirect(request.getContextPath() + "/home.jsp");
        } else {
            request.setAttribute("errorMessage", "登录信息有误");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
```

**功能解释**:

- `doGet()`: 显示登录页面（`index.jsp`）。
- `doPost()`: 处理登录表单提交。根据输入的用户名和密码验证用户，并在登录成功后存储用户信息到Session。如果验证失败，返回登录页面并显示错误信息。

### 2.3 index.jsp

**功能**: 用户登录页面，包含输入表单和错误提示。

```jsp
<form action="login" method="post">
  <label for="username">用户名:</label>
  <input type="text" id="username" name="username" required><br>
  <label for="password">密码:</label>
  <input type="password" id="password" name="password" required><br>
  <button type="submit">登录</button>
</form>
<c:if test="${not empty errorMessage}">
  <p style="color:red;">${errorMessage}</p>
</c:if>
```

**功能解释**:

- 提供用户输入用户名和密码的表单，提交到 `LoginServlet`进行处理。
- 如果存在错误信息，动态显示错误提示。

### 2.4 home.jsp

**功能**: 登录成功后的欢迎页面。

```jsp
<h2>登录成功</h2>
<p>终于登陆了！</p>
<a href="index.jsp">登出</a>
```

**功能解释**:

- 显示登录成功的信息，提示用户已经成功登录。

## 3. 额外功能

- **会话管理**: 利用HttpSession对象管理用户的登录状态，增强安全性。
- **请求过滤**: LoginFilter可以灵活扩展，添加更多路径到排除列表，便于管理访问权限。

## 4. 结论

本项目提供了一个简单的用户登录系统示例，通过Servlet和JSP实现了基本的登录功能，并结合Session管理用户状态。代码结构清晰，便于扩展和维护。
