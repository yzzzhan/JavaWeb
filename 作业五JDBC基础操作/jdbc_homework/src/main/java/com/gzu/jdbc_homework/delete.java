package com.gzu.jdbc_homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class delete {
    // 数据库连接信息：URL、用户名、密码
    static final String URL = "jdbc:mysql://localhost:3306/jdbc_demo?serverTimezone=GMT&characterEncoding=UTF-8";
    static final String USER = "root";
    static final String PASSWORD = "yzh31415";

    public static void deleteTeacher(int id) {
        String sql = "DELETE FROM teacher WHERE id = ?";

        // 使用try-with-resources确保资源自动关闭
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            // 关闭自动提交，以便手动控制事务
            conn.setAutoCommit(false);

            // 使用PreparedStatement设置SQL参数
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                // 设置SQL语句中的ID参数
                ps.setInt(1, id);  // 绑定教师ID

                // 执行SQL删除操作
                ps.executeUpdate();

                // 提交事务，确认删除
                conn.commit();
                System.out.println("教师删除成功");
            } catch (SQLException e) {
                // 如果出现异常，回滚
                conn.rollback();
                throw new RuntimeException(e);
            } finally {
                // 恢复自动提交模式
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            // 处理SQL异常，如果无法连接或执行操作时出错
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        // 调用deleteTeacher方法，删除ID为1的教师
        deleteTeacher(1);
    }
}
