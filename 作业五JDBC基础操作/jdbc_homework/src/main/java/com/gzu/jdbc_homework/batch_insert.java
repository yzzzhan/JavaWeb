package com.gzu.jdbc_homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;

public class batch_insert {
    // 数据库连接信息：URL、用户名、密码
    static final String URL = "jdbc:mysql://localhost:3306/jdbc_demo?serverTimezone=GMT&characterEncoding=UTF-8";
    static final String USER = "root";
    static final String PASSWORD = "yzh31415";

    public static void batchInsertTeachers() {
        String sql = "INSERT INTO teacher (id, name, course, birthday) VALUES (?, ?, ?, ?)";

        // 使用try-with-resources语法管理数据库连接
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            // 关闭自动提交，以手动控制事务
            conn.setAutoCommit(false);

            // 使用PreparedStatement对象准备SQL语句并批量执行
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                // 循环插入500条教师数据
                for (int i = 1; i <= 500; i++) {
                    ps.setInt(1, i);  // 设置教师ID
                    ps.setString(2, "Teacher" + i);  // 设置教师姓名
                    ps.setString(3, "Course" + i);  // 设置所授课程
                    ps.setDate(4, new Date(System.currentTimeMillis()));  // 设置当前日期为教师生日

                    // 将插入操作加入批处理
                    ps.addBatch();

                    // 每插入100条数据，执行一次批处理并提交事务
                    if (i % 100 == 0) {
                        ps.executeBatch();  // 执行批量插入
                        conn.commit();  // 提交事务
                        System.out.println("已插入 " + i + " 条记录");
                    }
                }
                // 插入剩余的记录（如果有）
                ps.executeBatch();
                conn.commit();
                System.out.println("批量插入完成");
            } catch (SQLException e) {
                // 如果发生错误，回滚事务
                conn.rollback();
                throw new RuntimeException(e);
            } finally {
                // 恢复自动提交模式
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            // 捕获数据库连接或SQL操作的异常
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        // 执行批量插入操作
        batchInsertTeachers();
    }
}
