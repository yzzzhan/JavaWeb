package com.gzu.jdbc_homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class create {
    // 数据库连接信息：URL、用户名、密码
    static final String URL = "jdbc:mysql://localhost:3306/jdbc_demo?serverTimezone=GMT&characterEncoding=UTF-8";
    static final String USER = "root";
    static final String PASSWORD = "yzh31415";

    public static void addTeacher(int id, String name, String course, java.sql.Date birthday) {
        // 定义插入数据的SQL语句
        String sql = "INSERT INTO teacher (id, name, course, birthday) VALUES (?, ?, ?, ?)";

        // 使用try-with-resources自动管理连接和资源关闭
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            conn.setAutoCommit(false);
            // 使用PreparedStatement防止SQL注入攻击并提高效率
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);         // 设置教师ID
                ps.setString(2, name);    // 设置教师姓名
                ps.setString(3, course);  // 设置教师教授课程
                ps.setDate(4, birthday);  // 设置教师生日

                // 执行SQL插入操作
                ps.executeUpdate();

                // 提交事务
                conn.commit();
                System.out.println("教师添加成功");
            } catch (SQLException e) {
                // 如果发生异常，回滚
                conn.rollback();
                throw new RuntimeException(e);
            } finally {
                // 恢复自动提交模式
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            // 如果数据库连接或其他SQL操作失败，抛出异常
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        // 调用addTeacher函数，添加一条教师记录
        addTeacher(1, "丁玺润", "JavaWeb", java.sql.Date.valueOf("2006-10-20"));
    }
}
