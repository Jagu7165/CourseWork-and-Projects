-- GameOfficialScheduler create script
-- CS3550
-- <Jorge Aguinaga>

use master;
go
--Drop the Officiating Database
if exists ( select * from sys.sysdatabases where name = N'GameOfficialScheduler')
drop database GameOfficialScheduler;
go
--Create the Officiating Database
create database [GameOfficialScheduler]
on primary
(name = N'GameOfficialScheduler',
filename = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GameOfficialScheduler.mdf',
SIZE = 5MB,
FILEGROWTH = 1MB)
LOG ON
(name = N'GameOfficialScheduler_log',
filename = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GameOfficialSchedulerLog.ldf',
SIZE =2MB,
FILEGROWTH = 1MB);

go
-- Use the Officiating Database

use GameOfficialScheduler;

go
-- Drop tables if they exists
IF Exists(
Select * From sys.tables where Name = N'gosSecurityAnswer'
)
drop table gosSecurityAnswer;
IF Exists(
Select * From sys.tables where Name = N'gosSecurityQuestion'
)
drop table gosSecurityQuestion;
IF Exists(
Select * From sys.tables where Name = N'gosArbiter'
)
drop table gosArbiter;
IF Exists(
Select * From sys.tables where Name = N'gosGameOfficial'
)
drop table gosGameOfficial;
IF Exists(
Select * From sys.tables where Name = N'gosGame'
)
drop table gosGame;
IF Exists(
Select * From sys.tables where Name = N'gosOfficialQualification'
)
drop table gosOfficialQualification;
IF Exists(
Select * From sys.tables where Name = N'gosOfficial'
)
drop table gosOfficial;
IF Exists(
Select * From sys.tables where Name = N'gosOfficiatingPosition'
)
drop table gosOfficiatingPosition;
IF Exists(
Select * From sys.tables where Name = N'gosSportLevel'
)
drop table gosSportLevel;
IF Exists(
Select * From sys.tables where Name = N'gosSite'
)
drop table gosSite;
IF Exists(
Select * From sys.tables where Name = N'gosSchool'
)
drop table gosSchool;
IF Exists(
Select * From sys.tables where Name = N'gosUser'
)
drop table gosUser;

go
----------------------------------------------------------------

