-- Drop tables if they exist (to avoid foreign key conflicts)
DROP TABLE IF EXISTS EMP;
DROP TABLE IF EXISTS DEPT;

-- Create DEPT table
CREATE TABLE DEPT (
  DEPTNO INT PRIMARY KEY,
  DNAME VARCHAR(20),
  LOC VARCHAR(20)
);

-- Insert DEPT data
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES
(10, 'ACODUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- Create EMP table
CREATE TABLE EMP (
  EMPNO INT PRIMARY KEY,
  ENAME VARCHAR(20),
  JOB VARCHAR(20),
  MGR INT,
  HIREDATE DATE,
  SAL DECIMAL(10, 2),
  COMM DECIMAL(10, 2),
  DEPTNO INT,
  FOREIGN KEY (MGR) REFERENCES EMP(EMPNO),
  FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);


-- First insert all higher-level employees (managers)
INSERT INTO EMP VALUES 
(7839, 'KING', 'PRESIDENT', NULL, STR_TO_DATE('17-Nov-81', '%d-%b-%y'), 5000, NULL, 10),
(7566, 'JONES', 'MANAGER', 7839, STR_TO_DATE('02-Apr-81', '%d-%b-%y'), 2975, NULL, 20),
(7698, 'BLAKE', 'MANAGER', 7839, STR_TO_DATE('01-May-81', '%d-%b-%y'), 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, STR_TO_DATE('09-Jun-81', '%d-%b-%y'), 2450, NULL, 10),
(7398, 'JONES2', 'MANAGER', 7839, STR_TO_DATE('10-Mar-81', '%d-%b-%y'), 2500, NULL, 30);  -- INSERT MGR 7398

-- Then insert other employees
INSERT INTO EMP VALUES  
(7902, 'FORD', 'ANALYST', 7566, STR_TO_DATE('03-Dec-81', '%d-%b-%y'), 3000, NULL, 20),
(7788, 'SCOTT', 'ANALYST', 7566, STR_TO_DATE('09-Dec-82', '%d-%b-%y'), 3000, NULL, 20),
(7876, 'ADAMS', 'CLERK', 7788, STR_TO_DATE('12-Jan-83', '%d-%b-%y'), 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, STR_TO_DATE('03-Dec-81', '%d-%b-%y'), 950, NULL, 30),
(7521, 'WARD', 'SALESMAN', 7698, STR_TO_DATE('22-Feb-81', '%d-%b-%y'), 1250, 500, 30),
(7499, 'ALLEN', 'SALESMAN', 7398, STR_TO_DATE('20-Feb-81', '%d-%b-%y'), 1600, 300, 30),
(7654, 'MARTIN', 'SALESMAN', 7698, STR_TO_DATE('28-Sep-81', '%d-%b-%y'), 1250, 1400, 30),
(7844, 'TURNER', 'SALESMAN', 7698, STR_TO_DATE('08-Sep-81', '%d-%b-%y'), 1500, NULL, 30),
(7369, 'SMITH', 'CLERK', 7902, STR_TO_DATE('12-Dec-80', '%d-%b-%y'), 800, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, STR_TO_DATE('23-Jan-82', '%d-%b-%y'), 1300, NULL, 10);




-- 51. List the Emps who are senior to their own MGRS
select * from emp w,emp m where w.mgr = m.empno and w.hiredate <
m.hiredate ; 

-- 52. List the Emps of Deptno 20 whose Jobs are same as Deptno10 

select * from emp as w where Deptno = 20 and w.Job in (select e.Job from emp as e where DeptNo = 10);

--  53. List the Emps whose Sal is same as FORD or SMITH in desc order of Sal

Select * from emp where sal in (select sal from emp where ( ename = ‘SMITH’
or ename = ‘FORD’ )) order by sal desc;

--  54.List the emps Whose Jobs are same as MILLER or Sal is more than ALLEN.
select * from emp where emp.JOB in (select JOB from emp  where ENAME = 'MILLER') or 
emp.SAL >= (select SAL from emp where ENAME = 'ALLEN');

-- 55 List the Emps whose Sal is > the total remuneration of the SALESMAN

select * from emp where SAL >(select sum(nvl2(comm,sal+comm,sal)) from
emp where job = ‘SALESMAN’);
-- 56  List the emps who are senior to BLAKE working at CHICAGO & BOSTON.
select * from dept ;
select * from emp as e inner join  dept as dp  where e.DEPTNO = dp.DEPTNO and 
dp.LOC in ("CHICAGO","BOSTON") and month(e.HIREDATE)  >= (select month(EW.HIREDATE) from emp ew where ew.ENAME = 'BLAKE');

-- 57 List the Emps of Grade 3,4 belongs to the dept ACCOUNTING and
-- RESEARCH whose Sal is more than ALLEN and exp more than SMITH in the
-- asc order of EXP.
select * from emp e where e.deptno in (select d.deptno from dept d where
d.dname in (‘ACCOUNTING’,’RESEARCH’) ) and
e.sal >(select sal from emp where ename = ‘ALLEN’) and
e.hiredate <( select hiredate from emp where ename = ‘SMITH’) and
e.empno in (select e.empno from emp e ,salgrade s where e.sal between s.losal
and s.hisal and s.grade in (3,4) )
order by e.hiredate desc;


-- 58 List the emps whose jobs same as SMITH or ALLEN.
select * from emp where job in (select job from emp where ename in ("SMITH","ALLEN"));
 
-- 59  Write a Query to display the details of emps whose Sal is same as of
-- 60  Any jobs of deptno 10 those that are not found in deptno 20
select e.job from emp e where e.deptno = 10 and e.job not in (select job from
emp where deptno =20);

-- 61 List of emps of emp1 who are not found in emp2
-- 62 Find the highest sal of EMP table.
 select max(sal) from emp;
-- 63 Find details of highest paid employee. 
 select * from emp where sal in (select max(sal) from emp);

use praticse_sql;
-- 64 Find the highest paid employee of sales department.
select * from emp where sal in (select max(SAL) from emp where DEPTNO = (select DEPTNO from dept where DNAME='SALES'));

-- 65 List the most recently hired emp of grade3 belongs to location CHICAGO.
select * from emp;
select * from dept;
 select * from emp e where e.deptno in ( select d.deptno from dept d where
d.loc = 'CHICAGO') and
e.hiredate in (select max(hiredate) from emp where empno in (select empno
from emp e,salgrade s
where e.sal between s.losal and s.hisal and s.grade = 3)) ;


-- 66 List the employees who are senior to most recently hired employee	working under king.
select * from emp;
select * from dept;

select * from emp where hiredate < (select max(hiredate) from emp where
mgr in
(select empno from emp where ename = 'KING')) ;

-- 67. List the details of the employee belongs to newyork with grade 3 to 5
-- except ‘PRESIDENT’ whose sal> the highest paid employee of Chicago in a
-- group where there is manager and salesman not working under king
select * from emp where deptno in (select deptno from dept where dept.loc
='NEW YORK')
and empno in (select empno from emp e,salgrade s where e.sal between s.losal
and s.hisal and
s.grade in (3,4,5) ) and job != 'PRESIDENT' and sal >(select max(sal) from emp
where deptno in
(select deptno from dept where dept.loc = 'CHICAGO') and job in
('MANAGER','SALESMAN') and
mgr not in (select empno from emp where ename = 'KING'));


-- 68. List the details of the senior employee belongs to 1981.
select * from emp where hiredate in (select min(hiredate) from emp
where to_char( hiredate,’YYYY’) = ‘1981’);

-- 69. List the employees who joined in 1981 with the job same as the most
-- senior person of the year 1981. 

select * from emp where job in (select job from emp where hiredate in
(select min(hiredate) from emp where to_char(hiredate,’YYYY’) =’1981’));

-- 70 List the most senior empl working under the king and grade is more	than 3.
select * from emp where hiredate in (select min(hiredate) from emp where
empno in
(select empno from emp e ,salgrade s where e.sal between s.losal and s.hisal and
s.grade in (4,5)))
and mgr in (select empno from emp where ename = 'KING');


-- 71 Find the total sal given to the MGR 
select sum(SAL) from emp where emp.MGR in(select MGR from emp);

-- 72 Find the total annual sal to distribute job wise in the year 81.

select sum(sal*12) as total_annual_sal,Job from emp where HIREDATE between '1981-01-01' and '1981-12-31' group by JOB;

-- 73.  Display total sal employee belonging to grade 3.
select sum(sal) from emp where empno
in (select empno from emp e ,salgrade s
where e.sal between s.losal and s.hisal and s.grade = 3);

-- 74 Display the average salaries of all the clerks.

select avg(sal) from emp where emp.Job = 'CLERK';

-- 75 List the employeein dept 20 whose sal is >the average sal 0f dept 10 emps
select * from emp where deptno = 20 and sal >(select avg(sal) from emp where deptno = 10);

-- 76 Display the number of employee for each job group deptno wise.
select deptno,Job, count(empno) from emp group by deptno,job;

-- 77 List the manage rno and the number of employees working for those
-- mgrs in the ascending Mgrno.

select w.mgr ,count(*) from emp w,emp m
where w.mgr = m.empno
group by w.mgr
order by w.mgr asc;

-- 78 List the department,details where at least two emps are working
select deptno , count(*) as totalcount from emp group by deptno having count(*)>=2;

-- 79 Display the Grade, Number of emps, and max sal of each grade

select s.grade ,count(*),max(sal) from emp e,salgrade s where e.sal between
s.losal and s.hisal
group by s.grade;

-- 80 Display dname, grade, No. of emps where at least two emps are clerks.
select d.dname,s.grade,count(*) from emp e,dept d,salgrade s where e.deptno
= d.deptno and
e.job = 'CLERK' and e.sal between s.losal and s.hisal group by d.dname,s.grade
having count(*) >= 2;

-- 81 List the details of the department where maximum number of emps are working.

select d.deptno,d.dname,d.loc,count(*) from emp e ,dept d
where e.deptno = d.deptno group by d.deptno,d.dname,d.loc
having count(*) = (select max(count(*) ) from emp group by deptno);


-- 82 Display the emps whose manager name is jones.
select * from emp where mgr in
(select empno from emp where ename = 'JONES');


-- 83 List the employees whose salary is more than 3000 after giving 20% increment.
SELECT * FROM EMP WHERE (1.2*SAL) > 3000 ;

-- 84 List the emps with dept names.
select * from emp;
select * from dept;
select e.Ename ,d.dname from emp as e inner join dept as d on e.deptno = d.deptno;


-- 85 List the emps who are not working in sales dept

select * from emp as e inner join dept as d on e.deptno = d.deptno where d.dname != 'SALES';

-- 86 List the emps name ,dept, sal and comm. For those whose salary is
-- between 2000 and 5000 while loc is Chicago.

select e.ename,e.deptno,e.sal,e.comm from emp e ,dept d where e.deptno =
d.deptno and
d.loc = 'CHICAGO' and e.sal between 2000 and 5000;

-- 87 List the emps whose sal is greater than his managers salary
select * from emp w,emp m where w.mgr = m.empno and w.sal > m.sal;

-- 88 List the grade, EMP name for the deptno 10 or deptno 30 but sal grade is
-- not 4 while they joined the company before ’31-dec-82’.

select s.grade ,e.ename from emp e,salgrade s where e.deptno in (10,20) and
hiredate < ('31-DEC-82') and (e.sal between s.losal and s.hisal and s.grade not in
(4));

-- 89  List the emps whose mgr name is jones and also list their manager name

select w.empno,w.ename,w.job,w.mgr,w.hiredate,w.sal,w.deptno,m.ename
from emp w ,emp m
where w.mgr = m.empno and m.ename = 'JONES';

-- 90 List the name and salary of ford if his salary is equal to hisal of his grade.
select e.ename,e.sal from emp e ,salgrade s where e.ename = 'FORD' and
e.sal between s.losal and s.hisal and e.sal = s.hisal ;

-- 91 Lit the name, job, dname ,sal, grade dept wise
select e.ename,e.job,d.dname,e.sal,s.grade from emp e,dept d,salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal
order by e.deptno ;

-- 92 List the emp name, job, sal, grade and dname except clerks and sort on the basis of highest sal.

select e.ename,e.job,e.sal,s.grade,d.dname from emp e ,dept d ,salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal and
e.job not in('CLERK')
order by e.sal desc;

-- 93 List the emps name, job who are with out manager.

select e.ename,e.job from emp e where mgr is null;

-- 94 List the names of the emps who are getting the highest sal dept wise.
select e.ename,e.deptno from emp e where e.sal in
(select max(sal) from emp group by deptno) ;

-- 95 List the emps whose sal is equal to the average of max and minimum
select * from emp where sal =(select (max(sal)+min(sal))/2 from emp);

-- 96 List the no. of emps in each department where the no. is more than 3.
select deptno,count(*) from emp group by deptno having count(*) < 3;

-- 97 List the names of depts. Where atleast 3 are working in that department.

select d.dname,count(*) from emp e ,dept d where e.deptno = d.deptno
group by d.dname
having count(*) >= 3 ;

-- 98 List the managers whose sal is more than his employess avg salary
select * from emp m where m.empno in (select mgr from emp)
and m.sal > (select avg(e.sal) from emp e where e.mgr = m.empno
);

-- 99 List the Name , Salary, Comm and Net Pay is more than any other employee.

select e.ename,e.sal,e.comm,nvl2(comm,sal+comm,sal) NETPAY
from emp e where nvl2(comm,sal+comm,sal) > any (select sal from emp where empno
=e.empno) ;

-- 100 List the Enames who are retiring after 31-Dec-89 the max Job period is 20Y.

select ename from emp where add_months(hiredate,240) > '31-DEC-89';

