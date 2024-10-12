# 请求日志记录功能

## 概述

该项目实现了一个简单的请求日志记录功能，通过 `ServletRequestListener`记录每个HTTP请求的详细信息，包括客户端IP、请求方法、URI、查询字符串和用户代理。此外，还记录请求的处理时间，以便于性能分析。

## 代码结构

### 1. RequestLoggingListener 类

* **包路径** ：`com.itWeb.Listener`
* **功能** ：实现 `ServletRequestListener`接口，监听HTTP请求的初始化和销毁事件。

#### 主要方法

* **`requestInitialized(ServletRequestEvent sre)`**
  * 记录请求的初始信息。
  * 从请求中提取客户端IP、请求方法、URI、查询字符串及用户代理。
  * 记录请求开始时间，并将其存储在请求属性中。
* **`requestDestroyed(ServletRequestEvent sre)`**
  * 计算请求的处理时间，并记录完成的请求信息。

### 2. TestServlet 类

* **包路径** ：`com.itWeb.resp`
* **功能** ：提供一个简单的测试Servlet，用于验证请求处理。

#### 主要方法

* **`doGet(HttpServletRequest request, HttpServletResponse response)`**
  * 当收到GET请求时，返回一条测试消息“ Servlet  running”。

## 日志输出

请求初始化时，日志记录包括：

* 客户端IP
* 请求方法
* 请求URI
* 查询字符串
* User-Agent

请求完成时，记录处理时间。

## 使用方法

1. 将代码放置于Servlet支持的Java Web项目中。
2. 部署应用并访问 `/test`路径以触发请求。
3. 检查日志输出以查看请求详情和处理时间。
