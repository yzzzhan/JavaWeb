package com.gzu.filterdemo;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*") // 过滤所有URL路径
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化过滤器，可以用于加载资源或设置参数
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request; // 将请求转换为HttpServletRequest
        HttpServletResponse httpResponse = (HttpServletResponse) response; // 将响应转换为HttpServletResponse

        String requestURI = httpRequest.getRequestURI(); // 获取请求的URL
        // 检查请求是否在静态资源列表中
        if (check(httpRequest, requestURI)) {
            chain.doFilter(request, response); // 允许请求继续
        } else {
            // 判断用户的登录状态
            HttpSession session = httpRequest.getSession(false); // 获取当前会话，不创建新会话
            boolean loggedIn = (session != null && session.getAttribute("user") != null); // 检查是否存在用户属性

            if (loggedIn) {
                chain.doFilter(request, response); // 已登录用户，允许请求继续
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login"); // 重定向到登录页面
            }
        }
    }

    @Override
    public void destroy() {
        // 清理资源，可以在过滤器销毁时使用
    }

    private boolean check(HttpServletRequest request, String path) {
        // 定义允许直接访问的静态资源列表
        final List<String> STATIC_LIST = Arrays.asList(
                request.getContextPath() + "/login",
                request.getContextPath() + "/register",
                request.getContextPath() + "/public",
                request.getContextPath() + "/servlet",
                request.getContextPath() + "/"
        );
        return STATIC_LIST.contains(path); // 检查请求路径是否在允许列表中
    }
}
