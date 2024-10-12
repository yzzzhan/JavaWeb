package com.itWeb.Listener;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import java.util.logging.Logger;

@WebListener
public class RequestLoggingListener implements ServletRequestListener {
    // 创建一个 Logger 对象，用于记录日志信息
    private static final Logger logger = Logger.getLogger(RequestLoggingListener.class.getName());

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();

        long startTime = System.currentTimeMillis();
        request.setAttribute("startTime", startTime);  // 保存请求开始时间
        // 获取客户端的 IP 地址
        String clientIp = request.getRemoteAddr();
        // 获取请求的方法（例如：GET、POST）
        String method = request.getMethod();
        // 获取请求的 URI（资源路径）
        String uri = request.getRequestURI();
        // 获取查询字符串，如果没有查询字符串，则返回 null
        String queryString = request.getQueryString();
        // 获取请求的 User-Agent 头信息（包含浏览器和操作系统等信息）
        String userAgent = request.getHeader("User-Agent");

        // 记录请求的详细信息
        logger.info("收到请求: " +
                "客户端IP=" + clientIp +
                ", 请求方法=" + method +
                ", 请求URI=" + uri +
                ", 查询字符串=" + (queryString == null ? "N/A" : queryString) +
                ", User-Agent=" + userAgent);
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sre) {
        // 获取 HttpServletRequest 对象，以便访问请求的属性
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();

        // 从请求属性中获取之前保存的开始时间
        long startTime = (Long) request.getAttribute("startTime");
        // 获取当前时间，表示请求结束的时间
        long endTime = System.currentTimeMillis();
        // 计算请求处理的总时长
        long processingTime = endTime - startTime;

        // 记录请求处理的 URI 和处理时间
        logger.info("请求完成: " +
                "请求URI=" + request.getRequestURI() +
                ", 处理时间=" + processingTime + " 毫秒");
    }
}

