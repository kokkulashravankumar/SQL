select * from emp;
-- 21.List the Enames those are starting with ‘S’ and with five characters
select * from emp where EName like 's%';

-- 22.List the emps those are having four chars and third character must be ‘r’
select * from emp where EName like '____r%';

-- 23. List the Five character names starting with ‘S’ and ending with ‘H’
select * from emp where EName like '%S___H%';

select * from emp where length(EName)=5 and EName like 'S%H'; 

-- 24 . List the emps who joined in January
select * from emp where month(HireDate) = '1'; 

-- 25. List the emps who joined in the month of which second character is ‘a’.

select * from emp where date_format(hireDate,'%M') like '_a%';

-- 26. List the emps whose Sal is four digit number ending with Zero.

SELECT *  FROM Emp  WHERE Sal BETWEEN 1000 AND 9999 AND Sal LIKE '%0';

-- 27. List the emps whose names having a character set ‘ll’ together.

SELECT *  FROM Emp  WHERE Ename like '%LL%';

-- 28 .List the emps those who joined in 80’s

SELECT date_format(HireDate,'%y')  FROM Emp  where date_format(HireDate,'y') like '2%';

-- 29. List the emps who does not belong to Deptno 20.

select * from emp where DeptNo not like 20;

select * from emp where DeptNo != 20;

-- 30.List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries.

select * from emp where Job not in ('PRESIDENT') order by Mgr asc;

select * from emp where Job not like "%PRESIDENT%" order by mgr asc;

-- 31.List all the emps who joined before or after 1981.

SELECT * FROM Emp  WHERE DATE_FORMAT(HireDate, '%Y') NOT IN ('2022');

--  32.List the emps whose Empno not starting with digit78.
select * from emp where EmpNo not like '10%';

-- 33.List the emps who are working under ‘MGR’.

select * from emp where EmpNo In ( select EmpNo  emp where EmpNo not in (select EmpNo from  emp where mgr != "")) ;

select * from emp where EmpNo not in (select EmpNo from  emp where mgr != "") ;

-- 34.List the emps who joined in any year but not belongs to the month of March.

select * from emp where date_format(HireDate,'%m') not in (03);

-- 35. List all the Clerks of Deptno 10.

select * from emp where Job = 'Clerk' and DeptNo = 10;

-- 36. List the emps of Deptno 30 or 20 joined in the year 1981

select *  from emp where date_format(HireDate,'%y') = 19 and DeptNo in (30,20);

--  37. Display the details of SMITH.

select * from emp where Ename like "%SMITH%";

--  38 .Display the location of SMITH

select dept.Loc from emp Inner join dept on emp.DeptNo = dept.DeptNo where emp.EName like "%SMITH%";

--  39.List the total information of EMP table along with DNAME and Loc of 
-- all the emps Working Under ‘ACCOUNTING’ & ‘RESEARCH’ in the asc
-- Deptno.

select * from emp as e Inner join dept d on e.DeptNo = d.DeptNo where d.DName = 'ACCOUNTING' 
and d.DName = 'RESEARCH' order by d.DeptNo ;

select * from emp as e Inner join dept d on e.DeptNo = d.DeptNo where DName  IN ('Accounting'  'Research')
order by d.DeptNo ;

-- 40. List the Empno, Ename, Sal, Dname of all the ‘MGRS’ and ‘ANALYST’
-- working in chicago, Dallas with an exp more than 7 years without receiving
-- the Comm asc order of Loc.

select * from emp;
select Empno ,Ename,Sal,Job,Dname,d.loc from emp e inner join dept as d on d.DeptNo = e.DeptNo 
where e.Job In ('Manager','Analyst');




SELECT 
    e.EmpNo, 
    e.EName, 
    e.Sal, 
    d.DName 
FROM Emp e  
JOIN Dept d ON e.DeptNo = d.DeptNo  
WHERE d.Loc IN ('NEW YORK', 'DALLAS')  
AND e.EmpNo IN (
    SELECT e2.EmpNo  
    FROM Emp e2  
    WHERE e2.Job IN ('MANAGER', 'ANALYST')  
    AND TIMESTAMPDIFF(YEAR, e2.HireDate, CURDATE()) > 7  
    AND e2.Comm IS NULL
)  
ORDER BY d.Loc ASC;



-- 41.Display the Empno, Ename, Sal, Dname, Loc, Deptno, Job of all emps
-- working at CJICAGO or working for ACCOUNTING dept with Ann
-- Sal>28000, but the Sal should not be=3000 or 2800 who doesn’t belongs to the
-- Mgr and whose no is having a digit ‘7’ or ‘8’ in 3rd position in the asc order of
-- Deptno and desc order of job.



SELECT 
    E.EmpNo, 
    E.EName, 
    E.Sal, 
    D.DName, 
    D.Loc, 
    E.DeptNo, 
    E.Job
