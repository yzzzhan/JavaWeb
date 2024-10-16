-- 创建数据库
CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- 创建部门表
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- 创建员工表
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 创建项目表
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE
);

-- 创建员工项目关联表
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- 插入部门数据
INSERT INTO departments (dept_name, location) VALUES
('HR', 'New York'),
('IT', 'San Francisco'),
('Finance', 'Chicago'),
('Marketing', 'Los Angeles'),
('Operations', 'Houston');

-- 插入员工数据
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_title, salary, dept_id) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '2020-01-15', 'HR Manager', 75000.00, 1),
('Jane', 'Smith', 'jane.smith@example.com', '2345678901', '2019-05-20', 'Software Engineer', 85000.00, 2),
('Mike', 'Johnson', 'mike.johnson@example.com', '3456789012', '2018-11-10', 'Financial Analyst', 70000.00, 3),
('Emily', 'Brown', 'emily.brown@example.com', '4567890123', '2021-03-01', 'Marketing Specialist', 65000.00, 4),
('David', 'Wilson', 'david.wilson@example.com', '5678901234', '2017-09-15', 'Operations Manager', 80000.00, 5),
('Sarah', 'Lee', 'sarah.lee@example.com', '6789012345', '2020-07-01', 'IT Support', 60000.00, 2),
('Chris', 'Anderson', 'chris.anderson@example.com', '7890123456', '2019-12-01', 'Accountant', 68000.00, 3),
('Lisa', 'Taylor', 'lisa.taylor@example.com', '8901234567', '2022-01-10', 'HR Assistant', 55000.00, 1),
('Tom', 'Martin', 'tom.martin@example.com', '9012345678', '2018-06-15', 'Software Developer', 82000.00, 2),
('Amy', 'White', 'amy.white@example.com', '0123456789', '2021-09-01', 'Marketing Manager', 78000.00, 4);

-- 插入项目数据
INSERT INTO projects (project_name, start_date, end_date) VALUES
('Website Redesign', '2023-01-01', '2024-11-30'),
('ERP Implementation', '2023-03-15', '2025-03-14'),
('Marketing Campaign', '2023-05-01', '2023-08-31'),
('Financial Audit', '2023-07-01', '2025-09-30'),
('New Product Launch', '2023-09-01', '2024-02-29');

-- 插入员工项目关联数据
INSERT INTO employee_projects (emp_id, project_id) VALUES
(2, 1), (6, 1), (9, 1),
(2, 2), (5, 2), (6, 2), (9, 2),
(4, 3), (10, 3),
(3, 4), (7, 4),
(4, 5), (5, 5), (10, 5);

#1.查询所有员工的姓名、邮箱和工作岗位
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       email,
       job_title
FROM employees;

# 2.查询所有部门的名称和位置
SELECT dept_name,
       location
FROM departments;

# 3.查询工资超过70000的员工姓名和工资
SELECT CONCAT(first_name,' ',last_name) AS full_name,
       salary
FROM employees
WHERE salary > 70000;

# 4.查询IT部门的所有员工
SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM employees
WHERE dept_id = (
    SELECT dept_id
    FROM departments
    WHERE dept_name = 'IT'
    );

# 5.查询入职日期在2020年之后的员工信息
SELECT *
FROM employees
WHERE hire_date > '2020-01-01';

# 6.计算每个部门的平均工资
SELECT d.dept_name,
       AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name ;

# 7. 查询工资最高的前3名员工信息。
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;

# 8. 查询每个部门员工数量。
SELECT dept_name,
       COUNT(*)
FROM employees
JOIN departments d ON d.dept_id = employees.dept_id
GROUP BY dept_name;

# 9. 查询没有分配部门的员工。
SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM employees
WHERE dept_id IS NULL;

# 10. 查询参与项目数量最多的员工。
SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM employees em
JOIN employee_projects ep ON em.emp_id = ep.emp_id
GROUP BY em.emp_id
ORDER BY COUNT(ep.project_id) DESC
LIMIT 1;

# 11. 计算所有员工的工资总和。
SELECT SUM(salary) AS total_salary
FROM employees;

# 12. 查询姓"Smith"的员工信息。
SELECT *
FROM employees
WHERE last_name = 'Smith';

# 13. 查询即将在半年内到期的项目。
SELECT project_name
FROM projects
WHERE end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH);

# 14. 查询至少参与了两个项目的员工。
SELECT CONCAT(first_name,' ',last_name) AS full_name,
       COUNT(ep.project_id) AS total_project
FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id
HAVING total_project>=2;

# 15. 查询没有参与任何项目的员工。
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       job_title
FROM employees
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM employee_projects
    );

# 16. 计算每个项目参与的员工数量。
SELECT project_name,
       COUNT(ep.emp_id) AS total_emp
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id;

# 17. 查询工资第二高的员工信息。
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1,1;/*LIMIT 1 OFFSET 1*/

