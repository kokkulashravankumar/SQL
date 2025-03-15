-- List the Empno, Ename, Sal, Exp of all emps working for Mgr 1001.

select * from emp;
select EmpNo,EName,HireDate from emp where Mgr = 1001;

-- Display all the details of the emps whose Comm. Is more than their Sal.
select * from emp where Comm >Sal;

-- List the emps in the asc order of Designations of those joined after the second half of 2022
SELECT * FROM emp  
WHERE hiredate < '2022-06-01' 
AND YEAR(hiredate) = 2022 
ORDER BY job ASC;

-- List the emps along with their Exp and Daily Sal is more than Rs.100.

select EmpNo,EName,Sal,Sal/30 as perdaysalary from emp where Sal/30 >100;

-- List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.
select * from emp where Job = 'CLERK' or Job = "ANALYST" order by Job asc;

-- List the emp who are working for the Deptno 10 or20
select * from emp where DeptNo = 10 or DeptNo = 20;

-- List the emps who are joined in the year 21
select * from emp where year(HireDate) = 2021;

-- List the emps who are joined in the month of jun 2022.
select * from emp where HireDate between '2021-05-01' and '2022-05-31';

-- List the emps Who Annual sal ranging from 22000 and 45000

select EmpNo,EName,sal, sal*12 as annualsalary from emp  where 12*sal between '22000.00' and '45000.00';


-- List the Enames those are having five characters in their Names

select  * from emp where length(EName) = 10;


