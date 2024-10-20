package com.gzu.jdbc_homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class search {
    // 数据库连接信息：URL、用户名、密码
    static final String URL = "jdbc:mysql://localhost:3306/jdbc_demo?serverTimezone=GMT&characterEncoding=UTF-8";
    static final String USER = "root";
    static final String PASSWORD = "yzh31415";

    public static void getTeacherById(int id) {
        String sql = "SELECT * FROM teacher WHERE id = ?";

        // 使用try-with-resources自动关闭数据库连接和其他资源
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // 设置SQL语句中的参数
            ps.setInt(1, id);  // 将教师ID设置为SQL语句的参数

            // 执行查询，并获取查询结果集
            try (ResultSet rs = ps.executeQuery()) {

                // 判断是否有查询结果
                if (rs.next()) {
                    System.out.println("ID: " + rs.getInt("id"));
                    System.out.println("姓名: " + rs.getString("name"));
                    System.out.println("课程: " + rs.getString("course"));
                    System.out.println("生日: " + rs.getDate("birthday"));
                } else {
                    // 如果没有查询到结果，输出提示信息
                    System.out.println("未找到该教师");
                }
            }
        } catch (SQLException e) {
            // 如果出现SQL异常，抛出运行时异常
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        // 调用getTeacherById方法，查询ID为1的教师信息
        getTeacherById(1);
    }
}
