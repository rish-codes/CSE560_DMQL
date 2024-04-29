create table circuits(
	circuitId int primary key,
	circuitRef varchar(25),
	name varchar(100),
	location varchar(50),
	country varchar(30),
	lat float,
	lng float,
	alt varchar(10),
	url varchar(200)
);

create table races(
	raceId int primary key,
	year int, 
	round int,
	circuitId int,
	name varchar(100),
	date varchar(15),
	time varchar(15), 
	url varchar(200),
	fp1_date varchar(15),
	fp1_time varchar(15),	
	fp2_date varchar(15),	
	fp2_time varchar(15),
	fp3_date varchar(15),
	fp3_time varchar(15),
	quali_date varchar(15),
	quali_time varchar(15),
	sprint_date varchar(15),
	sprint_time varchar(15),
	CONSTRAINT fk_circuit
      FOREIGN KEY(circuitId) 
        REFERENCES circuits(circuitId) 
);

create table drivers(
	driverId int primary key,
	driverRef varchar(20),
	number varchar(5),
	code varchar(3),
	forename varchar(20),
	surname varchar(30),
	dob  date,
	nationality varchar(20),
	url varchar(100)
);

create table constructors(
	constructorId int primary key,
	constructorRef varchar(20),	
	name varchar(50),
	nationality varchar(20),
	url varchar(100)
);

create table constructor_results(
	constructorResultsId int primary key,
	raceId int,
	constructorId int,
	points float,
	status varchar(2),
	CONSTRAINT fk_race
      FOREIGN KEY(raceId) 
        REFERENCES races(raceId),
	CONSTRAINT fk_constructors
      FOREIGN KEY(constructorId) 
        REFERENCES constructors(constructorId)
);

create table constructor_standings(
	constructorStandingsId int primary key,
	raceId int,
	constructorId int,	
	points float,
	position int,
	positionText varchar(5),
	wins int,
	CONSTRAINT fk_race
      FOREIGN KEY(raceId) 
        REFERENCES races(raceId),
	CONSTRAINT fk_constructors
      FOREIGN KEY(constructorId) 
        REFERENCES constructors(constructorId)
);

create table status(
	statusId int primary key,
	status varchar(20)
);


create table results(
	resultId int primary key,
	raceId int,
	driverId int,
	constructorId int,
	number varchar(10),
	grid varchar(10),
	position varchar(10),
	positionText text,
	positionOrder varchar(10),
	points float,
	laps varchar(10),
	time varchar(15),
	milliseconds varchar(10),
	fastestLap varchar(10),
	rank varchar(10),
	fastestLapTime varchar(15),
	fastestLapSpeed varchar(10),
	statusId int,
	CONSTRAINT fk_race
      FOREIGN KEY(raceId) 
        REFERENCES races(raceId),
	CONSTRAINT fk_drivers
      FOREIGN KEY(driverId) 
        REFERENCES drivers(driverId),
	CONSTRAINT fk_constructors
      FOREIGN KEY(constructorId) 
        REFERENCES constructors(constructorId),
	CONSTRAINT fk_status
      FOREIGN KEY(statusId) 
        REFERENCES status(statusId)
);

create table driver_standings(
	driverStandingsId int primary key,
	raceId	int,
	driverId int,
	points float,
	position varchar(10),
	positionText varchar(5),
	wins int,
	CONSTRAINT fk_race
      FOREIGN KEY(raceId) 
        REFERENCES races(raceId),
	CONSTRAINT fk_drivers
      FOREIGN KEY(driverId) 
        REFERENCES drivers(driverId)
);

create table qualifying(
	qualifyId int primary key,
	raceId int,
	driverId int,
	constructorId int,
	number int,
	position int,
	q1 varchar(10),
	q2 varchar(10),
	q3 varchar(10),
	CONSTRAINT fk_race
      FOREIGN KEY(raceId) 
        REFERENCES races(raceId),
	CONSTRAINT fk_drivers
      FOREIGN KEY(driverId) 
        REFERENCES drivers(driverId),
	CONSTRAINT fk_constructors
      FOREIGN KEY(constructorId) 
        REFERENCES constructors(constructorId)
);