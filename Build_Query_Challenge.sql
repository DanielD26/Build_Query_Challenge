--Daniel Diaz 103547416

--Task 1
--TOUR (TourName, Description)
--Primary Key (TourName)
--EVENT (TourName, EventYear, EventMonth, EventDay, Fee)
--Primary Key (EventYear, EventMonth, EventDay)
--Foreign Key (TourName) References TOUR
--BOOKING (ClientID, EventYear, EventMonth, EventDay, DateBooked, Payment)
--Foreign Key (ClientID, EventYear, EventMonth, EventDay) References EVENT, CLIENT
--CLIENT (ClientID, Surname, GivenName, Gender)
--Primary Key (ClientID)

--Task 2
CREATE DATABASE AT1
USE AT1

CREATE TABLE TOUR (
   TourName    NVARCHAR (100) PRIMARY KEY
  ,Description NVARCHAR (500) 
)

CREATE TABLE CLIENT (
    ClientID    INT
   ,Surname     NVARCHAR (100) NOT NULL
   ,GivenName   NVARCHAR (100) NOT NULL
   ,Gender      NVARCHAR (1) CHECK (Gender IN ('M', 'F', 'I'))
    PRIMARY KEY (ClientID)
)

CREATE TABLE EVENT (
    TourName    NVARCHAR (100)
   ,EventMonth  NVARCHAR (3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
   ,EventDay    INT CHECK (EventDay >=1 and EventDay <= 31)
   ,EventYear   INT
   ,EventFee    MONEY NOT NULL CHECK (EventFee > 0)
   ,PRIMARY KEY (EventMonth, EventDay, EventYear, TourName)
   ,FOREIGN KEY (TourName) REFERENCES TOUR  
)

CREATE TABLE BOOKING (
    ClientID    INT
   ,TourName    NVARCHAR (100)
   ,EventMonth  NVARCHAR (3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
   ,EventDay    INT CHECK (EventDay >=1 and EventDay <= 31)
   ,EventYear   INT
   ,Payment     MONEY CHECK (Payment > 0)
   ,DateBooked  DATE NOT NULL
   ,PRIMARY KEY (ClientID, TourName, EventMonth, EventDay, EventYear)
   ,FOREIGN KEY (ClientID) REFERENCES CLIENT
   ,FOREIGN KEY (TourName) REFERENCES TOUR
   ,FOREIGN KEY (EventMonth, EventDay, EventYear, TourName) REFERENCES EVENT
)

SELECT * FROM INFORMATION_SCHEMA.TABLES
--Task 3
INSERT INTO TOUR (TourName, Description) VALUES ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region'),
('South', 'Tour of wineries and outlets of Mornington Penisula'),
('West', 'Tour of wineries and outlets of the Geelong and Otways Region');

INSERT INTO CLIENT (ClientID, Surname, GivenName, Gender) VALUES (1, 'Price', 'Taylor', 'M'),
(2, 'Gamble', 'Ellyse', 'F'),
(3, 'Tan', 'Tilly', 'F'),
(103547416, 'Diaz', 'Daniel', 'M');

INSERT INTO EVENT (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('North', 'Jan', 9, 2016, 200),
('North', 'Feb', 13, 2016, 225),
('South', 'Jan', 9, 2016, 200),
('South', 'Jan', 16, 2016, 200),
('West', 'Jan', 29, 2016, 225);

INSERT INTO BOOKING (ClientID, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, 'North', 'Jan', 9, 2016, 200,' 2015-12-10'),
(2, 'North', 'Jan', 9, 2016, 200, '2015-12-10'),
(1, 'North', 'Feb', 13, 2016, 225, '2016-8-1'),
(2, 'North', 'Feb', 13, 2016, 125, '2016-1-14'),
(3, 'North', 'Feb', 13, 2016, 225, '2016-3-2'),
(1, 'South', 'Jan', 9, 2016, 200, '2015-12-10'),
(2, 'South', 'Jan', 16, 2016, 200, '2015-10-18'),
(3, 'South', 'Jan', 16, 2016, 225, '2016-1-9'),
(2, 'West', 'Jan', 29, 2016, 225, '2015-12-17'),
(3, 'West', 'Jan', 29, 2016, 200, '2015-12-18');

SELECT * FROM CLIENT

--Task 4

--Query 1
SELECT C.ClientID, C.GivenName, C.Surname, B.TourName, T.DESCRIPTION, E.EventYear, E.EventMonth, E.EventDay, E.EventFee, B.DateBooked, B.Payment 
FROM BOOKING B
INNER JOIN CLIENT C ON 
C.CLIENTID = B.ClientID
INNER JOIN EVENT E ON
E.EventDay = B.EventDay
INNER JOIN TOUR T ON 
T.TourName = B.TourName

--Query 2
SELECT EventMonth, TourName COUNT (TourName)
FROM BOOKING B
GROUP BY TourName;

SELECT * FROM TOUR
SELECT * FROM CLIENT
SELECT * FROM EVENT
SELECT * FROM BOOKING
DROP TABLE TOUR
DROP TABLE EVENT
DROP TABLE CLIENT
DROP TABLE BOOKING
