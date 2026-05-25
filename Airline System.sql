create database Airline;
use Airline;

create table Aircraft(
number int primary key identity(1,1) not null,
model varchar(50) not null,
manfacturer varchar(50)not null,
seatCapacity int not null check (seatCapacity>0),
yearManfacutur date,  
);

create table Airport(
IATA int primary key not null identity(1,1),
name varchar(5) not null,
city varchar(50) not null,
country varchar(50) not null
);

create table Flight(
flightNumber int primary key not null identity(1,1),
departureDate date not null,
arrivalDate date not null,
status varchar(50) not null check (status ='Scheduled' or status ='Delayed' 
or status ='Cancelled'or status ='Completed') default 'Scheduled',
airportIATA int,
aircraftNumber int, 
check (arrivalDate > departureDate),
foreign key (airportIATA) references Airport(IATA),
foreign key (aircraftNumber) references Aircraft(number),

);

create table crewMember(
license int primary key identity(1,1) not null,
fullName varchar(50)not null,
role varchar(50) not null check (role = 'Pilot' or role = 'Co-Pilot'
or role = 'Flight Attendant' or role = 'Engineer')
);

create table flightCrew(
flightNUM int unique not null,
crewLicense int unique not null,
primary key(flightNUM,crewLicense),
foreign key (flightNUM) references Flight(flightNumber),
foreign key (crewLicense) references crewMember(license)
);

create table Passenger(
nationalId int primary key not null,
fullName varchar(50) not null,
email varchar(50) unique not null,
nationality varchar(50) not null,
DoB date,
);

create table PassengerPhones(
nationalID int not null,
phone int not null,
primary key (nationalID,phone),
foreign key (nationalID) references Passenger (nationalId)
);

create table Booking(
seatNumber int not null identity(1,1),
class varchar(50) not null check (class = 'Economy' or class = 'Business'
or class = 'First'),
price int not null check(price>0),
bookingDate date not null default getdate(),
passengerNumber int not null,
flightID int not null,
primary key (seatNumber,flightID),
foreign key (passengerNumber) references Passenger(nationalId),
foreign key (flightID) references Flight(flightNumber)

);


INSERT INTO Aircraft (model, manfacturer, seatCapacity, yearManfacutur) VALUES
('A320neo', 'Airbus', 180, '2020-03-15'),
('737 MAX 8', 'Boeing', 172, '2019-11-22'),
('E195-E2', 'Embraer', 132, '2021-05-10'),
('CRJ-900', 'Bombardier', 90, '2017-08-14'),
('A350-900', 'Airbus', 325, '2022-01-30');

INSERT INTO Airport (name, city, country) VALUES
('MUO', 'Muscat', 'OMAN'),
('LHR', 'London', 'United Kingdom'),
('HND', 'Tokyo', 'Japan'),
('DXB', 'Dubai', 'United Arab Emirates'),
('CDG', 'Paris', 'France');

INSERT INTO Flight (departureDate, arrivalDate, status, airportIATA, aircraftNumber) VALUES
('2026-06-01', '2026-06-02', 'Scheduled', 1, 1),
('2026-06-02', '2026-06-03', 'Scheduled', 2, 2), 
('2026-05-20', '2026-05-21', 'Completed', 3, 3), 
('2026-05-22', '2026-05-23', 'Completed', 4, 4), 
('2026-06-05', '2026-06-06', 'Delayed',   5, 5), 
('2026-06-06', '2026-06-07', 'Delayed',   1, 2), 
('2026-06-10', '2026-06-11', 'Cancelled', 2, 1),
('2026-06-12', '2026-06-13', 'Cancelled', 3, 5);

INSERT INTO Passenger (nationalId, fullName, email, nationality, DoB) VALUES
(1001, 'Ali Al-Farsi', 'ali123@gmail.com', 'Omani', '1985-04-12'),
(1002, 'Emma Watson', 'emma.w@mail.uk', 'British', '1990-09-20'),
(1003, 'Yuki Tanaka', 'tanaka.y@mail.jp', 'Japanese', '1993-11-05'),
(1004, 'Ahmed Al-Mansoori', 'ahmed.m@mail.ae', 'Emirati', '1988-01-15'),
(1005, 'Marie Dubois', 'marie.d@mail.fr', 'French', '1995-07-24'),
(1006, 'Carlos Santana', 'carlos.s@mail.mx', 'Mexican', '1982-03-30'),
(1007, 'Rahul Sharma', 'rahul.s@mail.in', 'Indian', '1989-12-12'),
(1008, 'Li Wei', 'li.wei@mail.cn', 'Chinese', '1991-06-18');