--Create Tables (Create parent tables before associative tables

CREATE TABLE gosSecurityQuestion (
    odSecurityQuestion_id INT not null Identity(1,1) ,
    SecurityQuestion Nvarchar(255) not null unique
);

CREATE TABLE gosUser(
    odUser_id INT not null IDENTITY(1,1) ,
    emailAddress Nvarchar(255) not null,
	FirstName Nvarchar(25) not null,
	LastName Nvarchar(25) not null,
	StreetAddress Nvarchar(255) not null,
	City Nvarchar(50) not null,
	[State] Nvarchar(2) not null,
	Zip Nvarchar(9) not null,
	CellPhoneNumber Nvarchar(10) not null,
	HomePhoneNumber Nvarchar(10),
	WorkPhoneNumber Nvarchar(10)
);


CREATE TABLE gosSchool(
	odSchool_id INT not null IDENTITY(1,1) ,
	SchoolName Nvarchar(255) not null,
	PhoneNumber Nvarchar(10) not null,
	StreetAdress Nvarchar(255) not null,
	City Nvarchar(20) not null,
	[State] Nvarchar(2) not null,
	Zip Nvarchar(9) not null,
	AthleticDirector Nvarchar(20)
);


CREATE TABLE gosSite(
    odSite_id INT not null IDENTITY(1,1) ,
    SiteName Nvarchar(255) not null,
	PhoneNumber Nvarchar(10) not null,
	StreetAdress Nvarchar(255) not null,
	City Nvarchar(25) not null,
	[State] Nvarchar(2) not null,
	Zip Nvarchar(9) not null,
);


CREATE TABLE gosSportLevel(
    odSportLevel_id INT not null Identity(1,1) ,
    Sport Nvarchar(20) not null,
	[Level] Nvarchar(20) not null,
	PayRate Money not null
);
-- put go at the bottom of every section

CREATE TABLE gosOfficiatingPosition(
    odPositionName_id INT not null Identity(1,1) ,
    PositionName Nvarchar(50) not null
);

Create Table gosOfficial(
	odUser_id INT not null ,
    FeesAccumulated money NOT NULL,
);

Create Table gosSecurityAnswer(
	odUser_id INT not null ,
	odSecurityQuestion_id INT not null ,
	Answer nvarchar (255)
);

Create Table gosArbiter(
	odUser_id INT not null ,
	odSportLevel_id INT not null ,
);

Create Table gosOfficialQualification(
	odUser_id INT not null ,
	odSportLevel_id INT not null ,
	odPositionName_id INT not null ,
);



Create Table gosGame(
	odGame_id INT not null Identity(1,1) ,
	GameDateTime datetime not null ,
	odSite_id INT not null ,
	odSportLevel_id INT not null ,
	HomeTeam INT not null,
	AwayTeam INT not null

);

create table gosGameOfficial(
	odUser_id INT not null,
	odGame_id INT not null,
	odPositionName_id INT not null 
);
go
--create the primary keys for all tables

ALter Table gosUser 
ADD Constraint PK_gosUser
primary Key clustered (odUser_id);

Alter Table gosSecurityQuestion
ADD Constraint PK_gosSecurityQuestion
Primary Key Clustered (odSecurityQuestion_id);

Alter Table gosSecurityAnswer
add constraint PK_gosSecurityAnswer
Primary Key Clustered (odUser_id, odSecurityQuestion_id);

Alter Table gosSchool
add constraint PK_gosSchool
Primary Key Clustered (odSchool_id);

Alter Table gosSite
add constraint PK_gosSite
Primary Key Clustered (odSite_id);

Alter Table gosSportLevel
add constraint PK_gosSportLevel
Primary Key Clustered (odSportLevel_id);

Alter Table gosOfficiatingPosition
add constraint PK_gosOfficiatingPosition
Primary Key Clustered (odPositionName_id);

Alter Table gosOfficial
add constraint PK_gosOfficial
Primary Key Clustered (odUser_id);

Alter Table gosArbiter
add constraint PK_gosArbiter
Primary Key Clustered (odUser_id, odSportLevel_id);

Alter Table gosOfficialQualification
add constraint PK_gosOfficialQualification
Primary Key Clustered (odUser_id, odSportLevel_id, odPositionName_id);

Alter Table gosGame
add constraint PK_Game
Primary Key Clustered (odGame_id);

Alter Table gosGameOfficial
add constraint PK_gosGameOfficial
Primary Key Clustered (odUser_id, odGame_id);
go


--create foreign keys
Alter Table gosSecurityAnswer
add constraint FK_gosSecurityAnswer_odUser_id
foreign key (odUser_id) references gosUser (odUser_id);

Alter Table gosSecurityAnswer
add constraint FK_gosSecurityAsnwer_odSecurityQuestion_id 
foreign key (odSecurityQuestion_id) references gosSecurityQuestion (odSecurityQuestion_id);

Alter Table gosOfficialQualification
add constraint FK_gosOfficialQualification_odUser_id_
foreign key (odUser_id) references gosUser (odUser_id);

Alter Table gosOfficialQualification
add constraint FK_gosOfficialQualification_odSportLevel_id
foreign key (odSportLevel_id) references gosSportLevel (odSportLevel_id);

Alter Table gosOfficialQualification
add constraint FK_gosOfficialQualification_odOfficiatingPosition_id_
foreign key (odPositionName_id) references gosOfficiatingPosition (odPositionName_id);

Alter Table gosGameOfficial
add constraint FK_gosGameOfficial_odUser_id_
foreign key (odUser_id) references gosUser (odUser_id);

Alter Table gosGameOfficial
add constraint FK_gosGameOfficial_odGame_id_
foreign key (odGame_id) references gosGame (odGame_id);
--------------------------------------------------------------
Alter Table gosArbiter
add constraint FK_gosArbiterr_odUser_id_
foreign key (odUser_id) references gosUser (odUser_id);

Alter Table gosArbiter
add constraint FK_gosArbiter_odSportLevel_id_
foreign key (odSportLevel_id) references gosSportLevel (odSportLevel_id);
---------------------------------------------------------------
Alter Table gosGame
add constraint FK_gosGame_homeTeam
foreign key (HomeTeam) references gosSchool (odSchool_id);

Alter Table gosGame
add constraint FK_gosGame_awayTeam
foreign key (AwayTeam) references gosSchool (odSchool_id);

go

---create alternate keys
Alter Table gosUser
Add Constraint AK_gosUser_emailAddress
Unique(emailAddress);

Alter Table gosSecurityQuestion
Add Constraint AK_gosSecurityQuestion_SecurityQuestion
Unique(SecurityQuestion);

Alter Table gosSchool
Add Constraint  AK_gosSchool_SchoolName
Unique(SchoolName);

Alter Table gosSportLevel
Add Constraint AK_SportLevel_Sport_Level
Unique(Sport, [Level]);

Alter Table gosSite
Add Constraint AK_gosSite_SiteName
Unique(SiteName);

Alter Table gosOfficiatingPosition
Add Constraint AK_gpsOfficiatingPosition_PositionName
Unique(PositionName);

Alter Table gosGame
Add Constraint AK_gosGame_GameDateTime
Unique(GameDateTime, odSportLevel_id, odSite_id);
go

-------------Functions

------------------------------------------------------------------------------------------------------------------------------------------------
-----------------Create GetUSerId function
-----------------------------------------------------------------------------------------------------------------------------------------------


IF EXISTS
(Select * from sysobjects where id = OBJECT_ID (N'udf_getUserID')
)
DROP FUNCTION dbo.udf_getUserID;
go
CREATE FUNCTION dbo.udf_getUserID (@emailAddress nvarchar(255))
returns int
as 
begin

declare @odUser_id INT
select @odUser_id = odUser_id
from gosUser
where emailAddress = @emailAddress;

if @odUser_id is null
set @odUser_id = -1;
return @odUser_id;
end 
go

-------------------------------------------------------------------------------------------------------------------------------------------------------
------------------Create GetSecurityQuestionID function
---------------------------------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS
(Select * from sysobjects where id = OBJECT_ID (N'udf_getSecurityQuestionID')
)
DROP FUNCTION dbo.udf_getSecurityQuestionID;
go
CREATE FUNCTION dbo.udf_getSecurityQuestionID (@question nvarchar(255))
returns int
as 
begin

declare @odSecurityQuestion_id INT
select @odSecurityQuestion_id = odSecurityQuestion_id
from gosSecurityQuestion
where SecurityQuestion = @question;

if @odSecurityQuestion_id is null
set @odSecurityQuestion_id = -1;
return @odSecurityQuestion_id;
end 
go


--------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------create getSportLevelID function
---------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS
(Select * from sysobjects where id = OBJECT_ID (N'udf_getSportLevelID')
)
DROP FUNCTION dbo.udf_getSportLevelID;
go
CREATE FUNCTION dbo.udf_getSportLevelID (@sport nvarchar(20), @Level nvarchar(20))
returns int
as 
begin

declare @odSportLevel_id INT
select @odSportLevel_id = odSportLevel_id
from gosSportLevel
where Sport = @Sport and [Level] = @Level;

if @odSportLevel_id is null
set @odSportLevel_id = -1;
return @odSportLevel_id;
end 
go

----------------------------------------------------------------------------------------------------------------------------------------------------
--------------create getSiteID function
------------------------------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS
(Select * from sysobjects where id = OBJECT_ID (N'udf_getSiteID')
)
DROP FUNCTION dbo.udf_getSiteID;
go
CREATE FUNCTION dbo.udf_getSiteID (@SiteName nvarchar(255))
returns int
as 
begin

declare @odSite_id INT
select @odSite_id = odSite_id
from gosSite
where SiteName = @SiteName;

if @odSite_id is null
set @odSite_id = -1;
return @odSite_id;
end 
go


---------------------------------------------------------------------------------------------------------------------------------------------------
--------------------Create getSchoolID function
------------------------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS
(Select * from sysobjects where id = OBJECT_ID (N'udf_getSchoolID')
)
DROP FUNCTION dbo.udf_getSchoolID;
go
CREATE FUNCTION dbo.udf_getSchoolID (@SchoolName nvarchar(255))
returns int
as 
begin

declare @odSchool_id INT
select @odSchool_id = odSchool_id
from gosSchool
where SchoolName = @SchoolName;

if @odSchool_id is null
set @odSchool_id = -1;
return @odSchool_id;
end 
go

-----------------------------------------------------------------------------------------------------------------------------------------------------
------------------create getPositionNameID function
------------------------------------------------------------------------------------------------------------------------------------------------------
 IF EXISTS
(Select * from sysobjects where id = OBJECT_ID (N'udf_getPositionNameID')
)
DROP FUNCTION dbo.udf_getPositionNameID;
go
CREATE FUNCTION dbo.udf_getPositionNameID (@PositionName nvarchar(50))
returns int
as 
begin

declare @odPositionName_id INT
select @odPositionName_id = odPositionName_id
from gosOfficiatingPosition
where PositionName = @PositionName;

if @odPositionName_id is null
set @odPositionName_id = -1;
return @odPositionName_id;
end 
go


----------------------------------------------------------------------------------------------------------------------------------------------------
------------create getGameID function            replace subquery with the function it needs and 
----------------------------------------------------------------------------------------------------------------------------------------------------de
IF EXISTS
(Select * from sysobjects where id = OBJECT_ID (N'udf_getGameID')
)
DROP FUNCTION dbo.udf_getGameID;
go
CREATE FUNCTION dbo.udf_getGameID (
@GameDateTime nvarchar(255),
@GameSite nvarchar(50),
@Sport nvarchar(20),
@Level nvarchar(20)
)
returns int
as 
begin

declare @odGame_id INT
select @odGame_id = odGame_id
from gosGame
where GameDateTime  = convert (datetime, @GameDateTime)
and odSite_id = (select odSite_id from gosSite where SiteName = @GameSite)
and odSportLevel_id = (Select odSportLevel_id from gosSportLevel where Sport = @Sport and [Level] = @Level);

if @odGame_id is null
set @odGame_id = -1
return @odGame_id;
end 
go




------Proceduers

--------------------------------------------------------------------------------------------------------------------------------------------------
---Create udp_User procedure
--------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addUser')
drop procedure usp_addUser;
go
Create Procedure [dbo].usp_addUser
@emailAddress nvarchar(255),
@firstName nvarchar(25),
@lastName nvarchar(50),
@streetAddress nvarchar(255),
@city nvarchar(50),
@state nvarchar(2),
@zip nvarchar(5),
@cellPhoneNumber nvarchar(10),
@homePhoneNumber nvarchar(10),
@workPhoneNumber nvarchar(10)
as
begin
	begin try 

		insert into gosUser
		(emailAddress, firstname, lastname, streetAddress, city, [state], zip, cellPhoneNumber, homePhoneNumber, workPhoneNumber)
		values
		( @emailAddress,
		  @firstName,
		  @lastName,
		  @streetAddress,
		  @city,
		  @state,
		  @zip,
		  @cellPhoneNumber,
		  @homePhoneNumber,
		  @workPhoneNumber);
		  end try

		  begin catch
		  print 'the insert into gosUser FAILED for User ' + @emailAddress
		  end catch
		end
		go

---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addOfficial Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addOfficial')
drop procedure usp_addOfficial;

go

create procedure [dbo].usp_addOfficial
  @emailAddress nvarchar(255),
  @fees money
as
begin
	begin try
		insert into gosOfficial
		(odUser_id, feesAccumulated)
		values
		(
		([dbo].udf_getUserID(@emailAddress)), @fees
		);
	end try
	begin catch
		print 'insert into gosOfficial failed for ' + @emailAddress
	end catch
end
go



----------------------------------------------------------------------------------------------------------------------------------------------
---create udp_oddSite precedure
-----------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addSite')
drop procedure usp_addSite;

go

create procedure [dbo].usp_addSite
	@SiteName nvarchar(255)
,   @phoneNumber nvarchar(10)
,	@streetAddress nvarchar(255)
,	@city nvarchar(25)
,	@state nvarchar(2)
,	@zip nvarchar(9)
as 
begin
	begin try
		insert into gosSite
			(SiteName, PhoneNumber, StreetAdress, City, [State], Zip)
			values
			(@SiteName,
			@phoneNumber,
			@streetAddress,
			@city,
			@state,
			@zip);
	end try
	begin catch
		print 'insert into gosSite FAILED for ' + @SiteName
	end catch
end
go

---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addSchool Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addSchool')
drop procedure usp_addSchool;

go

create procedure [dbo].usp_addSchool
  @SchoolName nvarchar(255),
  @PhoneNumber nvarchar(10),
  @StreetAddress nvarchar(255),
  @City nvarchar (50),
  @State nvarchar (2),
  @Zip nvarchar (9),
  @AthleticDirector nvarchar(50)
as
begin
	begin try
		insert into gosSchool
		(SchoolName,
		PhoneNumber,
		StreetAdress,
		City,
		[State],
		Zip,
		AthleticDirector)
		values
		(
		 @SchoolName,
		 @PhoneNumber,
		 @StreetAddress,
		 @City,
		 @State,
		 @Zip,
		 @AthleticDirector
		);
	end try
	begin catch
		print 'insert into gosSchool failed for ' + @SchoolName
	end catch
end
go
---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addSecurityQuestion Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addSecurityQuestion')
drop procedure usp_addSecurityQuestion;

go

create procedure [dbo].usp_addSecurityQuestion
  @SecurityQuestion nvarchar(255)
as
begin
	begin try
		insert into gosSecurityQuestion
		(SecurityQuestion)
		values
		(
		 @SecurityQuestion
		);
	end try
	begin catch
		print 'insert into gosSecurityQuestion failed for ' + @SecurityQuestion
	end catch
end
go
---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addSecurityQuestion Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addSecurityAnswer')
drop procedure usp_addSecurityAnswer;

go

create procedure [dbo].usp_addSecurityAnswer
  @emailAddress nvarchar(255),
  @SecurityQuestion nvarchar(255),
  @Answer nvarchar(255)
as
begin
	begin try
		insert into gosSecurityAnswer (
		odUser_id,
		odSecurityQuestion_id,
		Answer
		)
		values
		(
		([dbo].udf_getUserID(@emailAddress)),
		([dbo].udf_getSecurityQuestionID(@SecurityQuestion)),
		@Answer
		);
	end try
	begin catch
		print 'insert into gosSecurityAnswer failed.'
	end catch
end
go

---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addGame Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addGame')
drop procedure usp_addGame;

go

create procedure [dbo].usp_addGame
  @GameDateTime nvarchar(255),
  @GameSIte nvarchar(255),
  @Sport nvarchar(20),
  @Level nvarchar(20),
  @HomeTeam nvarchar(255),
  @AwayTeam nvarchar(255)
as
begin
	begin try
		insert into gosGame(
		GameDateTime,
		odSite_id,
		odSportLevel_id,
		HomeTeam, 
		AwayTeam
		)
		values
		(
		convert(datetime, @GameDateTime),
		([dbo].udf_getSiteID(@GameSIte)),
		([dbo].udf_getSportLevelID(@Sport, @Level)),
		([dbo].udf_getSchoolID(@HomeTeam)),
		([dbo].udf_getSchoolID(@AwayTeam))
		);
	end try
	begin catch
		print 'insert into gosGamefailed for ' + @GameDateTime + ' ' + @GameSite + ' ' + @Sport + ' ' + @Level
	end catch
end
go
---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addOfficiatingPosition Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addOfficiatingPosition')
drop procedure usp_addOfficiatingPosition;

go

create procedure [dbo].usp_addOfficiatingPosition
  @PositionName nvarchar(50)
as
begin
	begin try
		insert into gosOfficiatingPosition(
		PositionName
		)
		values
		(
		@PositionName
		);
	end try
	begin catch
		print 'insert into gosOfficiatingPosition failed for ' + @PositionName
	end catch
end
go
---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addSportLevel Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addSportLevel')
drop procedure usp_addSportLevel;

go

create procedure [dbo].usp_addSportLevel
  @Sport nvarchar(25),
  @Level nvarchar(25),
  @pay money
as
begin
	begin try
		insert into gosSportLevel(
		Sport,
		[Level],
		PayRate
		)
		values
		(
		@Sport,
		@Level, 
		@pay
		);
	end try
	begin catch
		print 'insert into gosSportLevel failed for' + @Sport + ' ' + @Level
	end catch
end
go
---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addOfficialQuslification Precedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addOfficialQualification')
drop procedure usp_addOfficialQualification;

go

create procedure [dbo].usp_addOfficialQualification
  @emailAddress nvarchar(255),
  @PositionName nvarchar(50),
  @Sport nvarchar(10),
  @Level nvarchar(20)
as
begin
	begin try
		insert into gosOfficialQualification(
		odUser_id,
		odSportLevel_id,
		odPositionName_id
		)
		values
		(
		([dbo].udf_getUserID(@emailAddress)),
		([dbo].udf_getSportLevelID(@Sport, @Level)),
		([dbo].udf_getPositionNameID(@PositionName))
		);
	end try
	begin catch
		print 'insert into gosOfficialQualification failed for ' + @emailAddress +' ' + @PositionName
	end catch
end
go
---------------------------------------------------------------------------------------------------------------------------------------------------
--Create udp_addGameOfficial procedure
---------------------------------------------------------------------------------------------------------------------------------------------------
if exists (select * from INFORMATION_SCHEMA.ROUTINES where SPECIFIC_NAME = 'usp_addGameOfficial')
drop procedure usp_addGameOfficial;

go

create procedure [dbo].usp_addGameOfficial
  @emailAddress nvarchar(255),
  @GameDateTime nvarchar(50),
  @GameSite nvarchar(255),
  @Sport nvarchar(20),
  @Level nvarchar(20),
  @PositionName nvarchar(50)

as
begin
	begin try
		insert into gosGameOfficial (
		odUser_id,
		odGame_id,
		odPositionName_id
		)
		values
		(
		([dbo].udf_getUserID(@emailAddress)),
		([dbo].udf_getGameID(convert(datetime, @GameDateTime),@GameSite, @Sport, @Level)),
		([dbo].udf_getPositionNameID(@PositionName))
		);
	end try
	begin catch
		print 'insert into gosGameOfficial failed for ' + @emailAddress + ' ' + @PositionName
	end catch
end
go
--------------------------------------------------------------gf---------------------------------------------------------------------------------------------------------------
--------Execute Security Questions
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

execute usp_addSecurityQuestion @SecurityQuestion =	'What was your childhood nickname?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'In what city did you meet your spouse/significant other?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What is the name of your favorite childhood friend?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What street did you live on in third grade?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What is your oldest sibling’s birthday month and year? (e.g., January 1900)'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What is the middle name of your youngest child?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What is your oldest siblins middle name?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What school did you attend for sixth grade?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What was your childhood phone number including area code? (e.g., 000-000-0000)'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What is your oldest cousins first and last name?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What was the name of your first stuffed animal?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'In what city or town did your mother and father meet?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'Where were you when you had your first kiss?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What is the first name of the boy or girl that you first kissed?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'What was the last name of your third grade teacher?'	;
execute usp_addSecurityQuestion @SecurityQuestion =	'In what city does your nearest sibling live?'	;

go
-------------------------------------------------------------------------------------------------------------------------------------------------------------
------Execute Sites 
--------------------------------------------------------------------------------------------------------------------------------------------------------

execute usp_addSite @SiteName = 	'Bear River High School'	,@phoneNumber = 	'4352572500'	,@streetAddress=	'1450 S Main St'	,@city=	'Garland'	,@state=	'UT'	,@zip=	'843129797'	;
execute usp_addSite @SiteName = 	'Clearfield High School'	,@phoneNumber = 	'8014023900'	,@streetAddress=	'931  S Falcon Drive'	,@city=	'Clearfield'	,@state=	'UT'	,@zip=	'84015'	;
execute usp_addSite @SiteName = 	'Dee Event Center'	,@phoneNumber = 	'4357344840'	,@streetAddress=	'4400 Harrison Blvd'	,@city=	'Ogden'	,@state=	'UT'	,@zip=	'84403'	;
execute usp_addSite @SiteName = 	'Farmington High School'	,@phoneNumber = 	'8014028200'	,@streetAddress=	'548 Glovers Ln'	,@city=	'Farmington'	,@state=	'UT'	,@zip=	'840250588'	;
execute usp_addSite @SiteName = 	'Fremont High School'	,@phoneNumber = 	'8014028800'	,@streetAddress=	'1900 N 4700 W'	,@city=	'Ogden'	,@state=	'UT'	,@zip=	'84404'	;
execute usp_addSite @SiteName = 	'Layton High School'	,@phoneNumber = 	'8014029050'	,@streetAddress=	'440 Wasatch Dr'	,@city=	'Layton'	,@state=	'UT'	,@zip=	'840413272'	;
execute usp_addSite @SiteName = 	'Morgan High School'	,@phoneNumber = 	'8014524000'	,@streetAddress=	'55 Trojan Blvd'	,@city=	'Morgan'	,@state=	'UT'	,@zip=	'840500917'	;
execute usp_addSite @SiteName = 	'Mountain Crest High School'	,@phoneNumber = 	'8014024800'	,@streetAddress=	'255 South 800 East'	,@city=	'Hyrum'	,@state=	'UT'	,@zip=	'84319'	;
execute usp_addSite @SiteName = 	'Northridge High School'	,@phoneNumber = 	'4357552380'	,@streetAddress=	'2430 N Hillfield Rd'	,@city=	'Layton'	,@state=	'UT'	,@zip=	'84041'	;
execute usp_addSite @SiteName = 	'Roy High School'	,@phoneNumber = 	'8018293418'	,@streetAddress=	'2150 W 4800 S'	,@city=	'Roy'	,@state=	'UT'	,@zip=	'840671899'	;
execute usp_addSite @SiteName = 	'Sky View High School'	,@phoneNumber = 	'4357927765'	,@streetAddress=	'520 South 250 East'	,@city=	'Smithfield'	,@state=	'UT'	,@zip=	'84335'	;
execute usp_addSite @SiteName = 	'Ben Lomond High School'	,@phoneNumber = 	'8014028500'	,@streetAddress=	'800 Scots Ln'	,@city=	'Ogden'	,@state=	'UT'	,@zip=	'844045199'	;
execute usp_addSite @SiteName = 	'Bonneville High School'	,@phoneNumber = 	'8017744922'	,@streetAddress=	'251 E 4800 S'	,@city=	'Ogden'	,@state=	'UT'	,@zip=	'844056199'	;
execute usp_addSite @SiteName = 	'Bountiful High School'	,@phoneNumber = 	'4355636273'	,@streetAddress=	'695 Orchard Dr'	,@city=	'Bountiful'	,@state=	'UT'	,@zip=	'84010'	;
execute usp_addSite @SiteName = 	'Box Elder High School'	,@phoneNumber = 	'8014027900'	,@streetAddress=	'380 S 600 W'	,@city=	'Brigham City'	,@state=	'UT'	,@zip=	'843022442'	;
execute usp_addSite @SiteName = 	'Davis High School'	,@phoneNumber = 	'8017463700'	,@streetAddress=	'325 S Main St'	,@city=	'Kaysville'	,@state=	'UT'	,@zip=	'840372598'	;
execute usp_addSite @SiteName = 	'Green Canyon High School'	,@phoneNumber = 	'8017377965'	,@streetAddress=	'2960 N Wolfpack Way'	,@city=	'North Logan'	,@state=	'UT'	,@zip=	'84341'	;
execute usp_addSite @SiteName = 	'Logan High School'	,@phoneNumber = 	'8014524050'	,@streetAddress=	'162 W 100 S'	,@city=	'Logan'	,@state=	'UT'	,@zip=	'843215298'	;
execute usp_addSite @SiteName = 	'Ogden High School'	,@phoneNumber = 	'4357929300'	,@streetAddress=	'2828 Harrison Blvd'	,@city=	'Ogden'	,@state=	'UT'	,@zip=	'844030398'	;
execute usp_addSite @SiteName = 	'Ridgeline High School'	,@phoneNumber = 	'8017378700'	,@streetAddress=	'180 North 300 West'	,@city=	'Millville'	,@state=	'UT'	,@zip=	'84326'	;
execute usp_addSite @SiteName = 	'Syracuse High School'	,@phoneNumber = 	'4357927780'	,@streetAddress=	'665 S 2000 W'	,@city=	'Syracuse'	,@state=	'UT'	,@zip=	'84075'	;
execute usp_addSite @SiteName = 	'Viewmont High School'	,@phoneNumber = 	'8014024200'	,@streetAddress=	'120 W 1000 N'	,@city=	'Bountiful'	,@state=	'UT'	,@zip=	'84010'	;
execute usp_addSite @SiteName = 	'Weber High School'	,@phoneNumber = 	'8014024500'	,@streetAddress=	'3650 N 500 W'	,@city=	'Ogden'	,@state=	'UT'	,@zip=	'844141455'	;
execute usp_addSite @SiteName = 	'Woods Cross High School'	,@phoneNumber = 	'8014024500'	,@streetAddress=	'600 W 2200 S'	,@city=	'Woods Cross'	,@state=	'UT'	,@zip=	'84087'	;
execute usp_addSite @SiteName = 	'USU Maverik Stadium'	,@phoneNumber = 	'4357970453'	,@streetAddress=	'1000 North 800 East'	,@city=	'Logan'	,@state=	'UT'	,@zip=	'84341'	;
execute usp_addSite @SiteName = 	'WSU Stewart Stadium'	,@phoneNumber = 	'8016268500'	,@streetAddress=	'3848 Harrison Blvd'	,@city=	'Ogden'	,@state=	'UT'	,@zip=	'84408'	;
go


-----------------------------------------------------------------------------------------------------------------------------------------------------
----Execute User Statements
--------------------------------------------------------------------------                    ------------------------------------------------------`


execute usp_addUser @emailAddress = 'adambaxter@yahoo.com' , @lastName = 'Baxter' ,@firstName = 'Adam' ,@streetAddress = '1969 N 250 E' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8013183890' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8017743323' ;
execute usp_addUser @emailAddress = 'Sheldonb@hotmail.com' , @lastName = 'Bennett' ,@firstName = 'Sheldon' ,@streetAddress = '770 OAKMONT LN.' ,@city= 'Fruit Heights' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8017260200' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'lbirdland@gmail.com' , @lastName = 'Birdland' ,@firstName = 'Lars' ,@streetAddress = '527 Dartmouth Drive' ,@city= 'Morgan' ,@state= 'UT' ,@zip= '84050' ,@cellPhoneNumber= '8019277676' ,@homePhoneNumber= '8019277634' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'marvdeyoung@outlook.com' , @lastName = 'DeYoung' ,@firstName = 'Marv' ,@streetAddress = '1228 N 310 E' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84040' ,@cellPhoneNumber= '8016406046' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'john.eliason@gmail.com' , @lastName = 'Eliason' ,@firstName = 'John' ,@streetAddress = '402 S 750 W' ,@city= 'Riverdale' ,@state= 'UT' ,@zip= '84405' ,@cellPhoneNumber= '8017264706' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'shawnf@gmail.com' , @lastName = 'Fernandez' ,@firstName = 'Shawn' ,@streetAddress = '4934 S. 3900 W.' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8013645907' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8013685829' ;
execute usp_addUser @emailAddress = 'francis.morgan@gmail.com' , @lastName = 'Francis' ,@firstName = 'Morgan' ,@streetAddress = '288 E Primrose Rd,' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84040' ,@cellPhoneNumber= '8013098023' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8016226471' ;
execute usp_addUser @emailAddress = 'gardner1@comcast.net' , @lastName = 'Gardner' ,@firstName = 'Randy' ,@streetAddress = '152 29TH STREET' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84403' ,@cellPhoneNumber= '8016985376' ,@homePhoneNumber= '8016212832' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'david.hansen0000@hotmail.com' , @lastName = 'Hansen' ,@firstName = 'David' ,@streetAddress = '527 North 4200 West' ,@city= 'West Point' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8014987536' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'dennish@msn.com' , @lastName = 'Hooper' ,@firstName = 'Dennis' ,@streetAddress = '1941 S 1350 W' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8017325739' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jeff.jackson1@gmail.com' , @lastName = 'Jackson' ,@firstName = 'Jeffrey' ,@streetAddress = '840 East 1000 North' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4357302126' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'rogtaylor@hotmail.com' , @lastName = 'Taylor' ,@firstName = 'Roger' ,@streetAddress = '42 WEST 800 NORTH' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8015044236' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'tommytaylor88@hotmail.com' , @lastName = 'Taylor' ,@firstName = 'Tommy' ,@streetAddress = '42 WEST 800 NORTH' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8015408756' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jacksonthomas@yahoo.com' , @lastName = 'Thomas' ,@firstName = 'Jackson' ,@streetAddress = '1923 n 200 e' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8015097934' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'darrintreegold@yahoo.com' , @lastName = 'Treegold' ,@firstName = 'Darrin' ,@streetAddress = '3449 Porter Avenue' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84403' ,@cellPhoneNumber= '8016216391' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'tannerthursday@gmail.com' , @lastName = 'Thursday' ,@firstName = 'Tanner' ,@streetAddress = '1389 EASTRIDGE CIRCLE' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4357505536' ,@homePhoneNumber= '4357169667' ,@workPhoneNumber= '4359940494' ;
execute usp_addUser @emailAddress = 'matt.troy@gmail.com' , @lastName = 'Troy' ,@firstName = 'Matt' ,@streetAddress = '307 Homestead Crt.' ,@city= 'Providence' ,@state= 'UT' ,@zip= '84332' ,@cellPhoneNumber= '4358113495' ,@homePhoneNumber= '4352133959' ,@workPhoneNumber= '4357132680' ;
execute usp_addUser @emailAddress = 'kevin.tracy@yahoo.com' , @lastName = 'Tracy' ,@firstName = 'Kevin' ,@streetAddress = '4305A Appomattox Cir.' ,@city= 'HAFB' ,@state= 'UT' ,@zip= '84056' ,@cellPhoneNumber= '2084042259' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'matt.tucker9@gmail.com' , @lastName = 'Tucker' ,@firstName = 'Matt' ,@streetAddress = '504 East 2590 South' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '4355084520' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8018152350' ;
execute usp_addUser @emailAddress = 'trueandtrue@gmail.com' , @lastName = 'Turner' ,@firstName = 'Davis' ,@streetAddress = '1149 South 620 West' ,@city= 'Tremonton' ,@state= 'UT' ,@zip= '84337' ,@cellPhoneNumber= '4352303019' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'andrewunitoa@mail.weber.edu' , @lastName = 'Unitoa' ,@firstName = 'Andrew' ,@streetAddress = '3477 Eccles Ave' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84403' ,@cellPhoneNumber= '8019407854' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'cveibell@netzero.net' , @lastName = 'Veibell' ,@firstName = 'Charles' ,@streetAddress = '3321 South 1200 West' ,@city= 'Riverdale' ,@state= 'UT' ,@zip= '84405' ,@cellPhoneNumber= '8013024234' ,@homePhoneNumber= '8017163685' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'randell.waddington@aggiemail.usu.edu' , @lastName = 'Waddington' ,@firstName = 'Randell' ,@streetAddress = '455 e 200 n apartment 1c' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '8014156325' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'lester.walker@yahoo.com' , @lastName = 'Walker' ,@firstName = 'Lester' ,@streetAddress = '308 Pear Lane' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8016234958' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jeff.wall76@gmail.com' , @lastName = 'Wall' ,@firstName = 'Jeff' ,@streetAddress = '1586 W 1210 N' ,@city= 'Farmington' ,@state= 'UT' ,@zip= '84025' ,@cellPhoneNumber= '8015241670' ,@homePhoneNumber= '8014523949' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'dannywallace@wsd.net' , @lastName = 'Wallace' ,@firstName = 'Danny' ,@streetAddress = '346 E. 1275 North' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8014101472' ,@homePhoneNumber= '8017479446' ,@workPhoneNumber= '8014524239' ;
execute usp_addUser @emailAddress = 'wallingtonscott@hotmail.com' , @lastName = 'Wallington' ,@firstName = 'Scott' ,@streetAddress = '2971 Grandview Dr.' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84403' ,@cellPhoneNumber= '8016103612' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'brett.ward@gmail.com' , @lastName = 'Ward' ,@firstName = 'Brett' ,@streetAddress = '345 W. 360 N.' ,@city= 'Smithfield' ,@state= 'UT' ,@zip= '84335' ,@cellPhoneNumber= '4355023694' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'davidwarren22@hotmail.com' , @lastName = 'Warren' ,@firstName = 'David' ,@streetAddress = '2261 W 6025 S' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8015184330' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'micah.w@aggiemail.usu.edu' , @lastName = 'Watkins' ,@firstName = 'Micah' ,@streetAddress = '2351 N 500 E APT 211' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84341' ,@cellPhoneNumber= '8018072832' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'mark.welch90@gmail.com' , @lastName = 'Welch' ,@firstName = 'Mark' ,@streetAddress = '2320 West 5680 South' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8014032468' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'mathew.willey@hotmail.com' , @lastName = 'Willey' ,@firstName = 'Mathew' ,@streetAddress = '486 North 320 East' ,@city= 'Centerville' ,@state= 'UT' ,@zip= '84014' ,@cellPhoneNumber= '8015409980' ,@homePhoneNumber= '8012950366' ,@workPhoneNumber= '8015608033' ;
execute usp_addUser @emailAddress = 'corey.williams93@hotmail.com' , @lastName = 'Williams' ,@firstName = 'Corey' ,@streetAddress = '836 W. 250 N.' ,@city= 'Morgan' ,@state= 'UT' ,@zip= '84050' ,@cellPhoneNumber= '8016902801' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'kdwilliams@gmail.com' , @lastName = 'Williams' ,@firstName = 'Kyle' ,@streetAddress = '2448 W 1475 S' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8015033692' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'winter.andrew35@gmail.com' , @lastName = 'Winter' ,@firstName = 'Andrew' ,@streetAddress = '1296 Millcreek Drive #10' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8013092397' ,@homePhoneNumber= '8014382815' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'zachwinter23@msn.com' , @lastName = 'Winter' ,@firstName = 'Zachary' ,@streetAddress = '1236 E 2250 N' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84040' ,@cellPhoneNumber= '8013033409' ,@homePhoneNumber= '8015476059' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'twood9020@gmail.com' , @lastName = 'Wood' ,@firstName = 'Thomas' ,@streetAddress = '355 wasatch blvd' ,@city= 'smithfield' ,@state= 'UT' ,@zip= '84335' ,@cellPhoneNumber= '4353023191' ,@homePhoneNumber= '4354934205' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'tom@relaianet.com' , @lastName = 'Wright' ,@firstName = 'Trevor' ,@streetAddress = '5518 N 2700 W' ,@city= 'morgan' ,@state= 'UT' ,@zip= '84050' ,@cellPhoneNumber= '8014080173' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jason.younger@gmail.com' , @lastName = 'Younger' ,@firstName = 'Jason' ,@streetAddress = '239 S. Lincolnshire Way' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8019083001' ,@homePhoneNumber= '8019333490' ,@workPhoneNumber= '8016283526' ;
execute usp_addUser @emailAddress = 'ack.devin@gmail.com' , @lastName = 'Ackerman' ,@firstName = 'Devin' ,@streetAddress = '3215 S 2500 W #2' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8012520239' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'refchrisadams@gmail.com' , @lastName = 'Adams' ,@firstName = 'Chris' ,@streetAddress = '358 West 200 North' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8016994403' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8017774911' ;
execute usp_addUser @emailAddress = 'bga78@msn.com' , @lastName = 'Allen' ,@firstName = 'Bryce' ,@streetAddress = '470 E 180 N' ,@city= 'Smithfield' ,@state= 'UT' ,@zip= '84335' ,@cellPhoneNumber= '4357600623' ,@homePhoneNumber= '4355623710' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'grukmuk@msn.com' , @lastName = 'Allen' ,@firstName = 'Randy' ,@streetAddress = '3592 South 400 East' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4352321449' ,@homePhoneNumber= '4357557148' ,@workPhoneNumber= '4357529456' ;
execute usp_addUser @emailAddress = 'brandon@petro.com' , @lastName = 'Atkinson' ,@firstName = 'Braydon' ,@streetAddress = '2233 S. 1500 W.' ,@city= 'Woods Cross' ,@state= 'UT' ,@zip= '84087' ,@cellPhoneNumber= '8015093487' ,@homePhoneNumber= '8012942798' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'tybar14@hotmail.com' , @lastName = 'Barfuss' ,@firstName = 'Tyson' ,@streetAddress = '2212 North 750 West' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8015263903' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'karlbeckstrom@msn.com' , @lastName ='Beckstrom' ,@firstName = 'Karl' ,@streetAddress = '2889 West 1125 North' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8016787948' ,@homePhoneNumber= '8018395679' ,@workPhoneNumber= '8012044546' ;
execute usp_addUser @emailAddress = 'mikeb@aspen.com' , @lastName = 'Benson' ,@firstName = 'Mike' ,@streetAddress = '65 W. 1800 S.' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8017218613' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'paul.bernier@gmail.com' , @lastName = 'Bernier' ,@firstName = 'Paul' ,@streetAddress = '1145 N. 1120 W.' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8017269342' ,@homePhoneNumber= '8017767584' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'ldjbon@gmail.com' , @lastName = 'Bonnett' ,@firstName = 'Larry' ,@streetAddress = '2434 Gramercy Avenue' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84401' ,@cellPhoneNumber= '3302583674' ,@homePhoneNumber= '3852068476' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jeffbraun8@gmail.com' , @lastName = 'Braun' ,@firstName = 'Jeff' ,@streetAddress = '3834 N 400 E' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8013913437' ,@homePhoneNumber= '8017373482' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'ronbrenk@q.com' , @lastName = 'Brenkmann' ,@firstName = 'Ron' ,@streetAddress = '1550 N. 1750 W.' ,@city= 'Plain City' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8016485447' ,@homePhoneNumber= '8017329136' ,@workPhoneNumber= '8015367561' ;
execute usp_addUser @emailAddress = 'brownfgary@yahoo.com' , @lastName = 'Brown' ,@firstName = 'Gary' ,@streetAddress = '623 West 3050 South' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8016604529' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'davidbueller@yahoo.com' , @lastName = 'Bueller' ,@firstName = 'David' ,@streetAddress = '1050 E 1700 N' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84040' ,@cellPhoneNumber= '8017253457' ,@homePhoneNumber= '8015107830' ,@workPhoneNumber= '8017756878' ;
execute usp_addUser @emailAddress = 'burnettdan@hotmail.com' , @lastName = 'Burnett' ,@firstName = 'Daniel' ,@streetAddress = 'P.O. Box 145' ,@city= 'Riverside' ,@state= 'UT' ,@zip= '84334' ,@cellPhoneNumber= '4352794156' ,@homePhoneNumber= '4354583232' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'bryanburningham@hotmail.com' , @lastName = 'Burningham' ,@firstName = 'Bryan' ,@streetAddress = '532 E 1250 N' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8016900329' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'kamburny@mstar.net' , @lastName = 'Burningham' ,@firstName = 'Kamaron' ,@streetAddress = '454 West 1850 South' ,@city= 'Woods Cross' ,@state= 'UT' ,@zip= '840872112' ,@cellPhoneNumber= '8015104833' ,@homePhoneNumber= '8012929489' ,@workPhoneNumber= '8012986036' ;
execute usp_addUser @emailAddress = 'cartercarl_358@hotmail.com' , @lastName = 'Carter' ,@firstName = 'Carl' ,@streetAddress = '135 E 500 N' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8016820896' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'bobcarre@live.com' , @lastName = 'Christensen' ,@firstName = 'Bob' ,@streetAddress = '5343 S 1500 E' ,@city= 'South Weber' ,@state= 'UT' ,@zip= '84405' ,@cellPhoneNumber= '8012628735' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8016999279' ;
execute usp_addUser @emailAddress = 'dfc99@yahoo.com' , @lastName = 'Christensen' ,@firstName = 'Devin' ,@streetAddress = '1776 NORTH 1325 WEST' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8013882399' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8015949600' ;
execute usp_addUser @emailAddress = 'jon34131.jc@gmail.com' , @lastName = 'Christensen' ,@firstName = 'Jonathan' ,@streetAddress = '524w. 1980s.' ,@city= 'Nibley' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4354541654' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'nickcole@gmail.com' , @lastName = 'Cole' ,@firstName = 'Nick' ,@streetAddress = '1775 N. 400 E. # 9' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84341' ,@cellPhoneNumber= '4357601256' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'wcole@gmail.com' , @lastName = 'Cole' ,@firstName = 'William' ,@streetAddress = '1642 n. 1125 e.' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8014109738' ,@homePhoneNumber= '8015104727' ,@workPhoneNumber= '8014092114' ;
execute usp_addUser @emailAddress = 'trevorcondie@comcast.net' , @lastName = 'Condie' ,@firstName = 'Trevor' ,@streetAddress = '3478 Lakeview Drive' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8012033645' ,@homePhoneNumber= '8017823879' ,@workPhoneNumber= '4358639450' ;
execute usp_addUser @emailAddress = 'kconnersUtah@comcast.net' , @lastName = 'Conners' ,@firstName = 'Kevin' ,@streetAddress = '1862 N 290 W' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8016093386' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'randall.crowell@autoliv.net' , @lastName = 'Crowell' ,@firstName = 'Randall' ,@streetAddress = '2458 N. 400 E.' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8017438813' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8016252477' ;
execute usp_addUser @emailAddress = 'kevinc987@yahoo.com' , @lastName = 'Cullimore' ,@firstName = 'Kevin' ,@streetAddress = '335 South Kays Drive' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8016569890' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'kraigculli@hotmail.com' , @lastName = 'Cullimore' ,@firstName = 'Kraig' ,@streetAddress = '498 N 2375 W' ,@city= 'West Point' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8018093103' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'konnorcullimore@live.com' , @lastName = 'Cullimore' ,@firstName = 'Konnor' ,@streetAddress = '1676 w 1400n' ,@city= 'Farr West' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8016059846' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'cactuscutler89@yahoo.com' , @lastName = 'Cutler' ,@firstName = 'Mark' ,@streetAddress = '466 South 400 West' ,@city= 'Garland' ,@state= 'UT' ,@zip= '84312' ,@cellPhoneNumber= '4354523380' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'braddavies50@hotmail.com' , @lastName = 'Davies' ,@firstName = 'Bradley' ,@streetAddress = '1458 West 1260 North' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8014603662' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'evandavis@gmail.com' , @lastName = 'Davis' ,@firstName = 'Evan' ,@streetAddress = '68 South 1450 West' ,@city= 'Clearfield' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8015498977' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'mdavis345@gmail.com' , @lastName = 'Davis' ,@firstName = 'Mark' ,@streetAddress = '3590 van buren #42' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84403' ,@cellPhoneNumber= '8016083618' ,@homePhoneNumber= '8014222947' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'tomdeelstra@utah.gov' , @lastName = 'Deelstra' ,@firstName = 'Tom' ,@streetAddress = '2757 W 1825 S' ,@city= 'West Haven' ,@state= 'UT' ,@zip= '84401' ,@cellPhoneNumber= '8014888496' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'freddenucci@comcast.net' , @lastName = 'Denucci' ,@firstName = 'Fredrick' ,@streetAddress = '3460 S. Elaine' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8016900113' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'david.dickson@gmail.com' , @lastName = 'Dickson' ,@firstName = 'David' ,@streetAddress = '234 Eagle Way' ,@city= 'Fruit Heights' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8018296606' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'devindom@msn.com' , @lastName = 'Dominguez' ,@firstName = 'Devin' ,@streetAddress = '3021 w 2450 s' ,@city= 'West Haven' ,@state= 'UT' ,@zip= '84401' ,@cellPhoneNumber= '8018065015' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jeffdowns@gmail.com' , @lastName = 'Downs' ,@firstName = 'Jeff' ,@streetAddress = '257 W. 675 S.' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8016024270' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'brettdyer@live.com' , @lastName = 'Dyer' ,@firstName = 'Brett' ,@streetAddress = '3612 w 300 s' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8016806321' ,@homePhoneNumber= '8012934136' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'brevindyer29@live.com' , @lastName = 'Dyer' ,@firstName = 'Brevin' ,@streetAddress = '3612 w 300 s' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8013082820' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'kevindyer36@digis.net' , @lastName = 'Dyer' ,@firstName = 'Kevin' ,@streetAddress = '1788 W 675 S' ,@city= 'OGDEN' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8019403915' ,@homePhoneNumber= '8013932936' ,@workPhoneNumber= '8013742800' ;
execute usp_addUser @emailAddress = 'sportsref20@yahoo.com' , @lastName = 'Eames' ,@firstName = 'Ronald' ,@streetAddress = '5249 W 12825 N' ,@city= 'GARLAND' ,@state= 'UT' ,@zip= '84312' ,@cellPhoneNumber= '4352794880' ,@homePhoneNumber= '4352579625' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'matt_elkins@msn.com' , @lastName = 'Elkins' ,@firstName = 'Matt' ,@streetAddress = '1415 N. 2225 W' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8015899826' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8017759850' ;
execute usp_addUser @emailAddress = 'brfootball67@gmail.com' , @lastName = 'Ellis' ,@firstName = 'Charles' ,@streetAddress = '1850 W 875 N Apt A8' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '4352303951' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'michaelengledow@comcast.net' , @lastName = 'Engledow' ,@firstName = 'Michael' ,@streetAddress = 'P.O. Box 399' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8016191287' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'thomas.evans49@gmail.com' , @lastName = 'Evans' ,@firstName = 'Thomas' ,@streetAddress = '3052B Minuteman Way' ,@city= 'Hill AFB' ,@state= 'UT' ,@zip= '84056' ,@cellPhoneNumber= '8082712491' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'georgeeverett@hotmail.com' , @lastName = 'Everett' ,@firstName = 'George' ,@streetAddress = '1372 NORTH 3450 EAST' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84040' ,@cellPhoneNumber= '8017215872' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'steven.farnsworth@gmail.com' , @lastName = 'Farnsworth' ,@firstName = 'Steven' ,@streetAddress = '534 West 800 South' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '4355022320' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8015663428' ;
execute usp_addUser @emailAddress = 'marcus.federer@yahoo.com' , @lastName = 'Federer' ,@firstName = 'Marcus' ,@streetAddress = '3255 N. 4575 W.' ,@city= 'Plain City' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8055083384' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8015469889' ;
execute usp_addUser @emailAddress = 'mariofurm@comcast.net' , @lastName = 'Fuhriman' ,@firstName = 'Mario' ,@streetAddress = '236 North 300 East' ,@city= 'Providence' ,@state= 'UT' ,@zip= '84332' ,@cellPhoneNumber= '4357654477' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'galbraith98@comcast.net' , @lastName = 'Galbraith' ,@firstName = 'Reggie' ,@streetAddress = '1323 29TH STREET' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84403' ,@cellPhoneNumber= '8016965346' ,@homePhoneNumber= '8016012850' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'gangwerroger@aol.com' , @lastName = 'Gangwer' ,@firstName = 'Roger' ,@streetAddress = '1390 W 1800 N' ,@city= 'Farr West' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8014605963' ,@homePhoneNumber= '8017424842' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'cgermany@comcast.net' , @lastName = 'Germany' ,@firstName = 'Chris' ,@streetAddress = '350 N. Sherwood Dr' ,@city= 'Providence' ,@state= 'UT' ,@zip= '84332' ,@cellPhoneNumber= '8012479674' ,@homePhoneNumber= '4357564282' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'graycurtis39@aol.com' , @lastName = 'Gray' ,@firstName = 'Curtis' ,@streetAddress = '1740 North Dennis Dr.' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8019291386' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8014090780' ;
execute usp_addUser @emailAddress = 'tomgriff@gmail.com' , @lastName = 'Griffin' ,@firstName = 'Thomas' ,@streetAddress = '850 N 4000 W' ,@city= 'Mendon' ,@state= 'UT' ,@zip= '84325' ,@cellPhoneNumber= '4357609366' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'shadley@juno.com' , @lastName = 'Hadley' ,@firstName = 'Steven' ,@streetAddress = '372 N Brahma Rd.' ,@city= 'Farmington' ,@state= 'UT' ,@zip= '84025' ,@cellPhoneNumber= '8018040579' ,@homePhoneNumber= '8014513320' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'keith.hales@yahoo.com' , @lastName = 'Hales' ,@firstName = 'Keith' ,@streetAddress = '366 W Center St' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8015102365' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'johnhancock@yahoo.com' , @lastName = 'Hancock' ,@firstName = 'John' ,@streetAddress = '442 S. 4200 W.' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8013094440' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'markhaney@hotmail.com' , @lastName = 'Haney' ,@firstName = 'Mark' ,@streetAddress = '3317 S. Bluff Ridge Dr.' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8016377959' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8014546098' ;
execute usp_addUser @emailAddress = 'dannyghansen@gmail.com' , @lastName = 'Hansen' ,@firstName = 'Daniel' ,@streetAddress = '1226 West 4550 North' ,@city= 'Amalga' ,@state= 'UT' ,@zip= '84335' ,@cellPhoneNumber= '4357400141' ,@homePhoneNumber= NULL ,@workPhoneNumber= '4355459052' ;
execute usp_addUser @emailAddress = 'anthonyharris@gmail.com' , @lastName = 'Harris' ,@firstName = 'Anthony' ,@streetAddress = '2763 s Allison Way' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8012568055' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'carsonharry@gmail.com' , @lastName = 'Harry' ,@firstName = 'Carson' ,@streetAddress = '1620 Orchard Dr Unit A' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8016698701' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'barronhatfield@yahoo.com' , @lastName = 'Hatfield' ,@firstName = 'Barron' ,@streetAddress = '588 N Quincy Ave' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84404' ,@cellPhoneNumber= '8016904750' ,@homePhoneNumber= '8016755118' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'thomashellstrom@wsd.net' , @lastName = 'Hellstrom' ,@firstName = 'Thomas' ,@streetAddress = '2248 N 700 E' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8015687499' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'hill_dennis@outlook.com' , @lastName = 'Hill' ,@firstName = 'Dennis' ,@streetAddress = '1342 West 2700 North' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8016087507' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'larryhill@gmail.com' , @lastName = 'Hill' ,@firstName = 'Larry' ,@streetAddress = '372 Whisperwood Cove' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8016496922' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'connor.hoopes@aggiemail.usu.edu' , @lastName = 'Hoopes' ,@firstName = 'Cannor' ,@streetAddress = '454 Sharon St.' ,@city= 'Morgan' ,@state= 'UT' ,@zip= '84050' ,@cellPhoneNumber= '8018286178' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'garrett.horsley@gmail.com' , @lastName = 'Horsley' ,@firstName = 'Garrett' ,@streetAddress = '2451 West 700 North' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8016082581' ,@homePhoneNumber= '8015442233' ,@workPhoneNumber= '8012226728' ;
execute usp_addUser @emailAddress = 'jeffrey.hoskins@hotmail.com' , @lastName = 'Hoskins' ,@firstName = 'Jeffrey' ,@streetAddress = '4285 S 2900 W Unit C' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8016286861' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'heyvern@gmail.com' , @lastName = 'Hunnel' ,@firstName = 'Vern' ,@streetAddress = '648 S. Douglas Dr.' ,@city= 'Brigham City' ,@state= 'UT' ,@zip= '84302' ,@cellPhoneNumber= '4357308764' ,@homePhoneNumber= '4357236760' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'alan.hunsaker@hsc.utah.edu' , @lastName = 'Hunsaker' ,@firstName = 'Alan' ,@streetAddress = '1589 W Gentile Street' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8016033402' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'kfh@comcast.net' , @lastName = 'Hunter' ,@firstName = 'Kevin' ,@streetAddress = '3318 Adams Avenue' ,@city= 'Ogden' ,@state= 'UT' ,@zip= '84401' ,@cellPhoneNumber= '8018043275' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8017017393' ;
execute usp_addUser @emailAddress = 'caseyjack@gmail.com' , @lastName = 'Jackson' ,@firstName = 'Casey' ,@streetAddress = '2758 North 465 West' ,@city= 'West Bountiful' ,@state= 'UT' ,@zip= '84087' ,@cellPhoneNumber= '8015643875' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'bwj9999@hotmail.com' , @lastName = 'Jeffs' ,@firstName = 'Bryce' ,@streetAddress = '1785 E. SHERWOOD DRIVE' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8017259017' ,@homePhoneNumber= '8015445692' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'larryjensen@syracuseut.com' , @lastName = 'Jensen' ,@firstName = 'Larry' ,@streetAddress = '1945 s 1285 w' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8018073535' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'terryjensen209@hotmail.com' , @lastName = 'Jensen' ,@firstName = 'Terry' ,@streetAddress = '3475 North 450 East' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8013758774' ,@homePhoneNumber= '8017829870' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'scottjohnson0909@hotmail.com' , @lastName = 'Johnson' ,@firstName = 'Scott' ,@streetAddress = '555 NORTH 3500 WEST' ,@city= 'Clearfield' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8016081129' ,@homePhoneNumber= '8017734420' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'mattjones@gpi.com' , @lastName = 'Jones' ,@firstName = 'Matthew' ,@streetAddress = '4012 W 4900 S' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8016902020' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'ronaldkennedy1@yahoo.com' , @lastName = 'Kennedy' ,@firstName = 'Ronald' ,@streetAddress = '1203 w 3475 n' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8018044338' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'stevenkibler@gmail.com' , @lastName = 'Kibler' ,@firstName = 'Steven' ,@streetAddress = '507 North 1620 West' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8014073667' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'blainkilburn@yahoo.com' , @lastName = 'Kilburn' ,@firstName = 'Blaine' ,@streetAddress = '1538 S 1050 W' ,@city= 'Clearfield' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8018044209' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jonathankilburn@aol.com' , @lastName = 'Kilburn' ,@firstName = 'Jonathan' ,@streetAddress = '1280 EAST CANYON DR.' ,@city= 'South Weber' ,@state= 'UT' ,@zip= '84405' ,@cellPhoneNumber= '8019205980' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'calvinking@gmail.com' , @lastName = 'King' ,@firstName = 'Calvin' ,@streetAddress = '108 Bamberger Way' ,@city= 'Centerville' ,@state= 'UT' ,@zip= '84014' ,@cellPhoneNumber= '8014090863' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8013056989' ;
execute usp_addUser @emailAddress = 'sking@munnsmfg.com' , @lastName = 'King' ,@firstName = 'Scott' ,@streetAddress = '10235 North 4400 West' ,@city= 'Garland' ,@state= 'UT' ,@zip= '84312' ,@cellPhoneNumber= '4354024768' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'trevorking@gmail.com' , @lastName = 'King' ,@firstName = 'Trevor' ,@streetAddress = '1942 S 350 E' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8014051319' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'craig.larsen@usu.edu' , @lastName = 'Larsen' ,@firstName = 'Craig' ,@streetAddress = '658 South 1000 East' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4357604268' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'clifflaw99@yahoo.com' , @lastName = 'Law' ,@firstName = 'Cliff' ,@streetAddress = '126 north 500 west' ,@city= 'Smithfield' ,@state= 'UT' ,@zip= '84335' ,@cellPhoneNumber= '4359041970' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'coreylayton98@hotmail.com' , @lastName = 'Layton' ,@firstName = 'Corey' ,@streetAddress = '459 N. Country Way' ,@city= 'Fruit Heights' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8018978632' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'randy_leetham@keybank.com' , @lastName = 'Leetham' ,@firstName = 'Randy' ,@streetAddress = 'PO Box 104' ,@city= 'Hyrum' ,@state= 'UT' ,@zip= '84319' ,@cellPhoneNumber= '4357209071' ,@homePhoneNumber= '4352555627' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'paulleonard234@yahoo.com' , @lastName = 'Leonard' ,@firstName = 'Paul' ,@streetAddress = '537 Leonard Lane' ,@city= 'Farmington' ,@state= 'UT' ,@zip= '84025' ,@cellPhoneNumber= '8012092366' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'adammarietti@hotmail.com' , @lastName = 'Marietti' ,@firstName = 'Adam' ,@streetAddress = '2082 w 3495 n' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8016056874' ,@homePhoneNumber= '8012093822' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'ddmartin2020@msn.com' , @lastName = 'Martin' ,@firstName = 'Dennis' ,@streetAddress = '278 W 2330 N' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84341' ,@cellPhoneNumber= '4357074359' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'marcusmaxey@gmail.com' , @lastName = 'Maxey' ,@firstName = 'Marcus' ,@streetAddress = '340 Canyon Cove' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '8013129889' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'msmcd9853@gmail.com' , @lastName = 'McDonald' ,@firstName = 'Matt' ,@streetAddress = '1290 South 250 West' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8014075542' ,@homePhoneNumber= '8012983020' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'meffmckenney12@yahoo.com' , @lastName = 'McKenney' ,@firstName = 'Jeff' ,@streetAddress = '2456 South 1850 West' ,@city= 'Nibley' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4353607701' ,@homePhoneNumber= '4357674209' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'mark.mills94@gmail.com' , @lastName = 'Mills' ,@firstName = 'Mark' ,@streetAddress = '331 E 1850 S' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8016940304' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'KyleMitchell1990@gmail.com' , @lastName ='Mitchell' ,@firstName = 'Kyle' ,@streetAddress = '349 EAST 900 NORTH' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4357535466' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'johnqnelson@dsdmail.net' , @lastName = 'Nelson' ,@firstName = 'John' ,@streetAddress = '533 s 1500 e' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8015402233' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'boomer3685@yahoo.com' , @lastName = 'Neuteboom' ,@firstName = 'Charles' ,@streetAddress = '787 E 500 N' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '840372005' ,@cellPhoneNumber= '8016032353' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'thomascnoker@hotmail.com' , @lastName = 'Noker' ,@firstName = 'Thomas' ,@streetAddress = '985 Miller Way' ,@city= 'Farmington' ,@state= 'UT' ,@zip= '84025' ,@cellPhoneNumber= '8015093230' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8015092861' ;
execute usp_addUser @emailAddress = 'kevin.norman@aggiemail.usu.edu' , @lastName = 'Norman' ,@firstName = 'Kevin' ,@streetAddress = '4578 W 4950 S' ,@city= 'West Haven' ,@state= 'UT' ,@zip= '84401' ,@cellPhoneNumber= '8016900214' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'kirk.osborne.ko@gmail.com' , @lastName = 'Osborne' ,@firstName = 'kirk' ,@streetAddress = '781 w 200 n' ,@city= 'clearfield' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8015080676' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'ottleybradley@msn.com' , @lastName = 'Ottley' ,@firstName = 'Bradley' ,@streetAddress = '301 E 730 N' ,@city= 'Smithfield' ,@state= 'UT' ,@zip= '84335' ,@cellPhoneNumber= '4358017449' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jeremywoverton1@gmail.com' , @lastName = 'Overton' ,@firstName = 'Jeremy' ,@streetAddress = '5278 S 2375 W' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8016483448' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'pagejerod1976@gmail.com' , @lastName = 'Page' ,@firstName = 'Jerod' ,@streetAddress = '1437 BLACK LN' ,@city= 'FARMINGTON' ,@state= 'UT' ,@zip= '84025' ,@cellPhoneNumber= '8019743488' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'johnmpage@gmail.com' , @lastName = 'Page' ,@firstName = 'John' ,@streetAddress = '1437 Black Ln.' ,@city= 'Farmington' ,@state= 'UT' ,@zip= '84025' ,@cellPhoneNumber= '8019560278' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'refwalter@yahoo.com' , @lastName = 'Pead' ,@firstName = 'Walter' ,@streetAddress = '678 South 300 East' ,@city= 'Layton' ,@state= 'UT' ,@zip= '84041' ,@cellPhoneNumber= '8016089655' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'sampeisley@comcast.net' , @lastName = 'Peisley' ,@firstName = 'Samuel' ,@streetAddress = '1544 SOUTH MAIN ST' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8014515913' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'lesterpetersen1@gmail.com' , @lastName = 'Petersen' ,@firstName = 'Lester' ,@streetAddress = '539 West 1300 South' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8014058518' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'peterson98657@comcast.net' , @lastName = 'Peterson' ,@firstName = 'Dennis' ,@streetAddress = '1533 East Canyon Drive' ,@city= 'South Weber' ,@state= 'UT' ,@zip= '84405' ,@cellPhoneNumber= '8014182217' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'joshuapeterson@live.com' , @lastName = 'Peterson' ,@firstName = 'Joshua' ,@streetAddress = '997 North 4200 West' ,@city= 'West Point' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '4355503184' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'pilewicz.marvin@hotmail.com' , @lastName = 'Pilewicz' ,@firstName = 'Marvin' ,@streetAddress = '2406 W. 3275 So' ,@city= 'West Haven' ,@state= 'UT' ,@zip= '84401' ,@cellPhoneNumber= '8014522329' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'normanplaizier@gmail.com' , @lastName = 'Plaizier' ,@firstName = 'Norman' ,@streetAddress = '110 w 1800 s' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8015404331' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'bradpoll@wsd.net' , @lastName = 'Poll' ,@firstName = 'Brad' ,@streetAddress = '1275 S. 2200 W.' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8017094790' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'thadporter@yahoo.com' , @lastName = 'Porter' ,@firstName = 'Thad' ,@streetAddress = '446 E 1375 N' ,@city= 'North Ogden' ,@state= 'UT' ,@zip= '84414' ,@cellPhoneNumber= '8016044138' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'jonathanquist@aerotechmfg.com' , @lastName = 'Quist' ,@firstName = 'Jonathan' ,@streetAddress = '797 West 1325 South' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8015334988' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'tylerrasmussen@msn.com' , @lastName = 'Rasmussen' ,@firstName = 'Tyler' ,@streetAddress = '1902 w 4750 s' ,@city= 'Riverdale' ,@state= 'UT' ,@zip= '84405' ,@cellPhoneNumber= '8015260347' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'reidcarlos23@gmail.com' , @lastName = 'Reid' ,@firstName = 'Carlos' ,@streetAddress = '2709 NORTH 1330 WEST' ,@city= 'Clinton' ,@state= 'UT' ,@zip= '84015' ,@cellPhoneNumber= '8013986255' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'mitch.reimer@comcast.net' , @lastName = 'Reimer' ,@firstName = 'Mitch' ,@streetAddress = '4194 S 2175 W' ,@city= 'Roy' ,@state= 'UT' ,@zip= '84067' ,@cellPhoneNumber= '8013939801' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'richjeff@gmail.com' , @lastName = 'Rich' ,@firstName = 'Jeff' ,@streetAddress = '366 north Tierra Vista court' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8015035625' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'chad.richins@gmail.com' , @lastName = 'Richins' ,@firstName = 'Chad' ,@streetAddress = '1089 South 450 East' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8014885554' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'scott.riley88@gmail.com' , @lastName = 'Riley' ,@firstName = 'Scott' ,@streetAddress = '2727 West 200 South' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8016384526' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'Robinson.David@gmail.com' , @lastName = 'Robinson' ,@firstName = 'David' ,@streetAddress = '561 W 300 N' ,@city= 'Brigham' ,@state= 'UT' ,@zip= '84302' ,@cellPhoneNumber= '4357204001' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'karl.robinson56@yahoo.com' , @lastName = 'Robinson' ,@firstName = 'Karl' ,@streetAddress = '350 West 650 North' ,@city= 'Logan' ,@state= 'UT' ,@zip= '84321' ,@cellPhoneNumber= '4357244884' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'bjross33@netzero.com' , @lastName = 'Ross' ,@firstName = 'Bruce' ,@streetAddress = '453 South Morgan Valley Drive' ,@city= 'Morgan' ,@state= 'UT' ,@zip= '84050' ,@cellPhoneNumber= '8014552388' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'football98@gmail.com' , @lastName = 'Rowland' ,@firstName = 'Tyson' ,@streetAddress = '782 West 400 South' ,@city= 'Woods Cross' ,@state= 'UT' ,@zip= '84087' ,@cellPhoneNumber= '8016187543' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'danielrudolph@hotmail.com' , @lastName = 'Rudolph' ,@firstName = 'Daniel' ,@streetAddress = '1833 Carston Court' ,@city= 'Farmington' ,@state= 'UT' ,@zip= '84025' ,@cellPhoneNumber= '8017153612' ,@homePhoneNumber= NULL ,@workPhoneNumber= '8013223412' ;
execute usp_addUser @emailAddress = 'sadlerterrance@msn.com' , @lastName = 'Sadler' ,@firstName = 'Terrance' ,@streetAddress = '1724 East Sunset Hollow Dr' ,@city= 'Bountiful' ,@state= 'UT' ,@zip= '84010' ,@cellPhoneNumber= '8017883425' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'markschofield34@gmail.com' , @lastName = 'Schofield' ,@firstName = 'Mark' ,@streetAddress = '1295 South 2600 West' ,@city= 'Syracuse' ,@state= 'UT' ,@zip= '84075' ,@cellPhoneNumber= '8018022959' ,@homePhoneNumber= '8017746888' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'schryversteve@live.com' , @lastName = 'Schryver' ,@firstName = 'Steve' ,@streetAddress = '171 East 450 South' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8017065664' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'randy.shapiro@gmail.com' , @lastName = 'Shapiro' ,@firstName = 'Randy' ,@streetAddress = '383 S 950 E' ,@city= 'Kaysville' ,@state= 'UT' ,@zip= '84037' ,@cellPhoneNumber= '8017063867' ,@homePhoneNumber= '8015466921' ,@workPhoneNumber= NULL ;
execute usp_addUser @emailAddress = 'vshurtliff909@gmail.com' , @lastName = 'Shurtliff' ,@firstName = 'Vaughn' ,@streetAddress = '410 North 300 west' ,@city= 'Centerville' ,@state= 'UT' ,@zip= '84014' ,@cellPhoneNumber= '8014142912' ,@homePhoneNumber= NULL ,@workPhoneNumber= NULL ;
go


----------------------------------------------------------------------------------------------------------------------------------------------------------
----------Execute addOfficial
---------------------------------------------------------------------------------------------------------------------------------------------------------

execute usp_addOfficial @emailAddress =	'adambaxter@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'Sheldonb@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'lbirdland@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'marvdeyoung@outlook.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'john.eliason@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'shawnf@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'francis.morgan@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'gardner1@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'david.hansen0000@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'dennish@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jeff.jackson1@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'rogtaylor@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'tommytaylor88@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jacksonthomas@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'darrintreegold@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'tannerthursday@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'matt.troy@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kevin.tracy@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'matt.tucker9@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'trueandtrue@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'cveibell@netzero.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'lester.walker@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jeff.wall76@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'dannywallace@wsd.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'wallingtonscott@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'brett.ward@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'davidwarren22@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'micah.w@aggiemail.usu.edu'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mark.welch90@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mathew.willey@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'corey.williams93@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kdwilliams@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'winter.andrew35@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'zachwinter23@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'twood9020@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'tom@relaianet.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jason.younger@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'ack.devin@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'refchrisadams@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'bga78@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'grukmuk@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'brandon@petro.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'tybar14@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'karlbeckstrom@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mikeb@aspen.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'paul.bernier@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'ldjbon@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jeffbraun8@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'ronbrenk@q.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'brownfgary@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'davidbueller@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'burnettdan@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'bryanburningham@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kamburny@mstar.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'cartercarl_358@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'bobcarre@live.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'dfc99@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jon34131.jc@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'nickcole@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'wcole@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'trevorcondie@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kconnersUtah@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'randall.crowell@autoliv.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kevinc987@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kraigculli@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'konnorcullimore@live.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'cactuscutler89@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'braddavies50@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'evandavis@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mdavis345@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'tomdeelstra@utah.gov'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'freddenucci@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'david.dickson@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'devindom@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jeffdowns@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'brettdyer@live.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'brevindyer29@live.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kevindyer36@digis.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'sportsref20@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'matt_elkins@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'brfootball67@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'michaelengledow@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'thomas.evans49@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'georgeeverett@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'steven.farnsworth@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'marcus.federer@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mariofurm@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'galbraith98@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'gangwerroger@aol.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'cgermany@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'graycurtis39@aol.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'tomgriff@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'shadley@juno.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'keith.hales@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'johnhancock@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'markhaney@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'dannyghansen@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'anthonyharris@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'carsonharry@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'barronhatfield@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'thomashellstrom@wsd.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'hill_dennis@outlook.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'larryhill@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'connor.hoopes@aggiemail.usu.edu'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'garrett.horsley@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jeffrey.hoskins@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'heyvern@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'alan.hunsaker@hsc.utah.edu'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kfh@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'caseyjack@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'bwj9999@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'larryjensen@syracuseut.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'terryjensen209@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'scottjohnson0909@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mattjones@gpi.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'ronaldkennedy1@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'stevenkibler@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'blainkilburn@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jonathankilburn@aol.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'calvinking@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'sking@munnsmfg.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'trevorking@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'craig.larsen@usu.edu'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'clifflaw99@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'coreylayton98@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'randy_leetham@keybank.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'paulleonard234@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'adammarietti@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'ddmartin2020@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'marcusmaxey@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'msmcd9853@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'meffmckenney12@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mark.mills94@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'KyleMitchell1990@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'johnqnelson@dsdmail.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'boomer3685@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'thomascnoker@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kevin.norman@aggiemail.usu.edu'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'kirk.osborne.ko@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'ottleybradley@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jeremywoverton1@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'pagejerod1976@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'johnmpage@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'refwalter@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'sampeisley@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'lesterpetersen1@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'peterson98657@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'joshuapeterson@live.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'pilewicz.marvin@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'normanplaizier@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'bradpoll@wsd.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'thadporter@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'jonathanquist@aerotechmfg.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'tylerrasmussen@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'reidcarlos23@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'mitch.reimer@comcast.net'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'richjeff@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'chad.richins@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'scott.riley88@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'Robinson.David@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'karl.robinson56@yahoo.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'bjross33@netzero.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'football98@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'danielrudolph@hotmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'sadlerterrance@msn.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'markschofield34@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'schryversteve@live.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'randy.shapiro@gmail.com'	  , 	@fees =	0.00	;
execute usp_addOfficial @emailAddress =	'vshurtliff909@gmail.com'	  , 	@fees =	0.00	;
go
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------Execute Schools
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

execute usp_addSchool @SchoolName =	'Bear River High School'	,@PhoneNumber = 	'4352572500'	,@StreetAddress = 	'1450 S Main St'	,@City = 	'Garland'	,@State=	'UT'	,@Zip=	'843129797'	,@AthleticDirector=	'Van Park'	;
execute usp_addSchool @SchoolName =	'Bountiful High School'	,@PhoneNumber = 	'8014023900'	,@StreetAddress = 	'695 Orchard Dr'	,@City = 	'Bountiful'	,@State=	'UT'	,@Zip=	'84010'	,@AthleticDirector=	'Clark Stringfellow'	;
execute usp_addSchool @SchoolName =	'Box Elder High School'	,@PhoneNumber = 	'4357344840'	,@StreetAddress = 	'380 S 600 W'	,@City = 	'Brigham City'	,@State=	'UT'	,@Zip=	'843022442'	,@AthleticDirector=	'Kim Peterson'	;
execute usp_addSchool @SchoolName =	'Clearfield High School'	,@PhoneNumber = 	'8014028200'	,@StreetAddress = 	'931 S Falcon Drive'	,@City = 	'Clearfield'	,@State=	'UT'	,@Zip=	'84015'	,@AthleticDirector=	'Curtis Hulse'	;
execute usp_addSchool @SchoolName =	'Davis High School'	,@PhoneNumber = 	'8014028800'	,@StreetAddress = 	'325 S Main St'	,@City = 	'Kaysville'	,@State=	'UT'	,@Zip=	'840372598'	,@AthleticDirector=	'Mitch Arquete'	;
execute usp_addSchool @SchoolName =	'Farmington High School'	,@PhoneNumber = 	'8014029050'	,@StreetAddress = 	'548 Glovers Ln'	,@City = 	'Farmington'	,@State=	'UT'	,@Zip=	'840250588'	,@AthleticDirector=	'Kasey Walkenhurst'	;
execute usp_addSchool @SchoolName =	'Fremont High School'	,@PhoneNumber = 	'8014524000'	,@StreetAddress = 	'1900 N 4700 W'	,@City = 	'Ogden'	,@State=	'UT'	,@Zip=	'84404'	,@AthleticDirector=	'Corey Melaney'	;
execute usp_addSchool @SchoolName =	'Layton High School'	,@PhoneNumber = 	'8014024800'	,@StreetAddress = 	'440 Wasatch Dr'	,@City = 	'Layton'	,@State=	'UT'	,@Zip=	'840413272'	,@AthleticDirector=	'Jim Batchelor'	;
execute usp_addSchool @SchoolName =	'Logan High School'	,@PhoneNumber = 	'4357552380'	,@StreetAddress = 	'162 W 100 S'	,@City = 	'Logan'	,@State=	'UT'	,@Zip=	'843215298'	,@AthleticDirector=	'Clair Anderson'	;
execute usp_addSchool @SchoolName =	'Morgan High School'	,@PhoneNumber = 	'8018293418'	,@StreetAddress = 	'55 Trojan Blvd'	,@City = 	'Morgan'	,@State=	'UT'	,@Zip=	'840500917'	,@AthleticDirector=	'Tyrel Mikesell'	;
execute usp_addSchool @SchoolName =	'Mountain Crest High School'	,@PhoneNumber = 	'4357927765'	,@StreetAddress = 	'255 South 800 East'	,@City = 	'Hyrum'	,@State=	'UT'	,@Zip=	'84319'	,@AthleticDirector=	'Kevin Anderson'	;
execute usp_addSchool @SchoolName =	'Northridge High School'	,@PhoneNumber = 	'8014028500'	,@StreetAddress = 	'2430 N Hillfield Rd'	,@City = 	'Layton'	,@State=	'UT'	,@Zip=	'84041'	,@AthleticDirector=	'Jason Duckworth'	;
execute usp_addSchool @SchoolName =	'Roy High School'	,@PhoneNumber = 	'8017744922'	,@StreetAddress = 	'2150 W 4800 S'	,@City = 	'Roy'	,@State=	'UT'	,@Zip=	'840671899'	,@AthleticDirector=	'Mike Puzey'	;
execute usp_addSchool @SchoolName =	'Sky View High School'	,@PhoneNumber = 	'4355636273'	,@StreetAddress = 	'520 S 250 E'	,@City = 	'Smithfield'	,@State=	'UT'	,@Zip=	'843351699'	,@AthleticDirector=	'Ryan Grunig'	;
execute usp_addSchool @SchoolName =	'Syracuse High School'	,@PhoneNumber = 	'8014027900'	,@StreetAddress = 	'665 S 2000 W'	,@City = 	'Syracuse'	,@State=	'UT'	,@Zip=	'84075'	,@AthleticDirector=	'Kelly Anderson'	;
execute usp_addSchool @SchoolName =	'Weber High School'	,@PhoneNumber = 	'8017463700'	,@StreetAddress = 	'3650 N 500 W'	,@City = 	'Ogden'	,@State=	'UT'	,@Zip=	'844141455'	,@AthleticDirector=	'Ted Peterson'	;
execute usp_addSchool @SchoolName =	'Ben Lomond High School'	,@PhoneNumber = 	'8017377965'	,@StreetAddress = 	'800 Scots Ln'	,@City = 	'Ogden'	,@State=	'UT'	,@Zip=	'844045199'	,@AthleticDirector=	'Dirk Barber'	;
execute usp_addSchool @SchoolName =	'Bonneville High School'	,@PhoneNumber = 	'8014524050'	,@StreetAddress = 	'251 E 4800 S'	,@City = 	'Ogden'	,@State=	'UT'	,@Zip=	'844056199'	,@AthleticDirector=	'Lance Minmaugh'	;
execute usp_addSchool @SchoolName =	'Green Canyon High School'	,@PhoneNumber = 	'4357929300'	,@StreetAddress = 	'2960 N Wolfpack Way'	,@City = 	'North Logan'	,@State=	'UT'	,@Zip=	'84341'	,@AthleticDirector=	'Missy Stuart'	;
execute usp_addSchool @SchoolName =	'Ogden High School'	,@PhoneNumber = 	'8017378700'	,@StreetAddress = 	'2828 Harrison Blvd'	,@City = 	'Ogden'	,@State=	'UT'	,@Zip=	'844030398'	,@AthleticDirector=	'Shawn MacQueen'	;
execute usp_addSchool @SchoolName =	'Ridgeline High School'	,@PhoneNumber = 	'4357927780'	,@StreetAddress = 	'180 North 300 West'	,@City = 	'Millville'	,@State=	'UT'	,@Zip=	'84326'	,@AthleticDirector=	'Jim Crosbie'	;
execute usp_addSchool @SchoolName =	'Viewmont High School'	,@PhoneNumber = 	'8014024200'	,@StreetAddress = 	'120 W 1000 N'	,@City = 	'Bountiful'	,@State=	'UT'	,@Zip=	'84010'	,@AthleticDirector=	'Jeff Emery'	;
execute usp_addSchool @SchoolName =	'Woods Cross High School'	,@PhoneNumber = 	'8014024500'	,@StreetAddress = 	'600 W 2200 S'	,@City = 	'Woods Cross'	,@State=	'UT'	,@Zip=	'84087'	,@AthleticDirector=	'Donna Tippetts'	;
go

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------dvs
----------Execute sddSportLevel
-----------------------------------------------------------------------------------------------------------------------------------------------------------

execute usp_addSportLevel @sport = 	'Football'	,@Level= 	'Varsity'	,@pay = 	74.00	;
execute usp_addSportLevel @sport = 	'Football'	,@Level= 	'Junior Varsity'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Football'	,@Level= 	'Sophomore'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Football'	,@Level= 	'Freshman'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Volleyball'	,@Level= 	'Varsity'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Volleyball'	,@Level= 	'Junior Varsity'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Volleyball'	,@Level= 	'Sophomore'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Volleyball'	,@Level= 	'Freshman'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Basketball_Men'	,@Level= 	'Varsity'	,@pay = 	69.00	;
execute usp_addSportLevel @sport = 	'Basketball_Men'	,@Level= 	'Junior Varsity'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Basketball_Men'	,@Level= 	'Sophomore'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Basketball_Men'	,@Level= 	'Freshman'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Basketball_Women'	,@Level= 	'Varsity'	,@pay = 	69.00	;
execute usp_addSportLevel @sport = 	'Basketball_Women'	,@Level= 	'Junior Varsity'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Basketball_Women'	,@Level= 	'Sophomore'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Basketball_Women'	,@Level= 	'Freshman'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Baseball'	,@Level= 	'Varsity'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Baseball'	,@Level= 	'Junior Varsity'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Baseball'	,@Level= 	'Sophomore'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Baseball'	,@Level= 	'Freshman'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Softball'	,@Level= 	'Varsity'	,@pay = 	59.00	;
execute usp_addSportLevel @sport = 	'Softball'	,@Level= 	'Junior Varsity'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Softball'	,@Level= 	'Sophomore'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Softball'	,@Level= 	'Freshman'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Soccer_Men'	,@Level= 	'Varsity'	,@pay = 	69.00	;
execute usp_addSportLevel @sport = 	'Soccer_Men'	,@Level= 	'Junior Varsity'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Soccer_Men'	,@Level= 	'Sophomore'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Soccer_Men'	,@Level= 	'Freshman'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Soccer_Women'	,@Level= 	'Varsity'	,@pay = 	69.00	;
execute usp_addSportLevel @sport = 	'Soccer_Women'	,@Level= 	'Junior Varsity'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Soccer_Women'	,@Level= 	'Sophomore'	,@pay = 	49.00	;
execute usp_addSportLevel @sport = 	'Soccer_Women'	,@Level= 	'Freshman'	,@pay = 	49.00	;
go

-------------------------------------------------------------------------------------------------------------------------------------------------------------
--------Execute addOfficiatingPosition
--------------------------------------------------------------------------------------------------------------------------------------------------------
execute usp_addOfficiatingPosition @PositionName =	'Referee'	;
execute usp_addOfficiatingPosition @PositionName =	'Umpire'	;
execute usp_addOfficiatingPosition @PositionName =	'Head Linesman'	;
execute usp_addOfficiatingPosition @PositionName =	'Line Judge'	;
execute usp_addOfficiatingPosition @PositionName =	'Back Judge'	;
execute usp_addOfficiatingPosition @PositionName =	'Assistant Referee Left'	;
execute usp_addOfficiatingPosition @PositionName =	'Assistant Referee Right'	;
execute usp_addOfficiatingPosition @PositionName =	'Plate Umpire'	;
execute usp_addOfficiatingPosition @PositionName =	'Base Umpire'	;
go


------------------------------------------------------------------------------------------------------------------------------------------------------------
-----Execute add_OfficialQualification
---------------------------------------------------------------------------------------------------------------------------------------------------------
execute usp_addOfficialQualification @emailAddress = 	'ack.devin@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'ack.devin@gmail.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'adambaxter@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'adambaxter@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'adambaxter@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'adambaxter@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'adammarietti@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'alan.hunsaker@hsc.utah.edu'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'andrewunitoa@mail.weber.edu'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'andrewunitoa@mail.weber.edu'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'andrewunitoa@mail.weber.edu'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'andrewunitoa@mail.weber.edu'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'anthonyharris@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'barronhatfield@yahoo.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bga78@msn.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bga78@msn.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bjross33@netzero.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'blainkilburn@yahoo.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bobcarre@live.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bobcarre@live.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bobcarre@live.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'bobcarre@live.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'boomer3685@yahoo.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'braddavies50@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bradpoll@wsd.net'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brandon@petro.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brandon@petro.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brett.ward@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brett.ward@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'brett.ward@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brettdyer@live.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brevindyer29@live.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brfootball67@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'brownfgary@yahoo.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bryanburningham@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bryanburningham@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bryanburningham@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'bryanburningham@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'burnettdan@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'burnettdan@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'burnettdan@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'burnettdan@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'bwj9999@hotmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cactuscutler89@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'calvinking@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'carsonharry@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cartercarl_358@hotmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cartercarl_358@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cartercarl_358@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'cartercarl_358@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'caseyjack@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cgermany@comcast.net'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'chad.richins@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'clifflaw99@yahoo.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'connor.hoopes@aggiemail.usu.edu'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'corey.williams93@hotmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'corey.williams93@hotmail.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'coreylayton98@hotmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'coreylayton98@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'coreylayton98@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'coreylayton98@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'craig.larsen@usu.edu'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cveibell@netzero.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cveibell@netzero.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'cveibell@netzero.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'cveibell@netzero.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'danielrudolph@hotmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'danielrudolph@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'danielrudolph@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'danielrudolph@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'dannyghansen@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'dannywallace@wsd.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'dannywallace@wsd.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'dannywallace@wsd.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'darrintreegold@yahoo.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'david.dickson@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'david.hansen0000@hotmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'davidbueller@yahoo.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'davidwarren22@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'davidwarren22@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'ddmartin2020@msn.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'dennish@msn.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'devindom@msn.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'dfc99@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'dfc99@yahoo.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'dfc99@yahoo.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'dfc99@yahoo.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'evandavis@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'football98@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'football98@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'football98@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'football98@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'francis.morgan@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'francis.morgan@gmail.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'freddenucci@comcast.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'galbraith98@comcast.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'gangwerroger@aol.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'gardner1@comcast.net'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'gardner1@comcast.net'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'garrett.horsley@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'georgeeverett@hotmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'graycurtis39@aol.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'grukmuk@msn.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'grukmuk@msn.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'heyvern@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'hill_dennis@outlook.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jacksonthomas@yahoo.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jason.younger@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jason.younger@gmail.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeff.jackson1@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeff.wall76@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeff.wall76@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeff.wall76@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'jeff.wall76@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeffbraun8@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeffdowns@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeffrey.hoskins@hotmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jeremywoverton1@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'john.eliason@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'johnhancock@yahoo.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'johnmpage@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'johnqnelson@dsdmail.net'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jon34131.jc@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jon34131.jc@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jon34131.jc@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'jon34131.jc@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jonathankilburn@aol.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'jonathanquist@aerotechmfg.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'joshuapeterson@live.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kamburny@mstar.net'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kamburny@mstar.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kamburny@mstar.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'kamburny@mstar.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'karl.robinson56@yahoo.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'karlbeckstrom@msn.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'karlbeckstrom@msn.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'karlbeckstrom@msn.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kconnersUtah@comcast.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kdwilliams@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kdwilliams@gmail.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'keith.hales@yahoo.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kevin.norman@aggiemail.usu.edu'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kevin.tracy@yahoo.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kevinc987@yahoo.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kevindyer36@digis.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kfh@comcast.net'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kirk.osborne.ko@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'konnorcullimore@live.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'kraigculli@hotmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'KyleMitchell1990@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'larryhill@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'larryjensen@syracuseut.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'lbirdland@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'ldjbon@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'lester.walker@yahoo.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'lester.walker@yahoo.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'lester.walker@yahoo.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'lester.walker@yahoo.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'lesterpetersen1@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'marcus.federer@yahoo.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'marcusmaxey@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mariofurm@comcast.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mark.mills94@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mark.welch90@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mark.welch90@gmail.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'markhaney@hotmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'markschofield34@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'marvdeyoung@outlook.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mathew.willey@hotmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mathew.willey@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'matt.troy@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'matt.tucker9@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'matt_elkins@msn.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mattjones@gpi.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mdavis345@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'meffmckenney12@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'micah.w@aggiemail.usu.edu'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'micah.w@aggiemail.usu.edu'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'michaelengledow@comcast.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mikeb@aspen.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mikeb@aspen.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mikeb@aspen.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'mitch.reimer@comcast.net'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'msmcd9853@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'nickcole@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'nickcole@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'nickcole@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'nickcole@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'normanplaizier@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'ottleybradley@msn.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'pagejerod1976@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'paul.bernier@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'paul.bernier@gmail.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'paulleonard234@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'peterson98657@comcast.net'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'pilewicz.marvin@hotmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randall.crowell@autoliv.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randell.waddington@aggiemail.usu.edu'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randell.waddington@aggiemail.usu.edu'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randell.waddington@aggiemail.usu.edu'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'randell.waddington@aggiemail.usu.edu'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randy.shapiro@gmail.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randy_leetham@keybank.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randy_leetham@keybank.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'randy_leetham@keybank.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'randy_leetham@keybank.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'refchrisadams@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'refchrisadams@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'refwalter@yahoo.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'reidcarlos23@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'richjeff@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'Robinson.David@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'rogtaylor@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'rogtaylor@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'rogtaylor@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'rogtaylor@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'ronaldkennedy1@yahoo.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'ronbrenk@q.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'sadlerterrance@msn.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'sampeisley@comcast.net'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'schryversteve@live.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'scott.riley88@gmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'scottjohnson0909@hotmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'shadley@juno.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'shadley@juno.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'shadley@juno.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'shadley@juno.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'shawnf@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'shawnf@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'Sheldonb@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'Sheldonb@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'Sheldonb@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'Sheldonb@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'sking@munnsmfg.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'sportsref20@yahoo.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'steven.farnsworth@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'stevenkibler@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tannerthursday@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'terryjensen209@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'thadporter@yahoo.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'thomas.evans49@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'thomascnoker@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'thomashellstrom@wsd.net'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tom@relaianet.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tom@relaianet.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tom@relaianet.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tom@relaianet.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'tom@relaianet.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tomdeelstra@utah.gov'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tomgriff@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tomgriff@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tomgriff@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'tomgriff@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tommytaylor88@hotmail.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tommytaylor88@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tommytaylor88@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'tommytaylor88@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'trevorcondie@comcast.net'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'trevorcondie@comcast.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'trevorcondie@comcast.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'trevorcondie@comcast.net'	 , @PositionName = 	'Umpire'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'trevorking@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'trueandtrue@gmail.com'	 , @PositionName = 	'Back Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'twood9020@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'twood9020@gmail.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'twood9020@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'twood9020@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'twood9020@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tybar14@hotmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tybar14@hotmail.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tybar14@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'tylerrasmussen@msn.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'vshurtliff909@gmail.com'	 , @PositionName = 	'Assistant Referee Right'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'wallingtonscott@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'wallingtonscott@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'wallingtonscott@hotmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'wcole@gmail.com'	 , @PositionName = 	'Line Judge'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'wcole@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Junior Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'wcole@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Sophomore'	;
execute usp_addOfficialQualification @emailAddress = 	'wcole@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Volleyball'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'winter.andrew35@gmail.com'	 , @PositionName = 	'Umpire'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'winter.andrew35@gmail.com'	 , @PositionName = 	'Referee'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'zachwinter23@msn.com'	 , @PositionName = 	'Head Linesman'	 , @Sport =	'Football'	 ,@Level = 	'Varsity'	;
execute usp_addOfficialQualification @emailAddress = 	'zachwinter23@msn.com'	 , @PositionName = 	'Assistant Referee Left'	 , @Sport =	'Soccer_Women'	 ,@Level = 	'Varsity'	;
go
--------------------------------------------------------------------------------------------------------------------------------------------------
----Execute addGames 
-------------------------------------------------------------------------------------------------------------------------------------------------
execute usp_addGame  @GameDateTime =	'Aug 27 2021 7:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Aug 27 2021 7:00 PM'	,@GameSIte =	'Fremont High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Fremont High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Aug 27 2021 7:00 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Aug 27 2021 7:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 6:00 PM'	,@GameSIte =	'Morgan High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Morgan High School'	,@AwayTeam =	'Bountiful High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 6:00 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 6:00 PM'	,@GameSIte =	'Farmington High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Farmington High School'	,@AwayTeam =	'Logan High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 6:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 4:45 PM'	,@GameSIte =	'Morgan High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Morgan High School'	,@AwayTeam =	'Bountiful High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 4:45 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 4:45 PM'	,@GameSIte =	'Farmington High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Farmington High School'	,@AwayTeam =	'Logan High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 4:45 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:30 PM'	,@GameSIte =	'Morgan High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Morgan High School'	,@AwayTeam =	'Bountiful High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:30 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:30 PM'	,@GameSIte =	'Farmington High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Farmington High School'	,@AwayTeam =	'Logan High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:30 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Farmington High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Farmington High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Bonneville High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Morgan High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Ridgeline High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Ridgeline High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Sep 3 2021 7:00 PM'	,@GameSIte =	'Bonneville High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bonneville High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Viewmont High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Viewmont High School'	,@AwayTeam =	'Bonneville High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Farmington High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Farmington High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Ridgeline High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Bountiful High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bountiful High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Sep 10 2021 7:00 PM'	,@GameSIte =	'Logan High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Logan High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Clearfield High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Fremont High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Fremont High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Bonneville High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bonneville High School'	,@AwayTeam =	'Bountiful High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Box Elder High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Box Elder High School'	,@AwayTeam =	'Viewmont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Farmington High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Farmington High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Green Canyon High School'	;
execute usp_addGame  @GameDateTime =	'Sep 17 2021 7:00 PM'	,@GameSIte =	'Logan High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Logan High School'	,@AwayTeam =	'Bear River High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Bonneville High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bonneville High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Bountiful High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bountiful High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Green Canyon High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Ridgeline High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Ridgeline High School'	,@AwayTeam =	'Logan High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 24 2021 7:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Football'	,@Level =	'Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 6:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 6:00 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 6:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 6:00 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 6:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 4:45 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 4:45 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 4:45 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 4:45 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 4:45 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:30 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:30 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:30 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:30 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:30 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 4:45 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 4:45 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 4:45 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 4:45 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 2 2021 6:00 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 6:00 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 6:00 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 6:00 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 6:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 4:45 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 4:45 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 4:45 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 4:45 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 3:30 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 3:30 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 3:30 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 9 2021 3:30 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 6:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 6:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 6:00 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 6:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 6:00 PM'	,@GameSIte =	'Logan High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Logan High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 4:45 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 4:45 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 4:45 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 4:45 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 4:45 PM'	,@GameSIte =	'Logan High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Logan High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 3:30 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 3:30 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 3:30 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 3:30 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 14 2021 3:30 PM'	,@GameSIte =	'Logan High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Logan High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 6:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 6:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 6:00 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 6:00 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 6:00 PM'	,@GameSIte =	'Bonneville High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Bonneville High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 6:00 PM'	,@GameSIte =	'Ridgeline High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Ridgeline High School'	,@AwayTeam =	'Bear River High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 6:00 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 4:45 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 4:45 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 4:45 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 4:45 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 4:45 PM'	,@GameSIte =	'Bonneville High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Bonneville High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 4:45 PM'	,@GameSIte =	'Ridgeline High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Ridgeline High School'	,@AwayTeam =	'Bear River High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 4:45 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 3:30 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 3:30 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 3:30 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 3:30 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 3:30 PM'	,@GameSIte =	'Bonneville High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Bonneville High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 3:30 PM'	,@GameSIte =	'Ridgeline High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Ridgeline High School'	,@AwayTeam =	'Bear River High School'	;
execute usp_addGame  @GameDateTime =	'Sep 16 2021 3:30 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 6:00 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 6:00 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 6:00 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 6:00 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 6:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 4:45 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 4:45 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 4:45 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 4:45 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 4:45 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 3:30 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 3:30 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Fremont High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 3:30 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 3:30 PM'	,@GameSIte =	'Green Canyon High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Green Canyon High School'	,@AwayTeam =	'Mountain Crest High School'	;
execute usp_addGame  @GameDateTime =	'Sep 21 2021 3:30 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Sky View High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 6:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 6:00 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 6:00 PM'	,@GameSIte =	'Box Elder High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Box Elder High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 6:00 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Logan High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 6:00 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Ridgeline High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 4:45 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 4:45 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 4:45 PM'	,@GameSIte =	'Box Elder High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Box Elder High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 4:45 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Logan High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 4:45 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Junior Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Ridgeline High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 3:30 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 3:30 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 3:30 PM'	,@GameSIte =	'Box Elder High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Box Elder High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 3:30 PM'	,@GameSIte =	'Mountain Crest High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Mountain Crest High School'	,@AwayTeam =	'Logan High School'	;
execute usp_addGame  @GameDateTime =	'Sep 23 2021 3:30 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Volleyball'	,@Level =	'Sophomore'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Ridgeline High School'	;
execute usp_addGame  @GameDateTime =	'Aug 24 2021 3:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Aug 24 2021 3:00 PM'	,@GameSIte =	'Davis High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Davis High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Aug 24 2021 3:00 PM'	,@GameSIte =	'Farmington High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Farmington High School'	,@AwayTeam =	'Viewmont High School'	;
execute usp_addGame  @GameDateTime =	'Aug 24 2021 3:00 PM'	,@GameSIte =	'Fremont High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Fremont High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Aug 24 2021 3:00 PM'	,@GameSIte =	'Woods Cross High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Woods Cross High School'	,@AwayTeam =	'Bonneville High School'	;
execute usp_addGame  @GameDateTime =	'Aug 24 2021 3:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Aug 24 2021 3:00 PM'	,@GameSIte =	'Bountiful High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Bountiful High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:00 PM'	,@GameSIte =	'Box Elder High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Box Elder High School'	,@AwayTeam =	'Woods Cross High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:00 PM'	,@GameSIte =	'Fremont High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Fremont High School'	,@AwayTeam =	'Clearfield High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:00 PM'	,@GameSIte =	'Weber High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Weber High School'	,@AwayTeam =	'Northridge High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:00 PM'	,@GameSIte =	'Syracuse High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Syracuse High School'	,@AwayTeam =	'Roy High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:00 PM'	,@GameSIte =	'Bountiful High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Bountiful High School'	,@AwayTeam =	'Viewmont High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:00 PM'	,@GameSIte =	'Bonneville High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Bonneville High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Aug 26 2021 3:00 PM'	,@GameSIte =	'Layton High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Layton High School'	,@AwayTeam =	'Davis High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Viewmont High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Viewmont High School'	,@AwayTeam =	'Box Elder High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Clearfield High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Clearfield High School'	,@AwayTeam =	'Layton High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Woods Cross High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Woods Cross High School'	,@AwayTeam =	'Farmington High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Roy High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Roy High School'	,@AwayTeam =	'Weber High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Bountiful High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Bountiful High School'	,@AwayTeam =	'Bonneville High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Northridge High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Northridge High School'	,@AwayTeam =	'Syracuse High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Bear River High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Bear River High School'	,@AwayTeam =	'Ridgeline High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Sky View High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Sky View High School'	,@AwayTeam =	'Green Canyon High School'	;
execute usp_addGame  @GameDateTime =	'Aug 31 2021 3:00 PM'	,@GameSIte =	'Logan High School'	,@Sport =	'Soccer_Women'	,@Level =	'Varsity'	,@HomeTeam =	'Logan High School'	,@AwayTeam =	'Mountain Crest High School'	;

go
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------Execute addGameOfficials
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'lbirdland@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'marvdeyoung@outlook.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'john.eliason@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'shawnf@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'francis.morgan@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'gardner1@comcast.net'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'david.hansen0000@hotmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'dennish@msn.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'jeff.jackson1@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'jacksonthomas@yahoo.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'darrintreegold@yahoo.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'tannerthursday@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'matt.troy@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kevin.tracy@yahoo.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'matt.tucker9@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'trueandtrue@gmail.com'	,@GameDateTime=	'Aug 27 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Morgan High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Morgan High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Aug 26 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Morgan High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Morgan High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Aug 26 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Morgan High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Morgan High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'davidwarren22@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'micah.w@aggiemail.usu.edu'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'mark.welch90@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'mathew.willey@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'corey.williams93@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'kdwilliams@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'winter.andrew35@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'zachwinter23@msn.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'jason.younger@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'ack.devin@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'refchrisadams@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'bga78@msn.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'grukmuk@msn.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'brandon@petro.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tybar14@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'karlbeckstrom@msn.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'mikeb@aspen.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'paul.bernier@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'ldjbon@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'jeffbraun8@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'ronbrenk@q.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'brownfgary@yahoo.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'davidbueller@yahoo.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'burnettdan@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bryanburningham@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kamburny@mstar.net'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'cartercarl_358@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'bobcarre@live.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'dfc99@yahoo.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'wcole@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'trevorcondie@comcast.net'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'kconnersUtah@comcast.net'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randall.crowell@autoliv.net'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kevinc987@yahoo.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'kraigculli@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'konnorcullimore@live.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'cactuscutler89@yahoo.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'braddavies50@hotmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'evandavis@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'mdavis345@gmail.com'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'tomdeelstra@utah.gov'	,@GameDateTime=	'Sep 3 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'freddenucci@comcast.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'david.dickson@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'devindom@msn.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'jeffdowns@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'brettdyer@live.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'brevindyer29@live.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'kevindyer36@digis.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'sportsref20@yahoo.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'matt_elkins@msn.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'brfootball67@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'michaelengledow@comcast.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'thomas.evans49@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'georgeeverett@hotmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'steven.farnsworth@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'marcus.federer@yahoo.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'mariofurm@comcast.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'galbraith98@comcast.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'gangwerroger@aol.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'cgermany@comcast.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'graycurtis39@aol.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'tomgriff@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'shadley@juno.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'keith.hales@yahoo.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'johnhancock@yahoo.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'markhaney@hotmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'dannyghansen@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'anthonyharris@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'carsonharry@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'barronhatfield@yahoo.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'thomashellstrom@wsd.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'hill_dennis@outlook.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'larryhill@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'connor.hoopes@aggiemail.usu.edu'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'garrett.horsley@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'jeffrey.hoskins@hotmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'heyvern@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'alan.hunsaker@hsc.utah.edu'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kfh@comcast.net'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'caseyjack@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'bwj9999@hotmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'larryjensen@syracuseut.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'terryjensen209@hotmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'scottjohnson0909@hotmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'mattjones@gpi.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'ronaldkennedy1@yahoo.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'stevenkibler@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'blainkilburn@yahoo.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jonathankilburn@aol.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'calvinking@gmail.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'sking@munnsmfg.com'	,@GameDateTime=	'Sep 10 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'trevorking@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'craig.larsen@usu.edu'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'clifflaw99@yahoo.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'paulleonard234@yahoo.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'adammarietti@hotmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'ddmartin2020@msn.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'marcusmaxey@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'msmcd9853@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'meffmckenney12@yahoo.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'mark.mills94@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'KyleMitchell1990@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'johnqnelson@dsdmail.net'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'boomer3685@yahoo.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'thomascnoker@hotmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'kevin.norman@aggiemail.usu.edu'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kirk.osborne.ko@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'ottleybradley@msn.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'jeremywoverton1@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'pagejerod1976@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'johnmpage@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'refwalter@yahoo.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'sampeisley@comcast.net'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'lesterpetersen1@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'peterson98657@comcast.net'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'joshuapeterson@live.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'pilewicz.marvin@hotmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'normanplaizier@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'bradpoll@wsd.net'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'thadporter@yahoo.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'jonathanquist@aerotechmfg.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tylerrasmussen@msn.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'reidcarlos23@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'mitch.reimer@comcast.net'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'richjeff@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'chad.richins@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'scott.riley88@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'Robinson.David@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'karl.robinson56@yahoo.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'bjross33@netzero.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'football98@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'danielrudolph@hotmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'sadlerterrance@msn.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'markschofield34@gmail.com'	,@GameDateTime=	'Sep 17 2021 7:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'lbirdland@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'marvdeyoung@outlook.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'john.eliason@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'shawnf@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'francis.morgan@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'gardner1@comcast.net'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'david.hansen0000@hotmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'dennish@msn.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'jeff.jackson1@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'jacksonthomas@yahoo.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'darrintreegold@yahoo.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'tannerthursday@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'matt.troy@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kevin.tracy@yahoo.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'matt.tucker9@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'trueandtrue@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'kdwilliams@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'winter.andrew35@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'zachwinter23@msn.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'jason.younger@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'ack.devin@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'refchrisadams@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'bga78@msn.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'grukmuk@msn.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'brandon@petro.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tybar14@hotmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'karlbeckstrom@msn.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'mikeb@aspen.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'paul.bernier@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'ldjbon@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'jeffbraun8@gmail.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'ronbrenk@q.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Head Linesman'	;
execute usp_addGameOfficial @emailAddress =	'brownfgary@yahoo.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Line Judge'	;
execute usp_addGameOfficial @emailAddress =	'davidbueller@yahoo.com'	,@GameDateTime=	'Sep 24 2021 7:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Football'	,@Level =	'Varsity'	,@PositionName=	'Back Judge'	;
execute usp_addGameOfficial @emailAddress =	'burnettdan@hotmail.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bryanburningham@hotmail.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kamburny@mstar.net'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cartercarl_358@hotmail.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'bobcarre@live.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dfc99@yahoo.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wcole@gmail.com'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'trevorcondie@comcast.net'	,@GameDateTime=	'Aug 31 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'burnettdan@hotmail.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bryanburningham@hotmail.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kamburny@mstar.net'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cartercarl_358@hotmail.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'bobcarre@live.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dfc99@yahoo.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wcole@gmail.com'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'trevorcondie@comcast.net'	,@GameDateTime=	'Aug 31 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'burnettdan@hotmail.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bryanburningham@hotmail.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kamburny@mstar.net'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cartercarl_358@hotmail.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'bobcarre@live.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dfc99@yahoo.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wcole@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'trevorcondie@comcast.net'	,@GameDateTime=	'Aug 31 2021 3:30 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Sep 2 2021 4:45 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Sep 2 2021 6:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Sep 9 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Sep 9 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'andrewunitoa@mail.weber.edu'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cveibell@netzero.net'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'randell.waddington@aggiemail.usu.edu'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'lester.walker@yahoo.com'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jeff.wall76@gmail.com'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dannywallace@wsd.net'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wallingtonscott@hotmail.com'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'brett.ward@gmail.com'	,@GameDateTime=	'Sep 9 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'burnettdan@hotmail.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bryanburningham@hotmail.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kamburny@mstar.net'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cartercarl_358@hotmail.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'bobcarre@live.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dfc99@yahoo.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wcole@gmail.com'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'trevorcondie@comcast.net'	,@GameDateTime=	'Sep 14 2021 6:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'burnettdan@hotmail.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bryanburningham@hotmail.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kamburny@mstar.net'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cartercarl_358@hotmail.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'bobcarre@live.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dfc99@yahoo.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wcole@gmail.com'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'trevorcondie@comcast.net'	,@GameDateTime=	'Sep 14 2021 4:45 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'burnettdan@hotmail.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bryanburningham@hotmail.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'kamburny@mstar.net'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'cartercarl_358@hotmail.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'bobcarre@live.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'dfc99@yahoo.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'wcole@gmail.com'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'trevorcondie@comcast.net'	,@GameDateTime=	'Sep 14 2021 3:30 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tomgriff@gmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'shadley@juno.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'football98@gmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'danielrudolph@hotmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Sep 16 2021 6:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tomgriff@gmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'shadley@juno.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'football98@gmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'danielrudolph@hotmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Sep 16 2021 4:45 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tomgriff@gmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'shadley@juno.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'football98@gmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'danielrudolph@hotmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Ridgeline High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'jon34131.jc@gmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'nickcole@gmail.com'	,@GameDateTime=	'Sep 16 2021 3:30 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tomgriff@gmail.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'shadley@juno.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 21 2021 6:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tomgriff@gmail.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'shadley@juno.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 21 2021 4:45 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'tomgriff@gmail.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'shadley@juno.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Green Canyon High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 21 2021 3:30 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'football98@gmail.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'danielrudolph@hotmail.com'	,@GameDateTime=	'Sep 23 2021 6:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'football98@gmail.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'danielrudolph@hotmail.com'	,@GameDateTime=	'Sep 23 2021 4:45 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Junior Varsity'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'adambaxter@yahoo.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'Sheldonb@hotmail.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'coreylayton98@hotmail.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy_leetham@keybank.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'rogtaylor@hotmail.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tommytaylor88@hotmail.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Mountain Crest High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'football98@gmail.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'danielrudolph@hotmail.com'	,@GameDateTime=	'Sep 23 2021 3:30 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Volleyball'	,@Level =	'Sophomore'	,@PositionName=	'Umpire'	;
execute usp_addGameOfficial @emailAddress =	'schryversteve@live.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy.shapiro@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'vshurtliff909@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'davidwarren22@hotmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'micah.w@aggiemail.usu.edu'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'mark.welch90@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Davis High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'mathew.willey@hotmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'corey.williams93@hotmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'kdwilliams@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Farmington High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'winter.andrew35@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'zachwinter23@msn.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Woods Cross High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'jason.younger@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Woods Cross High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'ack.devin@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Woods Cross High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'refchrisadams@gmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bga78@msn.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'grukmuk@msn.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'brandon@petro.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'tybar14@hotmail.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'karlbeckstrom@msn.com'	,@GameDateTime=	'Aug 24 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'mikeb@aspen.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'paul.bernier@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'ack.devin@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Box Elder High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'mathew.willey@hotmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'corey.williams93@hotmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'kdwilliams@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Fremont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'schryversteve@live.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy.shapiro@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'vshurtliff909@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Weber High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'davidwarren22@hotmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'micah.w@aggiemail.usu.edu'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'mark.welch90@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Syracuse High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'mathew.willey@hotmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'corey.williams93@hotmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'kdwilliams@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'winter.andrew35@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'zachwinter23@msn.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Bonneville High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'jason.younger@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'ack.devin@gmail.com'	,@GameDateTime=	'Aug 26 2021 3:00 PM'	,@GameSite=	'Layton High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'refchrisadams@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bga78@msn.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'grukmuk@msn.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Viewmont High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'schryversteve@live.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'randy.shapiro@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'vshurtliff909@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Clearfield High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'davidwarren22@hotmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Woods Cross High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'micah.w@aggiemail.usu.edu'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Woods Cross High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'mark.welch90@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Woods Cross High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'mathew.willey@hotmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'corey.williams93@hotmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'kdwilliams@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Roy High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'winter.andrew35@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'zachwinter23@msn.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'twood9020@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Bountiful High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'tom@relaianet.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'jason.younger@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'ack.devin@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Northridge High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'refchrisadams@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'bga78@msn.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'grukmuk@msn.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Bear River High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'tybar14@hotmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'karlbeckstrom@msn.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'mikeb@aspen.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Sky View High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;
execute usp_addGameOfficial @emailAddress =	'shawnf@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Referee'	;
execute usp_addGameOfficial @emailAddress =	'francis.morgan@gmail.com'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Left'	;
execute usp_addGameOfficial @emailAddress =	'gardner1@comcast.net'	,@GameDateTime=	'Aug 31 2021 3:00 PM'	,@GameSite=	'Logan High School'	,@Sport = 	'Soccer_Women'	,@Level =	'Varsity'	,@PositionName=	'Assistant Referee Right'	;

go
---------------------------------------------------------------------------------------------------------------------------------------------------------
--------Select Statments
-------------------------------------------------------------------------------------------------------------------------------------------------
select dbo.udf_getSecurityQuestionID('What was your childhood nickname?');
select dbo.udf_getSecurityQuestionID('What is the middle name of your youngest child?');
select dbo.udf_getSecurityQuestionID('What school did you attend for sixth grade?');
select dbo.udf_getSecurityQuestionID('What was the name of your first stuffed animal?');
select dbo.udf_getSecurityQuestionID('What was the last name of your third grade teacher?');

select dbo.udf_getSiteID('WSU Stewart Stadium');
select dbo.udf_getSiteID('Weber High School');
select dbo.udf_getSiteID('Syracuse High School');
select dbo.udf_getSiteID('Green Canyon High School');
select dbo.udf_getSiteID('Davis High School');


select dbo.udf_getUserID('football98@gmail.com');
select dbo.udf_getUserID('randy.shapiro@gmail.com');
select dbo.udf_getUserID('vshurtliff909@gmail.com');
select dbo.udf_getUserID('karl.robinson56@yahoo.com');
select dbo.udf_getUserID('schryversteve@live.com');

select dbo.udf_getSchoolID('Woods Cross High School');
select dbo.udf_getSchoolID('Ogden High School');
select dbo.udf_getSchoolID('Syracuse High School');
select dbo.udf_getSchoolID('Sky View High School');
select dbo.udf_getSchoolID('Logan High School');

select dbo.udf_getPositionNameID('Referee');
select dbo.udf_getPositionNameID('Line Judge');
select dbo.udf_getPositionNameID('Plate Umpire');
select dbo.udf_getPositionNameID('Umpire');
select dbo.udf_getPositionNameID('Back Judge');


select dbo.udf_getSportLevelID('Soccer_Women','Sophomore' );
select dbo.udf_getSportLevelID('Soccer_Women','Junior Varsity' );
select dbo.udf_getSportLevelID('Soccer_Women','Freshman' );
select dbo.udf_getSportLevelID('Soccer_Men','Sophomore' );
select dbo.udf_getSportLevelID('Soccer_Men','Sophomore' );


select * from gosUser;
select * from gosOfficial;
select * from gosSecurityQuestion;
select * from gosOfficiatingPosition;
select * from gosSchool;
select * from gosSite;
select * from gosSportLevel;
select * from gosOfficialQualification;
select * from gosGame;
select * from gosGameOfficial;

go
