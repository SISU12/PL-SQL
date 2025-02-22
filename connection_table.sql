/*

C:\Users\USER>SQLPLUS

SQL*Plus: Release 21.0.0.0.0 - Production on Wed Jan 29 16:35:01 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

Enter user-name: SYSTEM
Enter password:
Last Successful login time: Wed Jan 29 2025 16:34:02 +02:00

Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> SHOW CON_NAME;

CON_NAME
------------------------------
CDB$ROOT
SQL> SELECT NAME, OPEN_MODE FROM V$PDBS;

NAME
--------------------------------------------------------------------------------
OPEN_MODE
----------
PDB$SEED
READ ONLY

XEPDB1
READ WRITE


SQL> ALTER SESSION SET CONTAINER = XEPDB1;

Session altered.

SQL> SHOW CON_NAME;

CON_NAME
------------------------------
XEPDB1
SQL> CREATE USER PRACTICE IDENTIFIED BY 27089;

User created.

SQL> GRANT DBA TO PRACTICE;

Grant succeeded.

SQL> CONNECT PRACTICE/27089@localhost:1521/XEPDB1;
Connected.

SQL> ALTER PLUGGABLE DATABASE XEPDB1 OPEN;
ALTER PLUGGABLE DATABASE XEPDB1 OPEN

C:\Users\USER>lsnrctl status
C:\Users\USER>lsnrctl start 

*/


-- 1. CREATE EMPLOYEE TABLE AND INSERT TUPLES
CREATE TABLE EMPLOYEE (
    FNAME VARCHAR2(50),
    MINIT CHAR(1),
    LNAME VARCHAR2(50),
    SSN CHAR(9) PRIMARY KEY NOT NULL,
    BDATE DATE,
    ADDRESS VARCHAR2(250),
    SEX CHAR(1),
    SALARY NUMBER(10, 2),
    SUPER_SSN CHAR(9),
    DNO NUMBER(2)
);

INSERT INTO EMPLOYEE VALUES ('JOHN', 'B', 'SMITH', '123456789', TO_DATE('09/01/1965', 'MM/DD/YYYY'), '731 FONDREN, HOUSTON, TX', 'M', 30000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('FRANKLIN', 'T', 'WONG', '333445555', TO_DATE('08/12/1955', 'MM/DD/YYYY'), '638 VOSS, HOUSTON, TX', 'M', 40000, '888665555', 5);
INSERT INTO EMPLOYEE VALUES ('ALICIA', 'J', 'ZELAYA', '999887777', TO_DATE('01/19/1968', 'MM/DD/YYYY'), '3321 CASTLE, SPRING, TX', 'F', 25000, '987654321', 4);
INSERT INTO EMPLOYEE VALUES ('JENNIFER', 'S', 'WALLACE', '987654321', TO_DATE('06/20/1941', 'MM/DD/YYYY'), '291 BERRY, BELLAIRE, TX', 'F', 43000, '888665555', 4);
INSERT INTO EMPLOYEE VALUES ('RAMESH', 'K', 'NARAYAN', '666884444', TO_DATE('09/15/1962', 'MM/DD/YYYY'), '975 FIRE OAK, HUMBLE, TX', 'M', 38000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('JOYCE', 'A', 'ENGLISH', '453453453', TO_DATE('07/31/1972', 'MM/DD/YYYY'), '5631 RICE, HOUSTON, TX', 'F', 25000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('AHMAD', 'V', 'JABBAR', '987987987', TO_DATE('03/29/1969', 'MM/DD/YYYY'), '980 DALLAS, HOUSTON, TX', 'M', 25000, '987654321', 4);
INSERT INTO EMPLOYEE VALUES ('JAMES', 'E', 'BORG', '888665555', TO_DATE('11/10/1937', 'MM/DD/YYYY'), '450 STONE, HOUSTON, TX', 'M', 55000, NULL, 1);

-- 2. CREATE DEPARTMENT TABLE AND INSERT TUPLES
CREATE TABLE DEPARTMENT (
    DNAME VARCHAR2(50),
    DNUMBER NUMBER(2) PRIMARY KEY NOT NULL,
    MGR_SSN CHAR(9),
    MGR_START_DATE DATE
);

INSERT INTO DEPARTMENT VALUES ('RESEARCH', 5, '333445555', TO_DATE('05/22/1988', 'MM/DD/YYYY'));
INSERT INTO DEPARTMENT VALUES ('ADMINISTRATION', 4, '987654321', TO_DATE('01/01/1995', 'MM/DD/YYYY'));
INSERT INTO DEPARTMENT VALUES ('HEADQUARTERS', 1, '888665555', TO_DATE('06/19/1981', 'MM/DD/YYYY'));

-- 3. CREATE DEPT_LOCATIONS TABLE AND INSERT TUPLES
CREATE TABLE DEPT_LOCATIONS (
    DNUMBER NUMBER(2),
    DLOCATION VARCHAR2(50)
);

INSERT INTO DEPT_LOCATIONS VALUES (1, 'HOUSTON');
INSERT INTO DEPT_LOCATIONS VALUES (4, 'STAFFORD');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'BELLAIRE');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'SUGARLAND');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'HOUSTON');

-- 4. CREATE WORKS_ON TABLE AND INSERT TUPLES
CREATE TABLE WORKS_ON (
    ESSN CHAR(9),
    PNO NUMBER(2),
    HOURS NUMBER(5, 1)
);

INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.5);
INSERT INTO WORKS_ON VALUES ('123456789', 2, 7.5);
INSERT INTO WORKS_ON VALUES ('666884444', 3, 40.0);
INSERT INTO WORKS_ON VALUES ('453453453', 1, 20.0);
INSERT INTO WORKS_ON VALUES ('453453453', 2, 20.0);
INSERT INTO WORKS_ON VALUES ('333445555', 2, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 3, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 20, 10.0);
INSERT INTO WORKS_ON VALUES ('999887777', 30, 30.0);
INSERT INTO WORKS_ON VALUES ('999887777', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('987987987', 10, 35.0);
INSERT INTO WORKS_ON VALUES ('987987987', 30, 5.0);
INSERT INTO WORKS_ON VALUES ('987654321', 30, 20.0);
INSERT INTO WORKS_ON VALUES ('987654321', 20, 15.0);
INSERT INTO WORKS_ON VALUES ('888665555', 20, NULL);

-- 5. CREATE PROJECT TABLE AND INSERT TUPLES
CREATE TABLE PROJECT (
    PNAME VARCHAR2(30),
    PNUMBER NUMBER(2) PRIMARY KEY,
    PLOCATION VARCHAR2(50),
    DNUM NUMBER(2)
);

INSERT INTO PROJECT VALUES ('PRODUCTX', 1, 'BELLAIRE', 5);
INSERT INTO PROJECT VALUES ('PRODUCTY', 2, 'SUGARLAND', 5);
INSERT INTO PROJECT VALUES ('PRODUCTZ', 3, 'HOUSTON', 5);
INSERT INTO PROJECT VALUES ('COMPUTERIZATION', 10, 'STAFFORD', 4);
INSERT INTO PROJECT VALUES ('REORGANISATION', 20, 'HOUSTON', 1);
INSERT INTO PROJECT VALUES ('NEWBENEFITS', 30, 'STAFFORD', 4);

-- 6. CREATE DEPENDENT TABLE AND INSERT TUPLES
CREATE TABLE DEPENDENT (
    ESSN CHAR(9) NOT NULL,
    DEPENDENT_NAME VARCHAR2(20) NOT NULL,
    SEX CHAR(1),
    BDATE DATE,
    RELATIONSHIP VARCHAR2(20),
    PRIMARY KEY (ESSN, DEPENDENT_NAME),
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE
    
);

INSERT ALL
    INTO DEPENDENT VALUES ('333445555', 'ALICE', 'F', TO_DATE('04/05/1986', 'MM/DD/YYYY'), 'DAUGHTER')
    INTO DEPENDENT VALUES ('333445555', 'THEODORE', 'M', TO_DATE('10/25/1983', 'MM/DD/YYYY'), 'SON')
    INTO DEPENDENT VALUES ('333445555', 'JOY', 'F', TO_DATE('05/03/1958', 'MM/DD/YYYY'), 'SPOUSE')
    INTO DEPENDENT VALUES ('987654321', 'ABNER', 'M', TO_DATE('02/28/1942', 'MM/DD/YYYY'), 'SPOUSE')
    INTO DEPENDENT VALUES ('123456789', 'MICHAEL', 'M', TO_DATE('01/04/1988', 'MM/DD/YYYY'), 'SON')
    INTO DEPENDENT VALUES ('123456789', 'ALICE', 'F', TO_DATE('12/30/1988', 'MM/DD/YYYY'), 'DAUGHTER')
    INTO DEPENDENT VALUES ('123456789', 'ELIZABETH', 'F', TO_DATE('05/05/1967', 'MM/DD/YYYY'), 'SPOUSE')
SELECT * FROM DUAL;

/* ADDING CONSTRAINTS BY USING ALTER METHOD */

ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_SUPERSSN 
FOREIGN KEY (SUPER_SSN) REFERENCES EMPLOYEE(SSN) ON DELETE SET NULL;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_DNO
FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNUMBER) ON DELETE CASCADE;


ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_MGR_SSN FOREIGN KEY (MGR_SSN) 
REFERENCES EMPLOYEE(SSN) ON DELETE SET NULL;

ALTER TABLE DEPT_LOCATIONS
ADD CONSTRAINT PK_DEPT_LOCATIONS PRIMARY KEY (DNUMBER, DLOCATION);

ALTER TABLE DEPT_LOCATIONS
ADD CONSTRAINT FK_DEPT_LOC FOREIGN KEY (DNUMBER) 
REFERENCES DEPARTMENT(DNUMBER) ON DELETE CASCADE;

ALTER TABLE WORKS_ON
ADD CONSTRAINT PK_WORKS_ON PRIMARY KEY (ESSN, PNO);

ALTER TABLE WORKS_ON
ADD CONSTRAINT FK_WORKS_ON_ESSN FOREIGN KEY (ESSN) 
REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE;

ALTER TABLE WORKS_ON
ADD CONSTRAINT FK_WORKS_ON_PNO FOREIGN KEY (PNO) 
REFERENCES PROJECT(PNUMBER) ON DELETE CASCADE;

ALTER TABLE PROJECT
ADD CONSTRAINT FK_PROJECT_DNUM FOREIGN KEY (DNUM) 
REFERENCES DEPARTMENT(DNUMBER) ON DELETE CASCADE;

ALTER TABLE DEPENDENT
ADD CONSTRAINT PK_DEPENDENT PRIMARY KEY (ESSN, DEPENDENT_NAME);

ALTER TABLE DEPENDENT
ADD CONSTRAINT FK_DEPENDENT FOREIGN KEY (ESSN) 
REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE;



