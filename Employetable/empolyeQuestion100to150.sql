-- --------------------------------------------------------------------------------------
-- 101 List the highest paid emp working under king.
select * from emp where sal in
(select max(sal) from emp where mgr in
(select empno from emp where ename = 'KING'));

-- 102 List the highest paid emp of Chicago joined before the most recently
-- hired emp of grade 2.
select * from emp
where sal = ( select max(sal) from emp e,dept d where e.deptno =
d.deptno and d.loc = 'CHICAGO' and
hiredate <(select max(hiredate) from emp e ,salgrade s
where e.sal between s.losal and s.hisal and s.grade = 2));

-- 103 List the details of most recently hired emp of dept 30.
select * from emp where hiredate in
(select max(hiredate) from emp where deptno = 30);
-- 104 List the highest paid emp.
select * from emp where sal in (select max(sal) from emp);
-- 105 Any emp Sal of emp5 table.
select * from emp5;
-- 106 Any Grade 4 emps Sal of emp 4 table.
select * from emp4 e,salgrade s where e.sal between s.losal and s.hisal and
s.grade = 4;
-- 107The total remuneration (sal+comm.) of all sales person of Sales dept
-- belonging to emp3 table.
select * from emp e
where (sal+nvl(comm,0)) in
(select sal+nvl(comm,0) from emp e,dept d where e.deptno=d.deptno
and d.dname = 'SALES'and e.job = 'SALESMAN');
-- 108Any emp of emp2 joined before 82.
select * from emp where to_char(hiredate,'YYYY') < 1982;

-- 109 Sal of any clerk of emp1 table.
select * from emp where job = 'CLERK';

-- 110 List the emps whose sal is same as any one of the following.
select * from emp where sal in
(select sal from emp e where emp.empno <> e.empno);

-- 111List the emps whose sal is same as ford or blake.
select * from emp where sal in (select sal from emp e where e.ename in
('FORD','BLAKE')and emp.empno <> e.empno);
-- 112List the emps whose salgrade are greater than the grade of miller.
select * from emp e,salgrade s
where e.sal between s.losal and s.hisal and s.grade >
(select s.grade from emp e,salgrade s where e.sal between s.losal and s.hisal and
e.ename = 'MILLER') ;
-- 113List the empno,ename,loc,sal,dname,loc of the all the emps belonging to king dept.
select e.empno,e.ename,d.loc,e.sal,d.dname from emp e,dept d
where e.deptno=d.deptno and e.deptno in
(select deptno from emp where ename = 'KING'and emp.empno <> e.empno);
-- 114List the mgrs who are senior to king and who are junior to smith.
select * from emp where empno in
(select mgr from emp
where hiredate<(select hiredate from emp where ename = 'KING' )
and hiredate > (select hiredate from emp where ename = 'SMITH')) and mgr
is
not null;
-- 115 List the dept 10 emps whose sal>allen sal.
select * from emp where deptno = 10 and
sal > (select sal from emp where ename = 'ALLEN');

-- 116 List the emps whose sal greater than blakes sal.
select * from emp
where sal>(select sal from emp where ename = 'BLAKE');
-- 117 List the emps who are senior to their own manager.
select * from emp w,emp m where w.mgr = m.empno and
w.hiredate < m.hiredate;
-- 118 List the emps whose job is same as either allen or sal>allen.
select * from emp
where job = (select job from emp where ename = 'ALLEN')
or sal > (select sal from emp where ename = 'ALLEN');
-- 119 List the emps who are senior to miller.
select * from emp where hiredate <(select hiredate from emp where
ename = 'MILLER');

-- 120 List the emps whose job is same as smith.
select * from emp where job = (select job from emp where ename =
'SMITH');
-- 121 List the grade 2 and 3 emp of Chicago.
select * from emp where empno in
(select empno from emp e,salgrade s where e.sal between s.losal and
s.hisal and s.grade in (2,3));
-- 122 List the empno,ename,sal,grade of all emps.
select e.empno,e.ename,e.sal,s.grade from emp e ,salgrade s
where e.sal between s.losal and s.hisal ;

