package com.gzu.jdbc_homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class update {
    // 数据库连接信息：URL、用户名、密码
    static final String URL = "jdbc:mysql://localhost:3306/jdbc_demo?serverTimezone=GMT&characterEncoding=UTF-8";
    static final String USER = "root";
    static final String PASSWORD = "yzh31415";

    public static void updateTeacher(int id, String name, String course, java.sql.Date birthday) {
        String sql = "UPDATE teacher SET name = ?, course = ?, birthday = ? WHERE id = ?";

        // 使用try-with-resources语法管理资源自动关闭
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            // 关闭自动提交，以手动控制事务
            conn.setAutoCommit(false);

            // 使用PreparedStatement对象来传递SQL语句和参数
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                // 绑定参数到SQL语句
                ps.setString(1, name);  // 设置姓名
                ps.setString(2, course);  // 设置课程
                ps.setDate(3, birthday);  // 设置生日
                ps.setInt(4, id);  // 设置教师ID

                // 执行SQL更新操作
                ps.executeUpdate();

                // 提交事务，确保更新成功
                conn.commit();
                System.out.println("教师更新成功");
            } catch (SQLException e) {
                // 如果发生错误，回滚事务
                conn.rollback();
                throw new RuntimeException(e);
            } finally {
                // 恢复自动提交模式
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            // 如果数据库连接或SQL操作失败，抛出异常
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        // 更新ID为1的教师记录，修改姓名、课程和生日
        updateTeacher(1, "张伟", "英语", java.sql.Date.valueOf("1985-03-22"));
    }
}
