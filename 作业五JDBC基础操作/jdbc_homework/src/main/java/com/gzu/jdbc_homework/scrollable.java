package com.gzu.jdbc_homework;

import java.sql.*;

public class scrollable {
    public static void main(String[] args) {
        // 数据库连接信息：URL、用户名、密码
        String url = "jdbc:mysql://localhost:3306/jdbc_demo?serverTimezone=GMT&characterEncoding=UTF-8";
        String user = "root";
        String password = "yzh31415";
        String sql = "SELECT * FROM teacher";

        // 使用try-with-resources语法，自动关闭连接和资源
        try (Connection conn = DriverManager.getConnection(url, user, password);
             // 创建可滚动的、只读的PreparedStatement
             PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {

            // 执行查询，并获取结果集
            try (ResultSet rs = ps.executeQuery()) {
                // 移动到结果集的最后一行
                if (rs.last()) {
                    // 检查结果集中是否至少有两条记录
                    if (rs.getRow() > 1) {
                        // 移动到倒数第二行
                        rs.absolute(-2);
                        // 输出倒数第二条记录的信息
                        System.out.println("倒数第二条记录: " +
                                rs.getInt("id") + " " + // 获取ID
                                rs.getString("name") + " " + // 获取姓名
                                rs.getString("course") + " " + // 获取课程
                                rs.getDate("birthday")); // 获取生日
                    } else {
                        // 如果结果集中记录少于2条，输出提示信息
                        System.out.println("结果集中记录少于2条");
                    }
                }
            } catch (SQLException e) {
                // 捕获SQL异常并打印堆栈跟踪
                e.printStackTrace();
            }

        } catch (SQLException e) {
            // 捕获数据库连接异常并打印堆栈跟踪
            e.printStackTrace();
        }
    }
}