-- 123 List the emps along with loc of those who belongs to dallas ,newyork with
-- sal ranging from 2000 to 5000 joined in 81.
select e.empno,e.ename,e.deptno,e.sal,d.loc from emp e ,dept d
where e.deptno = d.deptno and d.loc in ('NEW YORK','DALLAS')
and to_char(e.hiredate,'YY') = '81' and e.sal between 2000 and 5000;
-- 124List the empno, ename, sal, loc of the emps working at Chicago dallas with an exp>6ys.
select e.empno,e.ename,e.deptno,e.sal,d.loc from emp e ,dept d
where e.deptno = d.deptno and d.loc in ('CHICAGO','DALLAS')
and (months_between(sysdate,hiredate)/12)> 6 ;
-- 125 List the empno,ename,loc,dname of all the depts.,10 and 20.
select e.empno,e.ename,e.deptno,d.loc,d.dname from emp e ,dept d
where e.deptno = d.deptno and e.deptno in (10,20);
-- 126 List the empno,ename,deptno,loc of all the emps.
select e.empno,e.ename,e.deptno,d.loc from emp e ,dept d
where e.deptno = d.deptno ;
-- 127 List the details of the emps working at Chicago.
select * from emp where deptno in (select deptno from dept where dept.loc =
'CHICAGO');
-- 128 List the emps who are working as either mgr or analyst with the salary
-- ranging from 2000 to 5000 and with out comm.
select * from emp where (job in ('MANAGER' ,'ANALYST') ) and sal
between 2000 and 5000 and comm is null;
-- 129 List the emps along with exp of those working under the mgr whose
-- number is starting with 7 but should not have a 9 joined before 1983.
select * from emp where (mgr like '7%' and mgr not like '%9%')
and to_char(hiredate,'YY') < '83';

-- 130 List the unique jobs of dept 20 and 30 in desc order.
select distinct job from emp where deptno in (20,30) order by job desc;

-- 131 List the emps joined in jan with salary ranging from 1500 to 4000.
select * from emp where to_char(hiredate,’MON’) = 'JAN' and sal between 1500 and 4000;
-- 132 List the mgrs of dept 10 or 20
select * from emp where job = 'MANAGER' and (deptno = 10 or deptno
=20);

-- 133 List the emp who are clerks who have exp more than 8ys.
select * from emp where job = 'CLERK'and
(months_between(sysdate,hiredate) /12) > 8;

-- 134 List the emp who joined in 80’s.
select * from emp where to_char(hiredate,’YY’) between '80' and '89';
-- 135 List the emps whose salary is 4 digit number.
select * from emp where length (sal) = 4;
-- 136Who joined in the month having second char 'a’
select * from emp where to_char(hiredate,’MON’) like '_A%'; 
-- 137 Who joined in the month having char 'a’.

select * from emp where to_char (hiredate,'MONTH')like'%A%' ; 

-- 138 List the emp who joined in the month of JAN.
select * from emp where to_char(hiredate,'MON') = 'JAN';
-- 139 List the emps whose sal is ending with 00.
select * from emp where sal like '%00';
-- 140 List the emps who joined in the year 81.
select * from emp where to_char(hiredate,’YY’) = '81';
-- 141 List names start with 'M'.
select * from emp where ename like 'M%';
-- 142 List the emps end with 'H’ all together 5 chars.
select * from emp where ename like '%H' and length (ename) = 5;

-- 143 List the emp names starting with 'M' with 5 chars.
select * from emp where ename like 'M%' and length (ename) = 5;
-- 144 List all the 4char emps.
select * from emp where length (ename) = 4;

-- 145 List the emps who joined in the second half of 82.
select * from emp where hiredate between '01-JUL-82' and '31-DEC-82';
-- 146 List the emps working under the mgrs 7369,7890,7654,7900.
select * from emp where mgr in ( 7369,7890,7654,7900);
-- 147 List the emps whose annual sal ranging from 23000 to 40000.
select * from emp where (12* sal) between 23000 and 40000;
-- 148  List the emps who have joined in the year 1981.
select * from emp where to_char(hiredate,'YYYY') = ‘1981’;
-- 149 List the emps who have joined on the following dates 1 may 81,17 nov 81,30 dec 81
select * from emp where to_char(hiredate,’DD-MON-YY’) in
('01-MAY-81','17-NOV-81','30-DEC-81');
-- 150 List the emps who are either clerks or managers.
select * from emp where job in ('CLERK','MANAGER');