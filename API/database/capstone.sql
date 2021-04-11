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
	CONSTRAINT FK_breweries_users FOREIGN KEY (user_id) REFERENCES users(user_id),
)

CREATE TABLE hours (
	hours_id int IDENTITY (1,1) NOT NULL,
	brewery_id int NOT NULL,
	day_of_week int NOT NULL,
	open_hour int NOT NULL,
	open_minute int NOT NULL,
	open_am_pm nvarchar(2) NOT NULL,
	close_hour int NOT NULL,
	close_minute int NOT NULL,
	close_am_pm nvarchar(2) NOT NULL,
	is_closed bit NOT NULL,
	CONSTRAINT PK_hours_id PRIMARY KEY (hours_id),
	CONSTRAINT FK_hours_breweries FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id),
	CONSTRAINT CHK_day_of_week CHECK (day_of_week > 0 AND day_of_week <= 7),
	CONSTRAINT CHK_open_hours CHECK (open_hour >= 0 AND open_hour <= 12),
	CONSTRAINT CHK_close_hours CHECK (close_hour >= 0 AND close_hour <= 12),
	CONSTRAINT CHK_open_minute CHECK (open_minute >= 0 AND open_minute < 60),
	CONSTRAINT CHK_close_minute CHECK (close_minute >= 0 AND close_minute < 60)
)

CREATE TABLE brewery_images (
	image_id int IDENTITY (1,1),
	brewery_id int NOT NULL,
	image_url nvarchar(200) NOT NULL,
	CONSTRAINT PK_image_id PRIMARY KEY (image_id),
	CONSTRAINT FK_brewery_images_breweries FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id)
)
-- Consider making abv a decimal datatype
CREATE TABLE beers (
	beer_id int IDENTITY (1, 1),
	brewery_id int NOT NULL,
	beer_name nvarchar(100) NOT NULL,
	description nvarchar(1000) NOT NULL,
	image_url nvarchar(200) NOT NULL,
	abv nvarchar(5) NOT NULL,
	beer_type nvarchar(50) NOT NULL,
	is_active bit NOT NULL
	CONSTRAINT PK_beer_id PRIMARY KEY (beer_id),
	CONSTRAINT FK_beers_breweries FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id)
)

--populate default data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');


GO


