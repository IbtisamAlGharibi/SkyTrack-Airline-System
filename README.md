Brief Description

SkyTrack Airline System is a database system made to manage airline operations.
The system stores information about:
Flights
Passengers
Aircraft
Airports
Crew members
Bookings
It helps organize flight schedules, passenger reservations, crew assignments, and revenue information.

Main Entities
Aircraft → stores aircraft details
Airport → stores airport information
Flight → stores flight schedules and status
Passenger → stores passenger data
Booking → stores passenger bookings
CrewMember → stores crew information
FlightCrew → connects crew members with flights
PassengerPhones → stores passenger phone numbers

Key Relationships
One aircraft can be assigned to many flights.
One airport can have many flights.
One passenger can book many flights.
One flight can have many passengers.
One flight can have many crew members.
One crew member can work on many flights.


Design Decisions
I used a separate table (flightCrew) because flights and crew members have a many-to-many relationship.
I used PassengerPhones as a separate table because one passenger can have more than one phone number.


Foreign Keys Used
Flight.airportIATA → references Airport
Flight.aircraftNumber → references Aircraft
Booking.passengerNumber → references Passenger
Booking.flightID → references Flight
flightCrew.flightNUM → references Flight
flightCrew.crewLicense → references crewMember

Why I Used Them
I used foreign keys to connect related tables and keep the data correct.
For example:
A booking cannot exist without a passenger and a flight.
A flight cannot use an aircraft that does not exist.

Difference Between WHERE and HAVING
Acting the same role but we use having when we have an aggregation words like(count, sum, max).


Most Useful Query
The most useful query and challinging in the same time I wrote was the flight summary query.
It showed:
Flight number
Aircraft information
Total passengers
Total crew
Total revenue

I think it is useful because it gives a complete overview of each flight in one query.
It can help the airline track performance and revenue easily.
