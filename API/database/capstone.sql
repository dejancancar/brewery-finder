USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL
	CONSTRAINT PK_user_id PRIMARY KEY (user_id)
	--we changed username to be unique, may be a redundant level of error checking but whatever
)

CREATE TABLE breweries (
	brewery_id int IDENTITY(1,1) NOT NULL,
	user_id int NOT NULL,
	brewery_name nvarchar(100) NOT NULL,
	history nvarchar (2000) NOT NULL,
	street_address nvarchar(400) NOT NULL,
	phone nvarchar(15) NOT NULL,
	city nvarchar(200) NOT NULL,
	zip_code nvarchar (15) NOT NULL,
	is_active bit NOT NULL,
	CONSTRAINT PK_brewery_id PRIMARY KEY (brewery_id),
	CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users(user_id),
)

--CREATE TABLE locations (       this is now part of breweries
	--location_id int IDENTITY(1,1) NOT NULL,
	--brewery_id int NOT NULL,
	--street_address nvarchar(400) NOT NULL,
	--phone nvarchar(15) NOT NULL,
	--city nvarchar(200) NOT NULL,
	--zip_code nvarchar (15) NOT NULL,
	--CONSTRAINT PK_location_id PRIMARY KEY (location_id),
	--CONSTRAINT FK_brewery_id FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id)
--)

CREATE TABLE hours (
	hours_id int IDENTITY (1,1) NOT NULL,
	brewery_id int NOT NULL,
	day_of_week int NOT NULL,
	open_time time NOT NULL,
	close_time time NOT NULL,
	CONSTRAINT PK_hours_id PRIMARY KEY (hours_id),
	CONSTRAINT FK_brewery_id FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id),
	CONSTRAINT CHK_day_of_week CHECK (day_of_week > 0 AND day_of_week < 8),
	--pretty sure time constraint is built in for us?
)

--populate default data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');


GO


