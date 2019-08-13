/* Hooman Tayefeh Jafari 102703013*/
/*

Tour(TourName, Description)
PK TourName

Client(ClientId,Surname,GivenName,Gender)
PK ClientId

Event(TourName,EventMonth,EventDay,EventYear,EventFee)
PK (TourName,EventMonth,EventDay,EventYear)
FK (TourName) Referencese Tour

Booking(ClientId,TourName,EventMonth, EventDay,EventYear,Payment,DateBooked)
PK(ClientId,TourName,EventMonth, EventDay,EventYear)
FK (ClientId) Referencese Client
FK (TourName,EventMonth, EventDay,EventYear) References Event

*/

DROP TABLE IF exists Booking;
DROP TABLE IF exists Event;
DROP TABLE IF exists Client;
DROP TABLE IF exists Tour;

CREATE TABLE Tour(
    TourName VARCHAR(100),
    Description VARCHAR(500),
    PRIMARY KEY (TourName));

 CREATE TABLE Client(
     ClientId int,
     Surname VARCHAR(100) NOT NULL,
     GivenName VARCHAR(100) NOT NULL,
     Gender VARCHAR(1),
     PRIMARY KEY(ClientId),
     CHECK(Gender IN('M','F','I')));

     CREATE TABLE Event(
         TourName VARCHAR(100),
         EventMonth VARCHAR(3),
         EventDay int,
         EventYear int,
         EventFee MONEY,
PRIMARY KEY (TourName,EventMonth,EventDay,EventYear),
FOREIGN KEY(TourName) REFERENCES Tour,
CHECK (EventMonth IN('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
CHECK ((EventDay>=1)and(EventDay<=31)),
CHECK (len(EventYear) = 4) 
);

CREATE TABLE Booking(
    ClientId int,
    TourName VARCHAR(100),
    EventMonth VARCHAR(3),
     EventDay int,
     EventYear int,
     Payment MONEY,
     DateBooked DATE NOT NULL,
     PRIMARY KEY(ClientId,TourName,EventMonth, EventDay,EventYear),
FOREIGN KEY(ClientId) REFERENCES Client,
FOREIGN KEY(TourName,EventMonth, EventDay,EventYear) References Event,
CHECK (EventMonth IN('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
CHECK ((EventDay>=1)and(EventDay<=31)),
CHECK (len(EventYear) = 4));




DELETE Booking;
DELETE Event;
DELETE Client;
DELETE Tour;

INSERT INTO Tour(TourName, Description)
VALUES    ('North','Tour of wineries and outlets of the Bedigo and Castlemaine region'),
('South','Tour Of Wineries'),
('West','Tour of winereies');

INSERT INTO Client(ClientId,Surname,GivenName,Gender)
values (1,'Price','Taylor','M'),
(2, 'Tailor','Peter','M'),
(3,'Maryami','Maryam','F'),
(102703013,'Tayefeh Jafari','Hooman','M');

INSERT INTO Event(TourName,EventMonth,EventDay,EventYear,EventFee)
VALUES('North','Jan',9,2016,200),
('North','Feb',13,2016,225),
('South','Jan',9,2016,200),
('South','Jan',16,2016,200),
('West','Jan',29,2016,225);

INSERT INTO Booking(ClientId,TourName,EventMonth, EventDay,EventYear,Payment,DateBooked)
VALUES(1,'North','Jan',9,2016,200,'2015/12/10'),
(2,'North','Jan',9,2016,200,'2015/12/16'),
(1,'North','Feb',13,2016,200,'2015/01/08'),
(2,'North','Feb',13,2016,125,'2015/02/10'),
(3,'North','Feb',13,2016,225,'2016/02/03'),
(1,'South','Jan',16,2016,200,'2015/10/12'),
(2,'West','Jan',29,2016,225,'2015/12/17');



SELECT c.GivenName,c.Surname,t.TourName,t.[Description],e.EventYear,e.EventMonth,e.EventDay,b.Payment
From Booking b 
INNER JOIN Event e 
ON e.TourName=b.TourName AND e.EventMonth=b.EventMonth AND  e.EventDay=b.EventDay AND e.EventYear=b.EventYear
INNER JOIN Client c 
ON C.ClientId=B.ClientId
INNER JOIN Tour t 
ON t.TourName=e.TourName


SELECT e.EventMonth, t.TourName, COUNT(c.ClientId) as "Num Booking"
From Booking b 
INNER JOIN Event e 
ON e.TourName=b.TourName AND e.EventMonth=b.EventMonth AND  e.EventDay=b.EventDay AND e.EventYear=b.EventYear
INNER JOIN Client c 
ON C.ClientId=B.ClientId
INNER JOIN Tour t 
ON t.TourName=e.TourName
GROUP BY e.EventMonth, t.TourName

SELECT *
From Booking  
WHERE Payment>(SELECT AVG(Payment) From Booking);

CREATE  VIEW  Query1 as
SELECT c.GivenName,c.Surname,t.TourName,t.[Description],e.EventYear,e.EventMonth,e.EventDay,b.Payment
From Booking b 
INNER JOIN Event e 
ON e.TourName=b.TourName AND e.EventMonth=b.EventMonth AND  e.EventDay=b.EventDay AND e.EventYear=b.EventYear
INNER JOIN Client c 
ON C.ClientId=B.ClientId
INNER JOIN Tour t 
ON t.TourName=e.TourName


/* Those following query will show rows Count and rows details for Task4 Query1 which are correct.*/

SELECT count(GivenName) as "Total Booking" From (SELECT c.GivenName,c.Surname,t.TourName,t.[Description],e.EventYear,e.EventMonth,e.EventDay,b.Payment
From Booking b 
INNER JOIN Event e 
ON e.TourName=b.TourName AND e.EventMonth=b.EventMonth AND  e.EventDay=b.EventDay AND e.EventYear=b.EventYear
INNER JOIN Client c 
ON C.ClientId=B.ClientId
INNER JOIN Tour t 
ON t.TourName=e.TourName) AS test


SELECT top 1* FROM(SELECT c.GivenName,c.Surname,t.TourName,t.[Description],e.EventYear,e.EventMonth,e.EventDay,b.Payment
From Booking b 
INNER JOIN Event e 
ON e.TourName=b.TourName AND e.EventMonth=b.EventMonth AND  e.EventDay=b.EventDay AND e.EventYear=b.EventYear
INNER JOIN Client c 
ON C.ClientId=B.ClientId
INNER JOIN Tour t 
ON t.TourName=e.TourName)as test

/* Those following query will show rows Count and rows details for Task4 Query2 which are correct.*/

SELECT sum ([Num Booking]) as "Total Booking" FROM (SELECT e.EventMonth, t.TourName, COUNT(c.ClientId) as "Num Booking"
From Booking b 
INNER JOIN Event e 
ON e.TourName=b.TourName AND e.EventMonth=b.EventMonth AND  e.EventDay=b.EventDay AND e.EventYear=b.EventYear
INNER JOIN Client c 
ON C.ClientId=B.ClientId
INNER JOIN Tour t 
ON t.TourName=e.TourName
GROUP BY e.EventMonth, t.TourName) as test

SELECT top 1* FROM(SELECT e.EventMonth, t.TourName, COUNT(c.ClientId) as "Num Booking"
From Booking b 
INNER JOIN Event e 
ON e.TourName=b.TourName AND e.EventMonth=b.EventMonth AND  e.EventDay=b.EventDay AND e.EventYear=b.EventYear
INNER JOIN Client c 
ON C.ClientId=B.ClientId
INNER JOIN Tour t 
ON t.TourName=e.TourName
GROUP BY e.EventMonth, t.TourName) as test

/* Tootl Num Booking for query 3(Ave>) + Tootal num Booking for (ave<=)=7 */
SELECT count (ClientId) as "query3 booking Num" FROM (SELECT *
From Booking  
WHERE Payment>(SELECT AVG(Payment) From Booking)
)as test

SELECT count (ClientId) as "query3 booking Num" FROM (SELECT *
From Booking  
WHERE Payment<=(SELECT AVG(Payment) From Booking)
)as test