INSERT INTO PassengerPhones (nationalID, phone) VALUES
(1001, 15550123),
(1002, 44449876),
(1003, 81815555),
(1004, 97150111),
(1005, 33142222),
(1006, 52553333),
(1007, 91984444),
(1008, 86135555);

INSERT INTO Booking (class, price, bookingDate, passengerNumber, flightID) VALUES
('First',    2500, '2026-05-01', 1001, 1),
('Business', 1200, '2026-05-02', 1002, 1),
('Economy',   450, '2026-05-03', 1003, 2),
('First',    3000, '2026-04-15', 1004, 3),
('Business', 1500, '2026-05-10', 1005, 3),
('Economy',   350, '2026-05-12', 1006, 4),
('Economy',   400, '2026-05-14', 1007, 5),
('Business', 1100, '2026-05-15', 1008, 6),
('First',    2800, '2026-05-16', 1001, 7),
('Economy',   500, '2026-05-17', 1002, 8);

INSERT INTO crewMember (fullName, role) VALUES
('Capt. James T. Kirk', 'Pilot'),
('First Officer Spock', 'Co-Pilot'),
('Dr. Leonard McCoy',   'Engineer'),
('Montgomery Scott',    'Engineer'),
('Nyota Uhura',         'Flight Attendant'),
('Hikaru Sulu',         'Flight Attendant');

INSERT INTO flightCrew (flightNUM, crewLicense) VALUES
(1, 1), (1, 5),
(2, 1), (2, 5),
(3, 1), (3, 5), (3, 2), 
(4, 1), (4, 5), (4, 3), 
(5, 1), (5, 5),
(6, 1), (6, 5),
(7, 1), (7, 5),
(8, 1), (8, 5);

DROP TABLE flightCrew;

CREATE TABLE flightCrew (
    flightNUM int not null,        
    crewLicense int not null,     
    PRIMARY KEY (flightNUM, crewLicense), 
    FOREIGN KEY (flightNUM) REFERENCES Flight(flightNumber),
    FOREIGN KEY (crewLicense) REFERENCES crewMember(license)
);


INSERT INTO flightCrew (flightNUM, crewLicense) VALUES
(1, 1), (1, 5),
(2, 1), (2, 5),
(3, 1), (3, 5), (3, 2), 
(4, 1), (4, 5), (4, 3), 
(5, 1), (5, 5),
(6, 1), (6, 5),
(7, 1), (7, 5),
(8, 1), (8, 5);

update Flight 
set status = 'Completed'
where flightNumber = 1;

update Flight 
set status = 'Cancelled'
where flightNumber = 5;

update Booking
set price = price * 0.1
where class = 'Economy';

update PassengerPhones
set phone = 15559999
where nationalID = 1001;

update crewMember
set role = 'Pilot'
where license = 2;

select * from Flight
where flightNumber = 7 AND status = 'Cancelled';

delete from Flight
where flightNumber = 7;

select b.seatNumber , b.flightID, b.passengerNumber, b.class, f.status
from Booking b 
join Flight f on b.flightID = f.flightNumber
where b.flightID = 8 AND f.status = 'Cancelled';

delete from Booking
where flightID = 8 AND passengerNumber = 1002;

select p.nationalId, p.fullName, b.seatNumber, b.flightID
from Passenger p
join Booking b on p.nationalId = b.passengerNumber
where p.nationalId = 1001;

delete from Passenger
where nationalId =1001;
--This shows error because Booking table has foreign key passengerNumber which is the primary key in the Passenger table.


--Basic Level

select flightNumber , status
from Flight 
order by departureDate;

select * from Passenger
order by fullName;

select number, seatCapacity
from Aircraft
order by seatCapacity desc;

select distinct class 
from Booking;

select * from Flight
where status = 'Delayed' or status = 'Cancelled';

select * from Passenger
where nationality = 'Omani';

select * from Airport
order by country;


--Medium Level

select f.flightNumber, a.name
from Flight f
join Airport a on f.airportIATA = a.IATA;

