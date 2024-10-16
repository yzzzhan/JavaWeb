/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 24/09/2024 16:08:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `teacher_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `credits` decimal(2, 1) NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id`) USING BTREE,
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('C001', '高等数学', 'T001', 4.0);
INSERT INTO `course` VALUES ('C002', '大学物理', 'T002', 3.5);
INSERT INTO `course` VALUES ('C003', '程序设计', 'T003', 4.0);
INSERT INTO `course` VALUES ('C004', '数据结构', 'T004', 3.5);
INSERT INTO `course` VALUES ('C005', '数据库原理', 'T005', 4.0);
INSERT INTO `course` VALUES ('C006', '操作系统', 'T006', 3.5);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `student_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `score` decimal(4, 1) NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`, `course_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `score_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `score_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('2021001', 'C001', 85.5);
INSERT INTO `score` VALUES ('2021001', 'C002', 78.0);
INSERT INTO `score` VALUES ('2021001', 'C003', 90.5);
INSERT INTO `score` VALUES ('2021002', 'C001', 92.0);
INSERT INTO `score` VALUES ('2021002', 'C002', 83.5);
INSERT INTO `score` VALUES ('2021002', 'C004', 58.0);
INSERT INTO `score` VALUES ('2021003', 'C001', 76.5);
INSERT INTO `score` VALUES ('2021003', 'C003', 85.0);
INSERT INTO `score` VALUES ('2021003', 'C005', 69.5);
INSERT INTO `score` VALUES ('2021004', 'C002', 88.5);
INSERT INTO `score` VALUES ('2021004', 'C004', 92.5);
INSERT INTO `score` VALUES ('2021004', 'C006', 86.0);
INSERT INTO `score` VALUES ('2021005', 'C001', 61.0);
INSERT INTO `score` VALUES ('2021005', 'C003', 87.5);
INSERT INTO `score` VALUES ('2021005', 'C005', 84.0);
INSERT INTO `score` VALUES ('2021006', 'C002', 79.5);
INSERT INTO `score` VALUES ('2021006', 'C004', 83.0);
INSERT INTO `score` VALUES ('2021006', 'C006', 90.0);
INSERT INTO `score` VALUES ('2021007', 'C001', 93.5);
INSERT INTO `score` VALUES ('2021007', 'C003', 89.0);
INSERT INTO `score` VALUES ('2021007', 'C005', 94.5);
INSERT INTO `score` VALUES ('2021008', 'C002', 86.5);
INSERT INTO `score` VALUES ('2021008', 'C004', 91.0);
INSERT INTO `score` VALUES ('2021008', 'C006', 87.5);
INSERT INTO `score` VALUES ('2021009', 'C001', 80.0);
INSERT INTO `score` VALUES ('2021009', 'C003', 62.5);
INSERT INTO `score` VALUES ('2021009', 'C005', 85.5);
INSERT INTO `score` VALUES ('2021010', 'C002', 64.5);
INSERT INTO `score` VALUES ('2021010', 'C004', 89.5);
INSERT INTO `score` VALUES ('2021010', 'C006', 93.0);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `student_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `birth_date` date NULL DEFAULT NULL,
  `my_class` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2021001', '张三', '男', '2003-05-15', '计算机一班');
