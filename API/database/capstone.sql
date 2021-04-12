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

--INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
--VALUES (3, '1', '0', '0', '0', '0', '0', '0','0');

)

CREATE TABLE brewery_images (
	image_id int IDENTITY (1,1),
	brewery_id int NOT NULL,
	image_url nvarchar(200) NOT NULL,
	CONSTRAINT PK_image_id PRIMARY KEY (image_id),
	CONSTRAINT FK_brewery_images_breweries FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id)
--INSERT INTO brewery images (brewery_id, image_url)
--VALUES (3, '');

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

--user data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Masthead Brewing Co.','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Southern Tier Brewing Cleveland','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Forest City Brewery','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Platform Beer Co','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Noble Beast Brewing Co','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Bookhouse Brewing','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Market Garden Brewing','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Saucy Brew Works','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Terrestrial Brewing Company','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Brick And Barrel','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Collision Bend Brewing Company','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Hansa Brewery','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','user');


--breweries data
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('3','Masthead_Brewing_Co.', 'Expansive brewery & taproom pouring American & Belgian beer paired with wood-fired pizza.', '1261 Superior Ave', '216-206-6176', 'Cleveland', '44114', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('4','Southern_Tier_Brewery', 'Exploration is the line from local beer maker to World-Class Brewer.', '811 Prospect Ave E,', '440-484-4045', 'Cleveland', '44115', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('5','Forest_City_Brewery', 'Great atmosphere. Off the beaten path.Feels like a hidden treasure', ' 2135 Columbus Rd, Cleveland', '2162289116', 'Cleveland', '44113', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('6','Platform_Beer_Co.', 'Opened in 2014, this 100+ seat tasting room and patio offers 20+ house beers and food options. ', '4125 Lorain Ave', '216-202-1386', 'Cleveland', '44113', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('7','Noble_Beast_Brewing_Co', 'Lively taproom for house-brewed beers & elevated bar snacks, sandwiches and salads.', '1470 Lakeside Ave E', '216-417-8588', 'Cleveland', '44114', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('8','Bookhouse_Brewing', 'Bookhouse Brewing focuses on making understated, slightly different beers and ciders, served in a
cozy, welcoming atmosphere.', '1526 W 25th St', '216-862-4048', 'Cleveland', '44113', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('9','Market_Garden_Brewing', 'American gastropub with a patio, house beers, a distillery & a menu of creative sandwiches & tacos.', '1947 W 25th St', '216-621-4000', 'Cleveland', '44113', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('10','Saucy_Brew_Works', 'Two-tiered brewery offering housemade European-style beer & customizable thin-crust pizzas.', '2885 Detroit Ave', '216-666-2568', 'Cleveland', '44113', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('11','Terrestrial_Brewing_Company', 'Two-tiered brewery offering housemade European-style beer & customizable thin-crust pizzas.', '7524 Father Frascati', '216-465-9999', 'Cleveland', '44102', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('12','Brick_And_Barrel', 'Taphouse offering house-brewed ales & wine in a cozy space with beer-centric decor.', '1844 Columbus Rd', '216-331-3308', 'Cleveland', '44113', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('13','Collision_Bend_Brewing_Company', 'Fashionable waterfront brewery & taproom for house-brewed beers & New American small plates.', '1250 Old River Rd', '216-273-7879', 'Cleveland', '44113', 'true');
INSERT INTO breweries (brewery_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('14','Hansa_Brewery', 'Brewery, biergarten & eatery offering German-style beer & European eats in modern digs with a patio.', ' 2717 Lorain Ave', '216-631-6585', 'Cleveland', '44113', 'true');

--hours data
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '2', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '3', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '4', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '5', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '6', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '7', '11', '30', 'am', '8', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '1', '11', '00', 'am', '8', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '2', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '3', '3', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '4', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '5', '3', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '6', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '7', '11', '00', 'am', '12', '00', 'am','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '2', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '5', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '6', '12', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '7', '12', '00', 'pm', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '1', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '2', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '3', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '4', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '5', '3', '00', 'pm', '2', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '6', '11', '00', 'am', '2', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '7', '11', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '2', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '3', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '4', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '5', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '6', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '7', '11', '30', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '2', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '5', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '6', '12', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '7', '1', '00', 'pm', '6', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '3', '3', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '4', '3', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '5', '2', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '6', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '7', '11', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '1', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '2', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '3', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '4', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '5', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '6', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '7', '11', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '1', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '2', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '5', '4', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '6', '10', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '7', '10', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '5', '2', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '6', '12', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '7', '12', '00', 'am', '8', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '3', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '5', '3', '00', 'pm', '9', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '6', '3', '00', 'pm', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '7', '11', '30', 'am', '5', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (14, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (14, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (14, '3', '12', '00', 'pm', '8', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (14, '4', '12', '00', 'pm', '8', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (14, '5', '12', '00', 'pm', '9', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (14, '6', '12', '00', 'pm', '9', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (14, '7', '0', '0', '0', '0', '0', '0','0');


--brewery images data
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (3, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618175380/jphovma3jurugvtnhxul.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (3, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618175377/mirjlbykemkvjgabkfuy.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (3, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181008/rltilfui6kcaco6fm2yx.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (4, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181372/slhiog2l8ldzu0cwrbbg.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (4, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181379/nle8fimghyz05muqenms.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (4, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181476/rmdfq9apm8j7lu2thdf3.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (5, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181822/mdrypkcwnarqgg6mstx5.png');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (5, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181826/xu7uic8wlyt6tlmxfcy3.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (5, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181831/rf527qomkc70iuzsuzbb.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (6, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182100/yaxe8fqkhgnw4maybn9b.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (6, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182104/nvfoidgezn8odc9mhbki.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (6, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182107/bhzaep1loytmhkrjmuvx.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (7, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182476/flmd2iwx1aovcxlp2pe5.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (7, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182479/urelulfllknebmb6y0gn.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (7, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182483/meecslltpfkxdcbhtcrp.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (8, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182718/epudo5agw7rnmuxdjmll.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (8, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182721/xi4oddx6fyqtlyfb8jjx.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (8, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182726/ue85dfrrvzd4xyf6ptwr.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (9, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183090/waycotlsfd3jvsqys8ww.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (9, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183093/ph8n4pdgtwgnkmz7pml3.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (9, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183097/uzfbd0itxytzvrpch7xp.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (10, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183630/ddcd8rpilegnynphffrb.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (10, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183633/hxbkhcdsduzltt4fz7lx.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (10, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183637/q8thzmg38jyo5srsdyhm.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (11, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618184759/foyw5jkzwvtv7jbgqjrq.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (11, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618184763/benflhsl3lnu7bod2bbk.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (11, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618184766/zq7ztnxbn5phrduoq3vv.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (12, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185425/cmm1joj93xsjttnlzyin.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (12, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185429/hobizh0gal8bpztf5dtg.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (12, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185433/crhpn4jwlvuzqci7hlkn.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (13, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185651/xifrglvr4wl2j4wvnzgp.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (13, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185654/cg6mto3x25p5nq01ptuw.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (13, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185665/srwhpii3oqvnogaaq1x4.png');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (14, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185917/khdf2nlqeidqransbpdt.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (14, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185921/kll3kbycfgbdrzpdlvl8.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (14, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185983/hoj9erozy2ci1urt3mdh.jpg');































GO