select b.bookingDate, p.fullName , f.flightNumber
from Passenger p, Booking b
join Flight f on f.flightNumber = b.flightID;

select c.fullName, c.role
from crewMember c 
join flightCrew f on c.license = f.crewLicense
where flightNUM = 1;

select f.status , a.model 
from Flight f 
join Aircraft a on a.number = f.aircraftNumber
where status = 'Completed';

select p.fullName , count(b.flightId) as totalBookings
from Passenger p 
left join Booking b on p.nationalId = b.passengerNumber
group by p.nationalId , p.fullName
order by totalBookings desc;

select class, sum(price) as totalRevnue
from Booking
group by class;

select a.number, count(f.flightNumber) as totalFlightsAssigned
from Aircraft a 
left join Flight f on a.number = f.aircraftNumber
group by a.number;


select f.flightNumber, count(f.flightNumber) as totalBooking
from Flight f 
join Booking b on f.flightNumber = b.flightID
group by f.flightNumber;

select p.fullName, b.flightID as [Flight Number], a.name AS [Airport Code], b.class, b.price
FROM Booking b
INNER JOIN Passenger p ON b.passengerNumber = p.nationalId
INNER JOIN Flight f    ON b.flightID = f.flightNumber
INNER JOIN Airport a   ON f.airportIATA = a.IATA;


--Advanced Level

use Airline

select f.flightNumber as [Flight Number],
port.name as [Airport],
air.model as [Aircraft Model],
COUNT(b.flightID) as [Total Passengers]
from Flight f
inner join Aircraft air on f.aircraftNumber = air.number
inner join Airport port on  f.airportIATA = port.IATA
left join Booking b on f.flightNumber = b.flightID
group by f.flightNumber, port.name, air.model;


select flightId as [Flight Number],
sum(price) as [Total Revenue]
from Booking
group by flightId
having sum(price) >500
order by [Total Revenue] desc;


select c.fullName, count(f.flightNUM) as [Total Flight]
from crewMember c 
join flightCrew f on c.license = f.crewLicense
group by c.fullName
having count(f.flightNUM) >1;


select flightID , AVG (price) as [average booking price]
from Booking 
group by flightID 
having AVG (price) > (

SELECT AVG(price)
    FROM Booking
    
    ) order by [average booking price] desc;


select f.flightNumber, a.name as [Airport Name], count(b.seatNumber) as [Total Booking]
from Flight f
join Airport a on f.airportIATA = a.IATA
join Booking b on  f.flightNumber = b.flightID
group by f.flightNumber, a.name
having count(b.seatNumber) = (

select max (bookingCount)
from(
select count(*) as bookingCount
from Booking 
group by flightID
) as BookingTotals

);


select class, sum(price) as [Total Revenue],
count(*) as [Number of Bookings],
AVG (price) as [Average price],
max (price) as [Maximum price],
min(price) as [Minimum price]
from Booking
group by class;



select p.fullName as [Passenger Name], 
b.flightID as [flight number], b.bookingDate
from Booking b 
join Passenger p on b.passengerNumber = p.nationalId
join Flight f on b.flightID = f.flightNumber
where  f.status =  'Cancelled';


select f.flightNumber, count(fc.crewLicense) as [Crew Number], f.departureDate
from Flight f 
join flightCrew fc on f.flightNumber = fc.flightNUM
join crewMember cm on fc.crewLicense = cm.license 
where cm.role = 'Pilot' or cm.role = 'Flight Attendant'
group by  f.flightNumber, f.departureDate
having COUNT(DISTINCT cm.role) = 2;


select f.flightNumber, a.city as [Airport city],
ac.model as [Aircraft model], ac.manfacturer as [Aircraft Manufacturer],
count (DISTINCT b.passengerNumber) as [Total Passengers],
count(DISTINCT fc.crewLicense) as [Total Crew Assigned],
sum(b.price) as [Total Revenue]
from Flight f
join Airport a on f.airportIATA = a.IATA
join Aircraft ac on f.aircraftNumber = ac.number
left join Booking b on f.flightNumber = b.flightID
left join flightCrew fc on f.flightNumber = fc.flightNUM
group by f.flightNumber, a.city, ac.model, ac.manfacturer
order by [Total Revenue] desc;