# 18. 查询每个部门工资最高的员工。
SELECT emp_id,
       CONCAT(first_name, ' ', last_name) AS full_name,
       salary,
       dept_id
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS salary_rank/*返回序号*/
    FROM employees e
) AS ranked_employees
WHERE salary_rank = 1;

# 19. 计算每个部门的工资总和,并按照工资总和降序排列。
SELECT DISTINCT dept_name,
                total_salary
FROM (
     SELECT d.dept_name,
            SUM(e.salary)OVER (PARTITION BY d.dept_id)AS total_salary
     FROM departments d
     JOIN employees e ON d.dept_id = e.dept_id
     )AS total_dept
ORDER BY total_salary DESC ;

# 20. 查询员工姓名、部门名称和工资。
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       dept_name,salary
FROM employees e
JOIN departments d ON d.dept_id = e.dept_id;

# 21. 查询每个员工的上级主管(假设emp_id小的是上级)。
SELECT emp_id,
       CONCAT(first_name, ' ', last_name) AS full_name,
       LAG(emp_id) OVER (PARTITION BY dept_id ORDER BY emp_id) AS superior_id,
       LAG(CONCAT(first_name, ' ', last_name)) OVER (PARTITION BY dept_id ORDER BY emp_id) AS superior_name
FROM employees;

# 22. 查询所有员工的工作岗位,不要重复。
SELECT DISTINCT job_title
FROM employees;

# 23. 查询平均工资最高的部门。
SELECT d.dept_name,
       AVG(e.salary) AS ave_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id
ORDER BY ave_salary DESC
LIMIT 1;

# 24. 查询工资高于其所在部门平均工资的员工。
SELECT emp_id,
       CONCAT(first_name, ' ', last_name) AS full_name,
       salary
FROM (
    SELECT *,
           AVG(e.salary) OVER (PARTITION BY e.dept_id) AS avg_salary
    FROM employees e
     )AS ave_e
WHERE salary > avg_salary;

# 25. 查询每个部门工资前两名的员工。
SELECT emp_id,
       CONCAT(first_name, ' ', last_name) AS full_name,
       salary,dept_id
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS salary_rank/*返回序号*/
    FROM employees e
) AS ranked_employees
WHERE salary_rank <= 2;

# 26. 查询跨部门的项目(参与员工来自不同部门)。
SELECT p.project_id, p.project_name
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY p.project_id, p.project_name
HAVING COUNT(DISTINCT e.dept_id) > 1;

# 27. 查询每个员工的工作年限,并按工作年限降序排序。
SELECT emp_id,
       first_name,
       last_name,
       DATEDIFF(CURDATE(), hire_date) / 365 AS work_age
FROM employees
ORDER BY work_age DESC;

# 28. 查询本月过生日的员工(假设hire_date是生日)。
SELECT emp_id,
       CONCAT(first_name, ' ', last_name) AS full_name,
       hire_date
FROM employees
WHERE MONTH(hire_date) = MONTH(CURDATE())
  AND YEAR(hire_date) <= YEAR(CURDATE());

# 29. 查询即将在90天内到期的项目和负责该项目的员工。
SELECT p.project_id, p.project_name, e.first_name, e.last_name
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.emp_id = e.emp_id
WHERE p.end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 90 DAY);

# 30. 计算每个项目的持续时间(天数)。
SELECT project_id, project_name,
       DATEDIFF(end_date, start_date) AS duration_days
FROM projects;

# 31. 查询没有进行中项目的部门。
# 32. 查询员工数量最多的部门。
# 33. 查询参与项目最多的部门。
# 34. 计算每个员工的薪资涨幅(假设每年涨5%)。
# 35. 查询入职时间最长的3名员工。
# 36. 查询名字和姓氏相同的员工。
# 37. 查询每个部门薪资最低的员工。
# 38. 查询哪些部门的平均工资高于公司的平均工资。
# 39. 查询姓名包含"son"的员工信息。
# 40. 查询所有员工的工资级别(可以自定义工资级别)。
# 41. 查询每个项目的完成进度(根据当前日期和项目的开始及结束日期)。
# 42. 查询每个经理(假设job_title包含'Manager'的都是经理)管理的员工数量。
# 43. 查询工作岗位名称里包含"Manager"但不在管理岗位(salary<70000)的员工。
# 44. 计算每个部门的男女比例(假设以名字首字母A-M为女性,N-Z为男性)。
# 45. 查询每个部门年龄最大和最小的员工(假设hire_date反应了年龄)。
# 46. 查询连续3天都有员工入职的日期。
# 47. 查询员工姓名和他参与的项目数量。
# 48. 查询每个部门工资最高的3名员工。
# 49. 计算每个员工的工资与其所在部门平均工资的差值。
# 50. 查询所有项目的信息,包括项目名称、负责人姓名(假设工资最高的为负责人)、开始日期和结束日期。