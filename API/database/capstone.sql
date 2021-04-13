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
--INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
--VALUES (1, 'Fleeb Juice', 'Fleeb Juice is a hazy, soft, and juicy IPA carefully
--crafted to exhibit notes of bright papaya, stone fruit, and mango.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618328482/wm9iiblo2ml9esv65a1j.jpg',
--'FLJ','IPA','1')


)

CREATE TABLE reviews (
	beer_review_id int IDENTITY (1, 1),
	beer_id int NOT NULL,
	user_id int NOT NULL,
	rating int NOT NULL,
	review_title nvarchar(100) NOT NULL,
	review_body nvarchar(1000) NOT NULL,
	date_of_review datetime NOT NULL,
	CONSTRAINT PK_beer_review_id PRIMARY KEY (beer_review_id),
	CONSTRAINT FK_reviews_beers FOREIGN KEY (beer_id) REFERENCES beers(beer_id),
	CONSTRAINT FK_reviews_users FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT CHK_rating CHECK (rating >= 1 AND rating <= 5)
)

CREATE TABLE brewery_events (
	brewery_event_id int IDENTITY (1, 1),
	brewery_id int NOT NULL,
	title nvarchar(200) NOT NULL,
	description nvarchar(2000) NOT NULL,
	date_and_time datetime NOT NULL,
	CONSTRAINT PK_brewery_event_id PRIMARY KEY (brewery_event_id),
	CONSTRAINT FK_events_breweries FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id)
)

--populate default data

--user data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Masthead_Brewing_Co.','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Southern_Tier_Brewing_Cleveland','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Forest_City_Brewery','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Platform_Beer_Co','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Noble_Beast_Brewing_Co','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Bookhouse_Brewing','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Market_Garden_Brewing','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Saucy_Brew_Works','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Terrestrial_Brewing_Company','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Brick_And_Barrel','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Collision_Bend_Brewing_Company','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Hansa_Brewery','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');

--Demo Great Lakes User Data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Great_Lakes_Brewing_Company','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');




