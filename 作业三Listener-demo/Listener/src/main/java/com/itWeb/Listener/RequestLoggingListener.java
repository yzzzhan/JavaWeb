package com.itWeb.Listener;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import java.util.logging.Logger;

@WebListener
public class RequestLoggingListener implements ServletRequestListener {

    private static final Logger logger = Logger.getLogger(RequestLoggingListener.class.getName());

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();

        long startTime = System.currentTimeMillis();
        request.setAttribute("startTime", startTime);  // 保存请求开始时间

        String clientIp = request.getRemoteAddr();
        String method = request.getMethod();
        String uri = request.getRequestURI();
        String queryString = request.getQueryString();
        String userAgent = request.getHeader("User-Agent");

        logger.info("收到请求: " +
                "客户端IP=" + clientIp +
                ", 请求方法=" + method +
                ", 请求URI=" + uri +
                ", 查询字符串=" + (queryString == null ? "N/A" : queryString) +
                ", User-Agent=" + userAgent);
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sre) {
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();

        long startTime = (Long) request.getAttribute("startTime");
        long endTime = System.currentTimeMillis();
        long processingTime = endTime - startTime;

        logger.info("请求完成: " +
                "请求URI=" + request.getRequestURI() +
                ", 处理时间=" + processingTime + " 毫秒");
    }
}

