create database payroll ;
use payroll;

-- Employees Table:
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    hire_date DATE,
    role_id INT,
    department_id INT,
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);



-- Roles Table:
CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(100)
);




-- Departments Table:

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);



-- Salaries Table:

CREATE TABLE salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    base_salary DECIMAL(10, 2),
    bonus DECIMAL(10, 2) DEFAULT 0.00,
    deductions DECIMAL(10, 2) DEFAULT 0.00,
    total_salary DECIMAL(10, 2) AS (base_salary + bonus - deductions) STORED,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


-- Leaves Table:
CREATE TABLE leaves (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    leave_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    status ENUM('Approved', 'Pending', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Payments Table:
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Taxes Table:

CREATE TABLE taxes (
    tax_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    tax_amount DECIMAL(10, 2),
    tax_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

show tables;
select * from employees;
select * from roles;
select * from departments;
select * from salaries;
select * from leaves;
select * from payments;
select * from taxes;
INSERT INTO roles (role_id, role_name) VALUES (1, 'Manager');

INSERT INTO roles (role_id, role_name) VALUES 
(2, 'Software Engineer'),
(3, 'HR Specialist'),
(4, 'Accountant'),
(5, 'Sales Executive'),
(6, 'Marketing Manager'),
(7, 'IT Support'),
(8, 'Project Manager'),
(9, 'Data Analyst'),
(10, 'CEO');




INSERT INTO departments (department_id, department_name) VALUES (2, 'HR');


INSERT INTO departments (department_id, department_name) VALUES 
(1, 'IT'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing'),
(6, 'Customer Support'),
(7, 'Legal'),
(8, 'Operations'),
(9, 'R&D'),
(10, 'Administration');



-- Insert an Employee:
INSERT INTO employees (first_name, last_name, email, phone, hire_date, role_id, department_id)
VALUES ('John', 'Doe', 'john.doe@example.com', '555-1234', '2025-02-28', 1, 2);

-- Add Salary Information:
INSERT INTO salaries (employee_id, base_salary, bonus, deductions)
VALUES (5, 5000.00, 500.00, 100.00);

-- Record Leave Request:
INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (5, 'Sick', '2025-03-01', '2025-03-03', 'Pending');


 -- Make a Payment:
INSERT INTO payments (employee_id, payment_date, amount, payment_method)
VALUES (5, '2025-02-28', 5400.00, 'Bank Transfer');

 -- Generate Tax Deductions:
INSERT INTO taxes (employee_id, tax_amount, tax_date)
VALUES (5, 400.00, '2025-02-28');

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 5;

-------------------------------------------------------------------------------------------------------------

-- Employee CRUD Operations
-- 1 create employee data
INSERT INTO employees (first_name, last_name, email, phone, hire_date, role_id, department_id)
VALUES ('Hari', 'krish', 'harikrish@example.com', '555-5678', '2025-03-01', 2, 3);

INSERT INTO employees (first_name, last_name, email, phone, hire_date, role_id, department_id)
VALUES ('jackie', 'chan', 'jackiecan@example.com', '555-5348', '2025-04-1', 3, 4), 
('jennifer','k','jannifer@gmail.com', '555-8765','205-05-1',4,5),
('sara', 'kmugdha', 'sarakmugdha@example.com', '555-1234', '2025-02-15', 5, 6),
('nandhini', 'k', 'nandhinik@example.com', '555-8765', '2025-01-20', 6, 7),
('Michael', 'r', 'michaelr@example.com', '555-4321', '2025-03-10', 7, 8),
('Samantha', 's', 'samanthas@example.com', '555-6789', '2025-02-25', 8, 9),
('David', 'Johnson', 'davidjohnson@example.com', '555-9876', '2025-03-05', 9, 10),
('Dhoni', 'ms', 'dhonims@example.com', '555-1276', '2025-01-09', 9, 10);

--  2 read employeee data
SELECT * FROM employees WHERE employee_id = 8;
SELECT * FROM employees WHERE employee_id = 5;
SELECT * FROM employees WHERE employee_id = 15;
SELECT * FROM employees WHERE employee_id = 13;

-- 3 update employee data

update employees set role_id = 10, department_id= 1 where employee_id =15;
update employees set hire_date= '2025-10-29' where employee_id=10;
update employees
SET phone = '555-9999', status = 'Inactive'
WHERE employee_id = 9;

-- 4 delete employee data
DELETE FROM employees WHERE employee_id = 14;

-----------------------------------------------------------------------------------------------------------------------------

-- Leave Management: 1 Employees can apply for leaves:

INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (7, 'Vacation', '2025-04-10', '2025-04-15', 'Pending'),
(8, 'sick', '2025-04-10', '2025-04-15', 'Pending');

-- 2.HR can approve or reject them:

update leaves SET status = 'Approved' where leave_id in (6,7);

-------------------------------------------------------------------------------------------------------------------------------
-- Payroll Calculation
INSERT INTO salaries (employee_id, base_salary, bonus, deductions) VALUES
(5, 5000.00, 500.00, 100.00), 
(7, 6000.00, 700.00, 150.00), 
(8, 5500.00, 600.00, 120.00), 
(9, 4800.00, 400.00, 80.00), 
(10, 5200.00, 450.00, 90.00), 
(11, 7000.00, 800.00, 200.00), 
(12, 7500.00, 900.00, 250.00), 
(13, 8000.00, 1000.00, 300.00), 
(15, 9000.00, 1200.00, 400.00);
delete from salaries where salary_id =3;

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE e.employee_id = 15;

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE e.employee_id = 10;

select * from salaries;
-----------------------------------------------------------------------------------------------------------------------------

-- Tax Management
-- deduct tax for employee
insert into taxes (employee_id, tax_amount, tax_date) values
(5, 250.00, '2025-03-01'), -- hari krish
(7, 300.00, '2025-04-01'), -- jackie chan
(8, 275.00, '2025-05-01'), -- jennifer k
(9, 220.00, '2025-02-15'), -- sarakmugdha
(10, 260.00, '2025-01-20'), -- nandhini k
(11, 350.00, '2025-03-10'), -- michael r
(12, 400.00, '2025-02-25'), -- samantha s
(13, 450.00, '2025-03-05'), -- david johnson
(15, 500.00, '2025-01-09'); -- Dhoni MS

-- retrieve tax details:

SELECT e.first_name, e.last_name, t.tax_amount, t.tax_date
FROM employees e
JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 15;


select * from taxes;

-------------------------------------------------------------------------------------------------------------------------
-- Pay Slip Generation:

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount,
       (s.total_salary - IFNULL(t.tax_amount, 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 5; -- john doe

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount,
       (s.total_salary - IFNULL(t.tax_amount, 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 7; -- hari krish

SELECT e.first_name, e.last_name, s.base_salary, s.bonus, s.deductions, s.total_salary, t.tax_amount,
       (s.total_salary - IFNULL(t.tax_amount, 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN taxes t ON e.employee_id = t.employee_id
WHERE e.employee_id = 15; -- Dhoni  MS

---------------------------------------------------------------------------------------------------------------------------------
-- Reports

-- 1.payroll
SELECT e.employee_id, e.first_name, e.last_name,r.role_name, d.department_name, s.base_salary, s.bonus, s.deductions, s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN roles r ON e.role_id = r.role_id ;

-- 2.tax report
SELECT e.employee_id, e.first_name, e.last_name, SUM(t.tax_amount) AS total_tax
FROM employees e
JOIN taxes t ON e.employee_id = t.employee_id
GROUP BY e.employee_id;

-- 3.leave report
SELECT e.employee_id, e.first_name, e.last_name, COUNT(l.leave_id) AS total_leaves
FROM employees e
JOIN leaves l ON e.employee_id = l.employee_id
WHERE l.status = 'Approved'
GROUP BY e.employee_id;