--breweries data
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('3','Masthead Brewing Co.', 'Expansive brewery & taproom pouring American & Belgian beer paired with wood-fired pizza.', '1261 Superior Ave', '216-206-6176', 'Cleveland', '44114', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('4','Southern Tier Brewery', 'Exploration is the line from local beer maker to World-Class Brewer.', '811 Prospect Ave E,', '440-484-4045', 'Cleveland', '44115', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('5','Forest City Brewery', 'Great atmosphere. Off the beaten path.Feels like a hidden treasure', ' 2135 Columbus Rd, Cleveland', '2162289116', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('6','Platform Beer Co.', 'Opened in 2014, this 100+ seat tasting room and patio offers 20+ house beers and food options. ', '4125 Lorain Ave', '216-202-1386', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('7','Noble Beast Brewing Co', 'Lively taproom for house-brewed beers & elevated bar snacks, sandwiches and salads.', '1470 Lakeside Ave E', '216-417-8588', 'Cleveland', '44114', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('8','Bookhouse Brewing', 'Bookhouse Brewing focuses on making understated, slightly different beers and ciders, served in a
cozy, welcoming atmosphere.', '1526 W 25th St', '216-862-4048', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('9','Market Garden Brewing', 'American gastropub with a patio, house beers, a distillery & a menu of creative sandwiches & tacos.', '1947 W 25th St', '216-621-4000', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('10','Saucy Brew Works', 'Two-tiered brewery offering housemade European-style beer & customizable thin-crust pizzas.', '2885 Detroit Ave', '216-666-2568', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('11','Terrestrial Brewing Company', 'Two-tiered brewery offering housemade European-style beer & customizable thin-crust pizzas.', '7524 Father Frascati', '216-465-9999', 'Cleveland', '44102', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('12','Brick And Barrel', 'Taphouse offering house-brewed ales & wine in a cozy space with beer-centric decor.', '1844 Columbus Rd', '216-331-3308', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('13','Collision Bend Brewing Company', 'Fashionable waterfront brewery & taproom for house-brewed beers & New American small plates.', '1250 Old River Rd', '216-273-7879', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('14','Hansa Brewery', 'Brewery, biergarten & eatery offering German-style beer & European eats in modern digs with a patio.', ' 2717 Lorain Ave', '216-631-6585', 'Cleveland', '44113', 'true');

--Demo Great Lakes Data
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('15','Great Lakes Brewing Company', 'Iconic microbrewery with house suds, an updated American menu, free tours & a patio.', '2516 Market Ave', '216-771-4404', 'Cleveland', '44113', 'true');




--hours data
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '2', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '3', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '4', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '5', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '6', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '7', '11', '30', 'am', '8', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '1', '11', '00', 'am', '8', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '2', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '3', '3', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '4', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '5', '3', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '6', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '7', '11', '00', 'am', '12', '00', 'am','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '2', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '5', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '6', '12', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '7', '12', '00', 'pm', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '1', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '2', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '3', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '4', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '5', '3', '00', 'pm', '2', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '6', '11', '00', 'am', '2', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '7', '11', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '2', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '3', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '4', '11', '30', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '5', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '6', '11', '30', 'am', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '7', '11', '30', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '2', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '5', '3', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '6', '12', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '7', '1', '00', 'pm', '6', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '3', '3', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '4', '3', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '5', '2', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '6', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '7', '11', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '1', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '2', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '3', '11', '00', 'am', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '4', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '5', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '6', '11', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '7', '11', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '1', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '2', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '5', '4', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '6', '10', '00', 'am', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '7', '10', '00', 'am', '10', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '3', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '5', '2', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '6', '12', '00', 'pm', '12', '00', 'am','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '7', '12', '00', 'am', '8', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '3', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '5', '3', '00', 'pm', '9', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '6', '3', '00', 'pm', '11', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '7', '11', '30', 'am', '5', '00', 'pm','1');

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '3', '12', '00', 'pm', '8', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '4', '12', '00', 'pm', '8', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '5', '12', '00', 'pm', '9', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '6', '12', '00', 'pm', '9', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '7', '0', '0', '0', '0', '0', '0','0');


--Demo Great Lakes Hours
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '1', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '2', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '3', '0', '0', '0', '0', '0', '0','0');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '4', '4', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '5', '12', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '6', '12', '00', 'pm', '10', '00', 'pm','1');
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '7', '12', '00', 'pm', '6', '00', 'pm','1');


--brewery images data
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (1, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618175380/jphovma3jurugvtnhxul.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (1, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618175377/mirjlbykemkvjgabkfuy.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (1, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181008/rltilfui6kcaco6fm2yx.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (2, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181372/slhiog2l8ldzu0cwrbbg.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (2, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181379/nle8fimghyz05muqenms.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (2, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181476/rmdfq9apm8j7lu2thdf3.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (3, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181822/mdrypkcwnarqgg6mstx5.png');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (3, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181826/xu7uic8wlyt6tlmxfcy3.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (3, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618181831/rf527qomkc70iuzsuzbb.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (4, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182100/yaxe8fqkhgnw4maybn9b.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (4, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182104/nvfoidgezn8odc9mhbki.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (4, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182107/bhzaep1loytmhkrjmuvx.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (5, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182476/flmd2iwx1aovcxlp2pe5.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (5, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182479/urelulfllknebmb6y0gn.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (5, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182483/meecslltpfkxdcbhtcrp.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (6, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182718/epudo5agw7rnmuxdjmll.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (6, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182721/xi4oddx6fyqtlyfb8jjx.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (6, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618182726/ue85dfrrvzd4xyf6ptwr.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (7, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183090/waycotlsfd3jvsqys8ww.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (7, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183093/ph8n4pdgtwgnkmz7pml3.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (7, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183097/uzfbd0itxytzvrpch7xp.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (8, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183630/ddcd8rpilegnynphffrb.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (8, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183633/hxbkhcdsduzltt4fz7lx.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (8, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618183637/q8thzmg38jyo5srsdyhm.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (9, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618184759/foyw5jkzwvtv7jbgqjrq.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (9, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618184763/benflhsl3lnu7bod2bbk.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (9, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618184766/zq7ztnxbn5phrduoq3vv.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (10, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185425/cmm1joj93xsjttnlzyin.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (10, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185429/hobizh0gal8bpztf5dtg.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (10, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185433/crhpn4jwlvuzqci7hlkn.jpg');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (11, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185651/xifrglvr4wl2j4wvnzgp.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (11, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185654/cg6mto3x25p5nq01ptuw.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (11, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185665/srwhpii3oqvnogaaq1x4.png');

INSERT INTO brewery_images (brewery_id, image_url)
VALUES (12, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185917/khdf2nlqeidqransbpdt.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (12, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185921/kll3kbycfgbdrzpdlvl8.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (12, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618185983/hoj9erozy2ci1urt3mdh.jpg');

--Demo Great Lakes Images
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (13, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618327191/wdcyxawpocwhtsizbpzt.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (13, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618327187/esbjlqbstpwrpz27tfyh.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (13, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618327195/ak32dt3bffxdjwou4tkg.jpg');
INSERT INTO brewery_images (brewery_id, image_url)
VALUES (13, 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618327681/vyhkiyetuu9mbn4gnptd.jpg');


--beer images data
INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (1, 'Fleeb Juice', 'Fleeb Juice is a hazy, soft, and juicy IPA carefully
crafted to exhibit notes of bright papaya, stone fruit, and mango.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618328482/wm9iiblo2ml9esv65a1j.jpg',
'8','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (2, 'Nitro Coconut Truffle', 'This imperial milk stout has a slightly sweet,
nutty aroma of coconut that balances rich and roasty notes of chocolate .', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618329533/zluphr7pvmx4569d22lg.jpg',
'10','Stout','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (3, 'Kurbisleichen Pumpkin Ale', 'The perfect autumn beer! 
A full bodied seasonal brew with pumpkin sweetness and aromatic notes of allspice, nutmeg, ginger and cloves', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618330056/h0woyunx0ptb9sxtdhvr.jpg',
'8.2','Ale','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (4, 'Ohio Is For Lovers', 'This beer was dry-hopped with Fresh Wet Cashmere and Nugget from Spearhead hop farms', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618330629/hpj2loma40sbgm1b3r2g.jpg',
'6.8','Ale','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (5, 'Dawn of Ostara', 'Hopped exclusively with the PB blend for big orange creamsicle and mango! ', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618331242/pguwytmevatjkf65xzvl.jpg',
'6.4','Ale','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (6, 'Galactic Whoopsie', 'Big malt flavors and depth, with a touch of bitterness and maple syrup fullness! ', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618331554/nomdovd6tob8klrnbjcz.jpg',
'7.1','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (7, 'Frosty Tangerline Lime Wit', 'Aged in Tequila Barrels and brewed with spicy Belgian yeast that plays with the limes', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618331688/qbzwasrg7pwla1dfkzi3.png',
'5.5','Wheat Beer','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (8, 'Juicy Asap', 'Tropical, citrusy, and most certainly juicy.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618332498/xpndjzhdomvt7albz013.webp',
'6.5','Pale Ale','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (9, 'Citivopapotomus ', 'Brewed with the same base malt bill of wheat and pilsner malt as its sibling Citropapotomus,
but with a hippo sized dose of new bling bling Citiva hops.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618332880/rmb531pmwabovyx4ezzw.jpg',
'6.6','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (10, 'Bitter Chief IPA', 'Nice bitterness with refreshing citrus and grassy flavors and aromas. Malty finish balancing out the bitterness.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618333114/e6h64ee1fa9cu7zuw0g5.jpg',
'6.9','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (11, 'C-Town', ' American style beer brewed by Collision Bend Brewing Company in Cleveland', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618333549/chmf0oct2vbpzf7oxard.jpg',
'6.7','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (12, 'J.U.G', 'Hefeweizen yeast lends a hint of banana and clove with soft wheat graininess.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618334049/amvthojxj50uyt8ijn6e.jpg',
'4.5','Wheat Beer','1');


--Demo Great Lakes Beers
INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Dortmunder Gold Lager', 'A humble hometown hero, draped in a people-pleasing blend of smooth malt and crisp hop flavors.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618334881/cndbugjbxsaruazpgufb.jpg',
'5.8','Lager','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Elliot Ness', 'Almost untouchably smooth--armed with lightly toasted malts and noble hops.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618334756/iokowwlcblgkxn7sd4dp.jpg',
'6.1',' Amber Lager','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Burning River', 'Crisp and bright, with refreshing flickers of citrus and pine that ignite the senses (not our local waterways).', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618335049/dhqqfqyqtzqmhzeamn3r.jpg',
'6','Pale Ale','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Great Lakes IPA', 'Hike, bike, sail, or laze your way through a dry-hopped,
easy-drinking American IPA that’s perfectly suited for wherever the trail takes you.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618335186/yido7cntnmeqxpwe8apn.jpg',
'6.5','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Comodore Perry', 'Victoriously hopped, with an arsenal of caramel malt flavors befitting the “Hero of Lake Erie.”', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618335456/gu8aplalwajw8tnyjunn.jpg',
'7.7','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Edmund Fitzgerald', 'Brewed in memory of the sunken freighter, with rich roasted barley and bittersweet chocolate-coffee notes.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618338865/ndt9dxhirvbm6ztpy9ui.jpg',
'6','Porter','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Hazecraft', 'Blast into orbit through a hazy galaxy of otherworldly tropical fruit aromas', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618339328/ne7hcittpskpcrhqvcu7.jpg',
'6.7','IPA','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Crushworthy', 'Do you believe in love at first sip? With a lightly filtered body and a sweet kiss of orange, it is more than a crush. It is your new main squeeze.
', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618339515/bpthdifiddduty491pdt.jpg',
'4','Citrus Wheat','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Conway Irish Ale', 'Stationed at the intersection of sweet and toasty, 
where biscuit and caramel malt flavors always have the right-of-way.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618339869/xmpyx3enlmalg8exqbxs.jpg',
'6.3','Ale','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Bierwolf', 'Claw through a feral fusion of cold brew, chocolate, banana, and spice', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618340126/myvsvpsme40lohlnllcp.jpg',
'6.6','Hybrid','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Mexican Lager With Lime', 'Spread a blanket and luxuriate in sunny rays of zesty lime and crisp, clean malt flavors.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618340861/qeyu0vbyxj4uw6cgxzjl.png',
'5.4','Lager','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Chillwave', 'Glide across waves of tropical Mosaic hops and sweet honey malt.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618341004/f7kw5civmnocjqrscnrf.jpg',
'9','IPA','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Rally Drum Premium Lager', 'An all-star roster of malt and hops swings for the fences and slides into a crisp,
clean finish in this classic American Lager.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618341130/npqmiqr8shlv05asarkx.jpg',
'4.2','Lager','1');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Lemon Hefeweizen', 'Fresh and zestful as boardwalk lemonade, with a clean, effervescent body that travels light.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618341291/swfqzfmgj1t6lblkjmw0.jpg',
'5.1','Ale','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Lake Erie Monster Imperial IPA', 'Face your fears with a full-bodied hop behemoth', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618341531/kerifuhyrai5id1tbujm.jpg',
'9.5','IPA','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Oktoberfest', 'Über smooth with vibrant malt flavors and a festive flourish of noble hops (lederhosen not included).', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618341669/tx2gwbqdvnncfph0gqla.png',
'6.5','Lager','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, '73 Kolsch', 'Reliably crisp and smooth, with consecutive snaps of earthy hop aromas and subtle rye bitterness', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618342631/ptupdqvo2xabdgt0r0pu.jpg',
'5.7','Hybrid','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Tidal Fury Imperial Hazy IPA', 'A tempest of tropical fruit aromas rushes from the cloudy depths in this Imperial Hazy IPA,
brewed with an epic blast of Trident™ hops fit for a king.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618342778/dvla6b0gzbguxqyvcjql.jpg',
'8','IPA','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Nosferatu Imperial Red IPA', 'Sink your teeth into rich, roasted malt and a stunning hop bite.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618342962/cz07ph6quzgxre1cy2pa.jpg',
'8','IPA','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Ohio City Oatmeal Stout', 'Oh, what fun it is to ride through a flurry of flaked oats o’er a field of rich roasted malt flavors!', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618343113/fdf1gxhy9ydmjmhv8gzz.jpg',
'5.4','Stout','0');

INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active)
VALUES (13, 'Christmas Ale', 'A holiday classic, fully decked with fresh ginger, cinnamon, and sweet honey.', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618343254/odxp9bxh66serr4c1ns1.png',
'7.5','Ale','0');



















































GO