INSERT INTO `student` VALUES ('2021002', '李四', '女', '2003-08-22', '计算机一班');
INSERT INTO `student` VALUES ('2021003', '王五', '男', '2002-11-30', '数学一班');
INSERT INTO `student` VALUES ('2021004', '赵六', '女', '2003-02-14', '数学一班');
INSERT INTO `student` VALUES ('2021005', '钱七', '男', '2002-07-08', '物理一班');
INSERT INTO `student` VALUES ('2021006', '孙八', '女', '2003-09-19', '物理一班');
INSERT INTO `student` VALUES ('2021007', '周九', '男', '2002-12-01', '化学一班');
INSERT INTO `student` VALUES ('2021008', '吴十', '女', '2003-03-25', '化学一班');
INSERT INTO `student` VALUES ('2021009', '郑十一', '男', '2002-06-11', '生物一班');
INSERT INTO `student` VALUES ('2021010', '王十二', '女', '2003-10-05', '生物一班');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacher_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `birth_date` date NULL DEFAULT NULL,
  `title` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`teacher_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('T001', '张教授', '男', '1975-03-12', '教授');
INSERT INTO `teacher` VALUES ('T002', '李副教授', '女', '1980-07-22', '副教授');
INSERT INTO `teacher` VALUES ('T003', '王讲师', '男', '1985-11-08', '讲师');
INSERT INTO `teacher` VALUES ('T004', '赵助教', '女', '1990-05-15', '助教');
INSERT INTO `teacher` VALUES ('T005', '钱教授', '男', '1972-09-30', '教授');
INSERT INTO `teacher` VALUES ('T006', '孙副教授', '女', '1978-12-18', '副教授');
INSERT INTO `teacher` VALUES ('T007', '周讲师', '男', '1983-04-25', '讲师');
INSERT INTO `teacher` VALUES ('T008', '吴助教', '女', '1988-08-07', '助教');
INSERT INTO `teacher` VALUES ('T009', '郑教授', '男', '1970-01-01', '教授');
INSERT INTO `teacher` VALUES ('T010', '刘副教授', '女', '1976-06-14', '副教授');

SET FOREIGN_KEY_CHECKS = 1;

# 1. 查询所有学生的信息。
SELECT *
FROM student;

# 2. 查询所有课程的信息。
SELECT *
FROM course;

# 3. 查询所有学生的姓名、学号和班级。
SELECT name,
       student_id,
       my_class
FROM student;

# 4. 查询所有教师的姓名和职称。
SELECT name,
       title
FROM teacher;

# 5. 查询不同课程的平均分数。
SELECT c.course_name,
       AVG(sc.score)
FROM score sc
JOIN course c ON c.course_id = sc.course_id
GROUP BY sc.course_id;

# 6. 查询每个学生的平均分数。
SELECT name,
       AVG(score)
FROM score sc
JOIN student s ON sc.student_id = s.student_id
GROUP BY sc.student_id;

# 7. 查询分数大于85分的学生学号和课程号。
SELECT  student_id,
        course_id
FROM score
WHERE score > 85;

# 8. 查询每门课程的选课人数。
SELECT c.course_id,
       course_name,
       count(*)
FROM score sc
JOIN course c ON c.course_id = sc.course_id
GROUP BY c.course_id;

# 9. 查询选修了"高等数学"课程的学生姓名和分数。
SELECT name,
       score
FROM score sc
JOIN student s ON s.student_id = sc.student_id
WHERE course_id = (
    SELECT c.course_id
    FROM course c
    WHERE course_name='高等数学'
    );

# 10. 查询没有选修"大学物理"课程的学生姓名。
SELECT s.name
FROM student s
WHERE s.student_id NOT IN(
    SELECT sc.student_id
    FROM score sc
    WHERE sc.course_id='C002'
    );

# 11. 查询C001比C002课程成绩高的学生信息及课程分数。
SELECT s.student_id,
       s.name,
       s.gender,
       s.birth_date,
       s.my_class,
       sc1.score,
       sc2.score
FROM student s
JOIN test.score sc1 ON s.student_id = sc1.student_id AND sc1.course_id='C001'
JOIN test.score sc2 ON s.student_id = sc2.student_id AND sc2.course_id='C002'
WHERE sc1.score>sc2.score;

# 12. 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比
SELECT
    c.course_id,
    c.course_name,
    SUM(CASE WHEN s.score > 85 THEN 1 ELSE 0 END) AS `100-85`,
    SUM(CASE WHEN s.score <= 85 AND s.score > 70 THEN 1 ELSE 0 END) AS `85-70`,
    SUM(CASE WHEN s.score <= 70 AND s.score > 60 THEN 1 ELSE 0 END) AS `70-60`,
    SUM(CASE WHEN s.score <= 60 AND s.score >= 0 THEN 1 ELSE 0 END) AS `60-0`,
    COUNT(s.student_id) AS total_students,
    ROUND(SUM(CASE WHEN s.score > 85 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS `100-85 %`,
    ROUND(SUM(CASE WHEN s.score <= 85 AND s.score > 70 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS `85-70 %`,
    ROUND(SUM(CASE WHEN s.score <= 70 AND s.score > 60 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS `70-60 %`,
    ROUND(SUM(CASE WHEN s.score <= 60 AND s.score >= 0 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS `60-0 %`
FROM
    course c
LEFT JOIN
    score s ON c.course_id = s.course_id
GROUP BY
    c.course_id, c.course_name;

# 13. 查询选择C002课程但没选择C004课程的成绩情况(不存在时显示为 null )。
SELECT
    s.student_id,
    s.name,
    sc_c002.score,
    sc_c004.score
FROM student s
LEFT JOIN score sc_c002 ON s.student_id = sc_c002.student_id AND sc_c002.course_id = 'C002'
LEFT JOIN score sc_c004 ON s.student_id = sc_c004.student_id AND sc_c004.course_id = 'C004'
WHERE sc_c002.score IS NOT NULL AND sc_c004.score IS NULL;

# 14. 查询平均分数最高的学生姓名和平均分数。
SELECT s.name,
       AVG(sc.score) AS avg_score
FROM student s
JOIN test.score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
ORDER BY avg_score DESC
LIMIT 1;

# 15. 查询总分最高的前三名学生的姓名和总分。
SELECT s.name,SUM(sc.score) AS total_score
FROM student s
JOIN test.score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
ORDER BY total_score DESC
LIMIT 3;

# 16. 查询各科成绩最高分、最低分和平均分。要求如下：
# 以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
# 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
# 要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
SELECT
    c.course_id,
    c.course_name,
    MAX(s.score) AS highest_score,
    MIN(s.score) AS lowest_score,
    ROUND(AVG(s.score), 2) AS average_score,
    ROUND(SUM(CASE WHEN s.score >= 60 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS pass_rate,
    ROUND(SUM(CASE WHEN s.score >= 70 AND s.score < 80 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS medium_rate,
    ROUND(SUM(CASE WHEN s.score >= 80 AND s.score < 90 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS good_rate,
    ROUND(SUM(CASE WHEN s.score >= 90 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS excellent_rate,
    COUNT(s.student_id) AS total_students
FROM
    course c
LEFT JOIN
    score s ON c.course_id = s.course_id
GROUP BY
    c.course_id, c.course_name
ORDER BY
    total_students DESC, c.course_id ASC;

# 17. 查询男生和女生的人数。
SELECT gender,count(*)
FROM student
GROUP BY gender ;

# 18. 查询年龄最大的学生姓名。
SELECT name
FROM student
ORDER BY birth_date DESC
LIMIT 1;

# 19. 查询年龄最小的教师姓名。
SELECT name
FROM teacher
ORDER BY birth_date
LIMIT 1;

# 20. 查询学过「张教授」授课的同学的信息。
SELECT s.student_id,
       s.name,
       s.gender,
       s.birth_date,
       s.my_class
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON c.course_id = sc.course_id
WHERE teacher_id = (
    SELECT teacher_id
    FROM teacher
    WHERE name='张教授'
    );

# 21. 查询查询至少有一门课与学号为"2021001"的同学所学相同的同学的信息 。
SELECT DISTINCT s1.*
FROM student s1
JOIN score sc1 ON s1.student_id = sc1.student_id
WHERE sc1.course_id IN (
    SELECT sc2.course_id
    FROM score sc2
    WHERE sc2.student_id = '2021001'
) AND s1.student_id <> '2021001';


# 22. 查询每门课程的平均分数，并按平均分数降序排列。
SELECT c.course_name,
       AVG(sc.score) AS avg_total
FROM score sc
JOIN course c ON c.course_id = sc.course_id
GROUP BY c.course_id
ORDER BY avg_total DESC ;

# 23. 查询学号为"2021001"的学生所有课程的分数。
SELECT c.course_name,
       sc.score
FROM score sc
JOIN test.course c ON sc.course_id = c.course_id
WHERE sc.student_id='2021001';

# 24. 查询所有学生的姓名、选修的课程名称和分数。
SELECT s.name AS student_name,
       c.course_name,
       sc.score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id;

# 25. 查询每个教师所教授课程的平均分数。
SELECT t.name,
       AVG(sc.score) AS avg_score
FROM teacher t
JOIN course c ON t.teacher_id = c.teacher_id
JOIN score sc ON c.course_id = sc.course_id
GROUP BY t.name ;

# 26. 查询分数在80到90之间的学生姓名和课程名称。
SELECT s.name,
       c.course_name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id
WHERE sc.score BETWEEN 80 AND 90;

# 27. 查询每个班级的平均分数。
SELECT DISTINCT s.my_class,
       AVG(sc.score)OVER (PARTITION BY s.my_class) AS avg_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id;

# 28. 查询没学过"王讲师"老师讲授的任一门课程的学生姓名。
SELECT s.name
FROM student s
WHERE s.student_id NOT IN(
    SELECT sc.student_id
    FROM score sc
    JOIN course c ON c.course_id = sc.course_id
    JOIN teacher t ON c.teacher_id = t.teacher_id
    WHERE t.name='王讲师'
    );

# 29. 查询两门及其以上小于85分的同学的学号，姓名及其平均成绩 。
SELECT s.student_id,
       s.name,AVG(sc.score) AS avg_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
WHERE sc.score < 85
GROUP BY s.student_id
HAVING COUNT(*) >= 2;

# 30. 查询所有学生的总分并按降序排列。
SELECT s.student_id,
       s.name,SUM(sc.score) AS total_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
ORDER BY total_score DESC ;

# 31. 查询平均分数超过85分的课程名称。
SELECT c.course_name
FROM course c
JOIN score sc ON c.course_id = sc.course_id
GROUP BY c.course_id
HAVING AVG(sc.score) > 85;

# 32. 查询每个学生的平均成绩排名。
SELECT s.student_id,s.name,AVG(sc.score) AS avg_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
ORDER BY avg_score DESC ;

# 33. 查询每门课程分数最高的学生姓名和分数。
SELECT course_name,
       name,
       score
FROM(
    SELECT
        c.course_name,
        s.name,
        sc.score,
        RANK() OVER (PARTITION BY c.course_name ORDER BY sc.score DESC) AS score_rank
    FROM course c
    JOIN score sc ON c.course_id = sc.course_id
    JOIN student s ON sc.student_id = s.student_id
    )AS rank_score
WHERE score_rank = 1;

# 34. 查询选修了"高等数学"和"大学物理"的学生姓名。
SELECT s.name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id
WHERE c.course_name IN ('高等数学', '大学物理')
GROUP BY s.student_id, s.name
HAVING COUNT(DISTINCT c.course_name) = 2;


# 35. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩（没有选课则为空）。
SELECT DISTINCT s.student_id,
       s.name,
       c.course_name,
       sc.score,
       AVG(sc.score)OVER (PARTITION BY s.student_id )AS avg_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id
ORDER BY avg_score DESC ;

# 36. 查询分数最高和最低的学生姓名及其分数。
/*SELECT s.name,
       SUM(sc.score) AS total_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
HAVING
    total_score = (SELECT MAX(total)FROM (SELECT SUM(score) AS totalFROM scoreGROUP BY student_id) AS totals)
    OR
    total_score = (SELECT MIN(total)FROM (SELECT SUM(score) AS totalFROM scoreGROUP BY student_id) AS totals);*/
/*窗口函数尝试*/
SELECT
    name,
    total_score
FROM (
    SELECT
        name,
        SUM(score)AS total_score,
        RANK() OVER (ORDER BY SUM(sc.score) DESC) AS rank_desc,
        RANK() OVER (ORDER BY SUM(sc.score) ASC) AS rank_asc
    FROM student s
    JOIN score sc ON s.student_id = sc.student_id
    GROUP BY s.student_id
     )AS rank_total
WHERE rank_asc=1 OR rank_desc=1;

# 37. 查询每个班级的最高分和最低分。
SELECT my_class,MAX(total_score) AS max_score,MIN(total_score) AS min_score
FROM (
    SELECT s.my_class, SUM(score) AS total_score
    FROM student s
    JOIN score sc ON s.student_id = sc.student_id
    GROUP BY s.student_id
     ) AS ranked_class
GROUP BY my_class ;

# 38. 查询每门课程的优秀率（优秀为90分）。
SELECT c.course_name,
       CONCAT(COUNT(CASE WHEN sc.score >= 90 THEN 1 END)*100 / COUNT(sc.student_id) ,'%') AS excellent_rate
FROM course c
LEFT JOIN score sC ON c.course_id = sC.course_id
GROUP BY c.course_name;

# 39. 查询平均分数超过班级平均分数的学生。
SELECT s.my_class,s.student_id,s.name,AVG(sc.score) AS avg_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.my_class,s.student_id
HAVING (
    AVG(sc.score) > (
        SELECT AVG(score)
        FROM score
        JOIN student ON score.student_id = student.student_id
        WHERE student.my_class = s.my_class
        GROUP BY student.my_class
        )
    );

# 40. 查询每个学生的分数及其与课程平均分的差值。
SELECT
    s.student_id,
    s.name,
    course_name,
    sc.score,
    sc.score - avg_course.avg_score AS score_difference
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id
JOIN (
    SELECT
        course_id,
        AVG(score) AS avg_score
    FROM
        score
    GROUP BY
        course_id
) AS avg_course ON c.course_id = avg_course.course_id;

# 41. 查询至少有一门课程分数低于80分的学生姓名。
SELECT DISTINCT s.name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
WHERE sc.score < 80;

# 42. 查询所有课程分数都高于85分的学生姓名。
SELECT DISTINCT s.name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
HAVING MIN(sc.score) > 85;

# 43. 查询查询平均成绩大于等于90分的同学的学生编号和学生姓名和平均成绩。
SELECT s.student_id,
       s.name,
       AVG(sc.score) AS avg_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
HAVING AVG(sc.score) >= 90;

# 44. 查询选修课程数量最少的学生姓名。
SELECT s.name,
       COUNT(sc.score)
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
ORDER BY COUNT(sc.score) ASC
LIMIT 1;

# 45. 查询每个班级的第2名学生（按平均分数排名）。
SELECT my_class,
       student_id,
       avg_score
FROM (
    SELECT s.student_id,
           s.my_class,
           AVG(sc.score)AS avg_score,
           RANK()OVER (PARTITION BY s.my_class ORDER BY AVG(sc.score)DESC ) AS score_rank
    FROM student s
    JOIN score sc ON s.student_id = sc.student_id
    GROUP BY s.my_class, s.student_id
     )AS ranked_score
WHERE score_rank = 2;

# 46. 查询每门课程分数前三名的学生姓名和分数。
SELECT course_name,
       student_id,
       score
FROM (
    SELECT c.course_name,
           sc.student_id,
           sc.score,
           RANK()OVER (PARTITION BY sc.course_id ORDER BY score DESC ) AS score_rank
    FROM score sc
    JOIN course c ON sc.course_id = c.course_id
     )AS ranked_score
WHERE score_rank <= 3;

# 47. 查询平均分数最高和最低的班级。
SELECT my_class,
       avg_score
FROM (
    SELECT s.my_class,
           AVG(sc.score) AS avg_score,
           RANK() OVER (ORDER BY AVG(sc.score) DESC) AS rank_desc,
           RANK() OVER (ORDER BY AVG(sc.score) ASC) AS rank_asc
    FROM student s
    JOIN score sc ON s.student_id = sc.student_id
    GROUP BY s.my_class
) AS ranked_classes
WHERE rank_desc = 1 OR rank_asc = 1;

# 48. 查询每个学生的总分和他所在班级的平均分数。
SELECT s.student_id,
       s.name,
       SUM(sc.score) AS person_score,
       AVG(SUM(sc.score)) OVER (PARTITION BY s.my_class) AS class_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id, s.name, s.my_class;

# 49. 查询每个学生的最高分的课程名称, 学生名称，成绩。
SELECT s.name,
       c.course_name,
       sc.score AS max_course
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id
WHERE sc.score =(
    SELECT MAX(score)
    FROM score
    WHERE student_id=s.student_id
    );

# 50. 查询每个班级的学生人数和平均年龄。
SELECT s.my_class,
       COUNT(s.student_id) AS student_count,
       AVG(TIMESTAMPDIFF(YEAR, s.birth_date, CURDATE())) AS average_age
FROM student s
GROUP BY s.my_class;

