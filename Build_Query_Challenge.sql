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
   ,PRIMARY KEY (EventMonth, EventDay, EventFee)
   ,FOREIGN KEY (TourName) REFERENCES TOUR  
)

CREATE TABLE BOOKING (
    ClientID    INT
   ,TourName    NVARCHAR (100)
   ,EventMonth  NVARCHAR (3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
   ,EventDay    INT CHECK (EventDay >=1 and EventDay <= 31)
   ,EventYear   INT
   ,EventFee    MONEY NOT NULL CHECK (EventFee > 0)
   ,Payment     MONEY CHECK (Payment > 0)
   ,DateBooked  DATE NOT NULL
   ,PRIMARY KEY (ClientID, TourName, EventMonth, EventDay, EventFee)
   ,FOREIGN KEY (ClientID) REFERENCES CLIENT
   ,FOREIGN KEY (TourName) REFERENCES TOUR
   ,FOREIGN KEY (EventMonth, EventDay, EventFee) REFERENCES EVENT
)


DROP TABLE TOUR
DROP TABLE EVENT
DROP TABLE CLIENT
DROP TABLE BOOKING
