use praticse_sql;


select *from emp;

-- List the emps in the asc order of their Salaries
 select * from emp order by sal asc;

-- Display all the unique job groups in the descending order?

select * from emp as e group by e.EmpNo order by e.Job desc;

select distinct mgr from emp;


-- List the details of the emps in asc order of the Dptnos and desc of Jobs?

select * from emp order by DeptNo asc,Job desc;


-- Display all the unique job groups in the descending order?

select * from emp group by EmpNo order by Job desc;


--  Display all the details of all ‘Mgrs’

select * from emp;

select * from emp where mgr in (select mgr from emp);

-- List the emps who joined before 1981
select * from emp;

select * from emp where HireDate < '2022-01-20';

-- List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal

select sal,sal*12 from emp ;
select EmpNo,EName,Sal,Sal*12 as annualsalary from emp order by Sal*12 asc;

select * from dept;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Emp;
TRUNCATE TABLE Dept;
SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO Dept (DeptNo, DName, Loc) VALUES
(10, 'Accounting', 'New York'),
(20, 'Research', 'Dallas'),
(30, 'Sales', 'Chicago'),
(40, 'Operations', 'Boston');

INSERT INTO Emp (EmpNo, EName, Job, Mgr, HireDate, Sal, Comm, DeptNo) VALUES
(106, 'William Black', 'President', NULL, '2018-11-05', 100000.00, NULL, 40);

INSERT INTO Emp (EmpNo, EName, Job, Mgr, HireDate, Sal, Comm, DeptNo) VALUES
(103, 'Robert Brown', 'Manager', 106, '2019-09-20', 70000.00, NULL, 20),
(108, 'David Wilson', 'Manager', 106, '2021-07-15', 75000.00, NULL, 30);

INSERT INTO Emp (EmpNo, EName, Job, Mgr, HireDate, Sal, Comm, DeptNo) VALUES
(104, 'Emily Johnson', 'Analyst', 106, '2020-02-25', 60000.00, NULL, 20),
(105, 'Michael White', 'Salesman', 103, '2023-03-18', 40000.00, 3000.00, 30),
(109, 'Linda Adams', 'Analyst', 108, '2022-01-25', 62000.00, NULL, 30),
(110, 'James Clark', 'Salesman', 108, '2023-05-20', 38000.00, 2000.00, 30);


INSERT INTO Emp (EmpNo, EName, Job, Mgr, HireDate, Sal, Comm, DeptNo) VALUES
(101, 'John Doe', 'Clerk', 104, '2021-05-10', 30000.00, NULL, 10),
(102, 'Jane Smith', 'Salesman', 105, '2022-06-15', 45000.00, 5000.00, 30),
(107, 'Sarah Green', 'Clerk', 103, '2022-12-01', 32000.00, NULL, 10);








