package com.gzu.filterdemo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login") // 映射到/login路径
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 转发到登录页面
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取用户输入的用户名和密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 简单的用户验证示例
        if ("user".equals(username) && "pass".equals(password)) {
            // 创建会话并存储用户信息
            HttpSession session = request.getSession();
            session.setAttribute("user", username); // 存储用户信息到Session
            response.sendRedirect(request.getContextPath() + "/home.jsp"); // 重定向到成功登录后的页面
        } else {
            // 登录失败，设置错误信息并转发回登录页面
            request.setAttribute("errorMessage", "登录信息有误");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
