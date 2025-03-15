-- Department Table
CREATE TABLE Dept (
    DeptNo INT PRIMARY KEY,
    DName VARCHAR(100) NOT NULL,
    Loc VARCHAR(100)
);

-- Employee Table
CREATE TABLE Emp (
    EmpNo INT PRIMARY KEY,
    EName VARCHAR(100) NOT NULL,
    Job VARCHAR(100) NOT NULL,
    Mgr INT,
    HireDate DATE NOT NULL,
    Sal DECIMAL(10,2) NOT NULL,
    Comm DECIMAL(10,2),
    DeptNo INT,
    FOREIGN KEY (DeptNo) REFERENCES Dept(DeptNo),
    FOREIGN KEY (Mgr) REFERENCES Emp(EmpNo) -- Self-referencing FK
);


-- Insert data into Dept table
INSERT INTO Dept (DeptNo, DName, Loc) VALUES
(10, 'HR', 'New York'),
(20, 'IT', 'San Francisco'),
(30, 'Sales', 'Los Angeles');

-- Insert data into Emp table
INSERT INTO Emp (EmpNo, EName, Job, Mgr, HireDate, Sal, Comm, DeptNo) VALUES
(1001, 'John', 'Manager', NULL, '2022-01-10', 8000, NULL, 10),
(1002, 'Alice', 'Developer', 1001, '2022-02-15', 6000, NULL, 20),
(1003, 'Bob', 'Salesman', 1001, '2022-03-20', 5000, 1000, 30),
(1004, 'Charlie', 'HR Executive', 1001, '2022-04-25', 4500, NULL, 10),
(1005, 'David', 'Developer', 1002, '2022-05-30', 6200, NULL, 20);