FROM Emp E  
JOIN Dept D ON E.DeptNo = D.DeptNo  
WHERE 
    (D.Loc = 'CHICAGO' OR D.DName = 'ACCOUNTING')  
    AND E.EmpNo IN (
        SELECT E2.EmpNo  
        FROM Emp E2  
        WHERE (12 * E2.Sal) > 28000  
        AND E2.Sal NOT IN (3000, 2800)  
        AND E2.Job != 'MANAGER'  
        AND (E2.EmpNo LIKE '__7%' OR E2.EmpNo LIKE '__8%')
    )  
ORDER BY E.DeptNo ASC, E.Job DESC;

-- 42. Display the total information of the emps along with Grades in the asc order.

select * from salgrade;

select * from emp;

SELECT E.*, S.Grade 
FROM Emp E  
JOIN SalGrade S ON E.Sal BETWEEN S.Losal AND S.Hisal  
ORDER BY S.Grade ASC;

truncate table salgrade;

CREATE TABLE SalGrade (
    Grade INT PRIMARY KEY,
    Losal DECIMAL(10,2) NOT NULL,
    Hisal DECIMAL(10,2) NOT NULL
);


INSERT INTO SalGrade (Grade, Losal, Hisal) VALUES
(1, 30000, 39999),  -- Grade 1 (30K - 39K)
(2, 40000, 49999),  -- Grade 2 (40K - 49K)
(3, 50000, 59999),  -- Grade 3 (50K - 59K)
(4, 60000, 69999),  -- Grade 4 (60K - 69K)
(5, 70000, 79999),  -- Grade 5 (70K - 79K)
(6, 80000, 89999),  -- Grade 6 (80K - 89K)
(7, 90000, 99999);  -- Grade 7 (90K - 99K)

-- 43.List all the Grade2 and Grade 3 emps.

select E.*,s.Grade from emp e join salgrade s where e.Sal between s.Losal and s.Hisal  and
Grade  in(2,3) order by Grade desc  ;


-- 44.Display all Grade 4,5 Analyst and Mgr.

select E.*,s.Grade from emp e join salgrade s where e.Sal between s.Losal and s.Hisal  and
Grade  in(4,5) and e.Job in('Analyst','Manager') order by Grade desc  ;

-- 45. List the Empno, Ename, Sal, Dname, Grade, Exp, and Ann Sal of emps working for Dept10 or20.

SELECT 
    E.EmpNo, 
    E.Ename, 
    E.Sal, 
    D.DName, 
    S.Grade, 
    TIMESTAMPDIFF(YEAR, E.HireDate, CURDATE()) AS Exp,  -- Experience in years
    (12 * E.Sal) AS AnnSal  -- Annual Salary
FROM Emp E
JOIN Dept D ON E.DeptNo = D.DeptNo
JOIN SalGrade S ON E.Sal BETWEEN S.Losal AND S.Hisal
WHERE E.DeptNo IN (10, 20);



/* 46.  List all the information of emp with Loc and the Grade of all the emps
 belong to the Grade range from 2 to 4 working at the Dept those are not starting
 with char set ‘OP’ and not ending with ‘S’ with the designation having a char ‘a’
 any where joined in the year 1981 but not in the month of Mar or Sep and Sal
 not end with ‘00’ in the asc order of Grades*/


SELECT 
    E.*, 
    D.Loc, 
    S.Grade 
FROM Emp E
JOIN Dept D ON E.DeptNo = D.DeptNo
JOIN SalGrade S ON E.Sal BETWEEN S.Losal AND S.Hisal
WHERE 
    S.Grade BETWEEN 2 AND 4  -- Employees with Grade 2 to 4
    AND D.DName NOT LIKE 'OP%'  -- Dept name should not start with 'OP'
    AND D.DName NOT LIKE '%S'  -- Dept name should not end with 'S'
    AND E.Job LIKE '%a%'  -- Job should contain 'a' anywhere
    AND YEAR(E.HireDate) = 1981  -- Hired in 1981
    AND MONTH(E.HireDate) NOT IN (3, 9)  -- Not in March or September
    AND E.Sal NOT LIKE '%00'  -- Salary should not end with '00'
ORDER BY S.Grade ASC;

--  47. List the details of the Depts along with Empno, Ename or without the emps

SELECT 
    D.DeptNo, 
    D.DName, 
    D.Loc, 
    E.EmpNo, 
    E.EName 
FROM Dept D  
LEFT JOIN Emp E ON D.DeptNo = E.DeptNo;

--  48 .List the details of the emps whose Salaries more than the employee Robert Brown.

select * from emp where sal > (select sal from emp where ename = 'Robert Brown');

-- 49.List the emps whose Jobs are same as David Wilson

select * from emp where job = (select Job from emp where ename = 'David Wilson');

-- 50.List the emps who are senior to John Doe

select * from emp where hiredate < ( select hiredate from emp where ename= 'John Doe');

