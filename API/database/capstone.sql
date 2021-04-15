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
--crafted to exhibit notes of bright papaya, stone fruit, and mango.', '',
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
--INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
--VALUES ('1', '3', '5', 'Great Beer!', 'Was exactly what I was looking for!', '2020-02-16' 

CREATE TABLE brewery_events (
	brewery_event_id int IDENTITY (1, 1),
	brewery_id int NOT NULL,
	title nvarchar(200) NOT NULL,
	description nvarchar(2000) NOT NULL,
	date_and_time datetime NOT NULL,
	CONSTRAINT PK_brewery_event_id PRIMARY KEY (brewery_event_id),
	CONSTRAINT FK_events_breweries FOREIGN KEY (brewery_id) REFERENCES breweries(brewery_id)
)

CREATE TABLE breweries_users (
brewery_id int NOT NULL,
user_id int NOT NULL,
CONSTRAINT PK_breweries_users_brewery_id_user_id PRIMARY KEY (brewery_id, user_id)
)
--populate default data

--user data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Todd_Z','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Dejan_C','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Bill_M','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Clayton_C','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Masthead_Brewing_Co','Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=','brewer');
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
VALUES ('7','Masthead Brewing Co.', 'Expansive brewery & taproom pouring American & Belgian beer paired with wood-fired pizza.', '1261 Superior Ave', '216-206-6176', 'Cleveland', '44114', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('8','Southern Tier Brewery', 'Exploration is the line from local beer maker to World-Class Brewer.', '811 Prospect Ave E,', '440-484-4045', 'Cleveland', '44115', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('9','Forest City Brewery', 'Great atmosphere. Off the beaten path.Feels like a hidden treasure', ' 2135 Columbus Rd', '216-228-9116', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('10','Platform Beer Co.', 'Opened in 2014, this 100+ seat tasting room and patio offers 20+ house beers and food options. ', '4125 Lorain Ave', '216-202-1386', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('11','Noble Beast Brewing Co', 'Lively taproom for house-brewed beers & elevated bar snacks, sandwiches and salads.', '1470 Lakeside Ave E', '216-417-8588', 'Cleveland', '44114', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('12','Bookhouse Brewing', 'Bookhouse Brewing focuses on making understated, slightly different beers and ciders, served in a
cozy, welcoming atmosphere.', '1526 W 25th St', '216-862-4048', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('13','Market Garden Brewing', 'American gastropub with a patio, house beers, a distillery & a menu of creative sandwiches & tacos.', '1947 W 25th St', '216-621-4000', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('14','Saucy Brew Works', 'Two-tiered brewery offering housemade European-style beer & customizable thin-crust pizzas.', '2885 Detroit Ave', '216-666-2568', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('15','Terrestrial Brewing Company', 'Two-tiered brewery offering housemade European-style beer & customizable thin-crust pizzas.', '7524 Father Frascati', '216-465-9999', 'Cleveland', '44102', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('16','Brick And Barrel', 'Taphouse offering house-brewed ales & wine in a cozy space with beer-centric decor.', '1844 Columbus Rd', '216-331-3308', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('17','Collision Bend Brewing Company', 'Fashionable waterfront brewery & taproom for house-brewed beers & New American small plates.', '1250 Old River Rd', '216-273-7879', 'Cleveland', '44113', 'true');
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('18','Hansa Brewery', 'Brewery, biergarten & eatery offering German-style beer & European eats in modern digs with a patio.', ' 2717 Lorain Ave', '216-631-6585', 'Cleveland', '44113', 'true');

--Demo Great Lakes Data
INSERT INTO breweries (user_id, brewery_name, history, street_address, phone, city, zip_code, is_active)
VALUES ('19','Great Lakes Brewing Company', 'Iconic microbrewery with house suds, an updated American menu, free tours & a patio.', '2516 Market Ave', '216-771-4404', 'Cleveland', '44113', 'true');




--hours data
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '2', '11', '30', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '3', '11', '30', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '4', '11', '30', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '5', '11', '30', 'am', '11', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '6', '11', '30', 'am', '11', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (1, '7', '11', '30', 'am', '8', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '1', '11', '00', 'am', '8', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '2', '11', '00', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '3', '3', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '4', '11', '00', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '5', '3', '00', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '6', '11', '00', 'am', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (2, '7', '11', '00', 'am', '12', '00', 'am', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '2', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '3', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '4', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '5', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '6', '12', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (3, '7', '12', '00', 'pm', '10', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '1', '3', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '2', '3', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '3', '3', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '4', '3', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '5', '3', '00', 'pm', '2', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '6', '11', '00', 'am', '2', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (4, '7', '11', '00', 'am', '10', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '2', '11', '30', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '3', '11', '30', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '4', '11', '30', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '5', '11', '30', 'am', '11', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '6', '11', '30', 'am', '11', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (5, '7', '11', '30', 'am', '10', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '2', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '3', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '4', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '5', '3', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '6', '12', '00', 'am', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (6, '7', '1', '00', 'pm', '6', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '2', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '3', '3', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '4', '3', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '5', '2', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '6', '11', '00', 'am', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (7, '7', '11', '00', 'am', '10', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '1', '11', '00', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '2', '11', '00', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '3', '11', '00', 'am', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '4', '11', '00', 'am', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '5', '11', '00', 'am', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '6', '11', '00', 'am', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (8, '7', '11', '00', 'am', '10', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '1', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '2', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '3', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '4', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '5', '4', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '6', '10', '00', 'am', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (9, '7', '10', '00', 'am', '10', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '2', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '3', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '4', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '5', '2', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '6', '12', '00', 'pm', '12', '00', 'am', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (10, '7', '12', '00', 'am', '8', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '2', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '3', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '4', '4', '00', 'pm', '10', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '5', '3', '00', 'pm', '9', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '6', '3', '00', 'pm', '11', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (11, '7', '11', '30', 'am', '5', '00', 'pm', 0);

INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '1', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '2', '0', '0', '0', '0', '0', '0', 1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '3', '12', '00', 'pm', '8', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '4', '12', '00', 'pm', '8', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '5', '12', '00', 'pm', '9', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '6', '12', '00', 'pm', '9', '00', 'pm', 0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (12, '7', '0', '0', '0', '0', '0', '0', 1);


--Demo Great Lakes Hours
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '1', '0', '0', '0', '0', '0', '0',1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '2', '0', '0', '0', '0', '0', '0',1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '3', '0', '0', '0', '0', '0', '0',1);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '4', '4', '00', 'pm', '10', '00', 'pm',0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '5', '12', '00', 'pm', '10', '00', 'pm',0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '6', '12', '00', 'pm', '10', '00', 'pm',0);
INSERT INTO hours (brewery_id, day_of_week, open_hour, open_minute, open_am_pm, close_hour, close_minute, close_am_pm, is_closed)
VALUES (13, '7', '12', '00', 'pm', '6', '00', 'pm',0);


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
VALUES (13, 'Commodore Perry', 'Victoriously hopped, with an arsenal of caramel malt flavors befitting the “Hero of Lake Erie.”', 'https://res.cloudinary.com/breweryfinderte/image/upload/v1618335456/gu8aplalwajw8tnyjunn.jpg',
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



--breweries review data
INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('1', '3', '5', 'Great Beer!', 'The Papaya and Mango mized very well', '2014-04-14');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('2', '4', '4', 'Awesome Desert Beer!', 'Few brewers do desert beers as well as Southern Tier!', '2019-06-19');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('3', '5', '4', 'Perfect Autumn Beer!', 'The pumpking is subtle and not overpowering at all', '2020-07-14');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('4', '6', '5', 'Finely Crafted!', 'Another Ale that hit its mark, will be going back to try again', '2020-06-25');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('5', '6', '5', 'Now that a Creamsicle', 'Took me back to when I was a kid, only add the beer lol!', '2019-08-03');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('6', '3', '2', 'Not a good touch with the Maple', 'Some thing just were not meant to be mixed', '2021-02-07');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('7', '4', '4', 'Always Consistent', 'Tangerine and Lime is my new go to!', '2020-08-22');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('8', '5', '5', 'Juicy is my new summer drink', 'Perfect for a hot day in June. Wish they could keep it stock longer', '2019-06-15');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('9', '6', '2', 'Not a fan', 'I ususally enjoy a new IPA but this one definitely missed the mark', '2020-04-17');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('10', '3', '4', 'Little bitter but was better than expected', 'Not bad, would gove it another shot in the future', '2020-07-20');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('11', '4', '5', 'Support your local beer', 'We do certain things right here in Cleveland, and beer is one of them!', '2020-11-04');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('12', '5', '4', 'Got a good one here!', 'Did not think that banana and clove would work but they pulled it off here.', '2020-06-20');


--Great Lakes Reviews
INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('13', '6', '5', 'Just picked up some Great Lakes beer this weekend and this was one of them', '
Poured from a 12oz can into a pilsner glass.
One to two-finger head with some lacing left on the glass. Decent cap on the beer.
Color is strong copper hue and translucent.
Aroma is malty and inviting.
Taste is sweet up front followed by some beautiful malti-bready goodness.
Mouthfeel is my favorite part of this beer- While overall subtle in its making, you pick up the slight bite of the hops and tons of smoothness on the back end making it interesting every time you take a drink.
Overall, I am stoked I picked this up for a try and now understand why this beer has been recognized allover the world. There is nothing like a simply-crafted beer that can be interesting and satisfying all the while.
Well Done!', '2021-03-13');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('13', '4', '4', 'The beer is a medium-dark straw but with a lovely big fluffy head', '
It smells malty and of hay and bread with a hops undertone that is similar to petichor in a forest.
On the palate, it is sweet. Somewhere between syrup and pastry sweet.
The hops complement the malt well and give a floral character.
The feel is light bodied but sticky carbonation is good. Overall, a well done and enjoyable beer.', '2020-12-17');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('13', '5', '4', 'A 1+ inch slightly off-white creamy head rising above an up-rushing absolute shower of bubbles', '
The body is golden crystal clear. The head recedes lazily, leaving sheets of lacing.
It is a great looking beer in the footed pilsner glass.
Rich malty aroma, strongly bread with fruit and spice backing.
Taste is bread to the fore, as promised by the aroma. Behind that is an herbal flavor, along with fruit and pepper.
There is little in the way of bittering at the front, a bit sweet initially, and it remains smooth through the middle,
with a tanginess from the hops showing itself. The hoppy tang dries things out a bit by the finish.
The aftertaste is bready, with a nice mouth-coating feel. The finish is sufficiently dryish so as to demand the next drink.I really like the bready aftertaste.
Mouth feel has a moderate body, smooth.Overall, and excellent, refreshing,
and easy drinking lager with just enough complexity to keep it interesting and inviting a second round.', '2020-11-16');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('14', '6', '5', 'The beer is a deep amber and very transparent with a beige head', '
On the nose it a maltiness that isnt exactly sweet. Like some kind of biscotti.
The taste is what one thinks of as "good malt" it may lack distinction but cliches exist for a reason.
It is sweet but has a dry finish. The body is welcomingly good. Overall, good beer.', '2021-03-19');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('14', '3', '3', 'Not a bad beer, just leaves a lot to be desired', 'The smell is pleasant,
but the taste is a little harsh compared to other amber lagers Ive enjoyed.
Would I be able to down a few if they were given to me? Sure, its not unpleasant, but I cant see myself purchasing a six pack of these.
If you get the chance to throw this in a "pick six" pack try it for yourself and see what you think.', '2021-02-21');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('14', '4', '5', 'Best amber ever had for me', 'Very rich with slight heat from alcohol but well hidden.
Caramel and biscuit on the front end and great boozy hint on finish. Well carbonated.', '2021-01-13');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('15', '5', '4', 'Clear, copper-colored body capped with a thick, frothy head', 'Malty nose with some mild fruitiness to the aroma.
Mild roasted grain and caramel flavor; excellent hop bitterness balancing things out.
Medium body; crisp with a gentle sweetness at the finish.
A delightful pale ale, highlighting clean taste with a crisp hop bitterness. Well-balanced and quite drinkable.', '2020-10-13');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('15', '6', '4', 'Pours a cloudy golden color with a very minimal head that soon disappears into nothing', '
Smells of orange, pine, herbal hops
Taste is a creamy herbal hop up front followed by a sweet malt, finishing dry and semi bitter.
Mouthfeel: Moderately thick, this is a creamier pale ale by far
Overall: Excellent, very easy drinking', '2020-08-13');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('15', '3', '4', 'Poured into a Pilsner style glass', '
Look: hazy good like a Wheat beer, surprisingly. White foamy head.
Smell: orange and hops. Not too overpowering but nice enough to remind you its a pale.
Taste: hops are just right with a malty, orangey sweetness that balances beautifully. Great balance.
Mouthfeel: creamier than one would expect from a pale ale, but that has to do with the malt balance.
Another beautiful beer from Great Lakes. These guys really know what theyre doing.', '2020-12-19');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('16', '4', '4', 'Very bold and very citrus', 'This lightly straw colored golden pale ale comes in at 6.5 ABV with over 50 IBU (as printed on the can)
- Best by date (sadly) is 11-29-2020. 2 finger all-white head, a bit soapy in texture.
As far as taste goes youre getting a lot of bright bold citrus resin hops, bit a bread, ale yeast, and a nice balanced malt.
The sweetness in this is 3 as far as sugar cubes, and as expected hoppy.', '2020-12-19');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('16', '5', '4', 'Another good ipa', 'Thinner taste than commodore perry but a good summer drink.
Light color and less % than CPerry too. India pale ale variety.
Highly recommend for taste.', '2020-10-25');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('16', '6', '4', 'Annual trip to GLBC after visiting Isaiah at GJR for the first time', '
IPA was the first to try tonight. Beautiful color. Fruity on the nose. Flavor was fruity balanced with hops nicely at the end! Nice!', '2019-11-19');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('17', '3', '4', 'The beer is a nice goldenrod with a good fizzy head', '
The nose is more muted than expected. The malt is there but the spicy earthy hops take center stage.
Immediately the palate is lit ablaze with bright herbal and a darker base of earthiness.
There is a vegetal characteristic as well as woody one. However, it tastes very clean and almost has a crispness to it.
The malt is sweet and is very harmonious with the hoppy parts. The body is medium with rather good carbonation.
It is a relaxing IPA overall.', '2021-02-16');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('17', '4', '5', 'Do not miss this one', 'Back when BA made everyone choose a favorite style as part of their profile,
I listed English IPA as my favorite. I am not unhappy they dont do that anymore because I like a lot of styles,
and dont like to be stereotyped. However, there is something distinctive about this style when you get a really good example.
This isnt as bitter as most of the IPAs at my local bottle shop but it has such broad and lasting hop flavor,
that the complexity can reach another level, almost like a good porter or stout. The aftertaste and texture here are pitch perfect.
I bet a homesick British sailor in "the colonies" in the 1850s would have been over the moon for a bottle of this.', '2020-11-20');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('17', '5', '4', 'Lightly hazed deep amber appearance', 'A small off white head
and a fair amount of lacing Aroma of herbal hops in front of soft fruit and pine.
Taste pulls together those hop features, tosses in some spiciness, and rests on a solid malt backbone.
Medium-to-full bodied, decently carbonated mouthfeel Some sweetness lingers in the aftertaste.', '2020-09-20');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('18', '6', '4', 'Attractive looking beer', 'Deep brown body, large tan head and very good lacing.
Dark malt aroma, roasty, along side chocolate and chicory. Earthy flavor. Malts have a charred edge.
Semi-sweet chocolate circles back around from the nose. Modestly hopped herbal characteristic in the aftertaste.
Full bodied, lightly carbonated mouthfeel.', '2021-02-21');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('18', '3', '4', 'Dark brown and pours a nice white head', '
smell: milk and grain
taste: Coffee, chocolate, malt, darker fruits
Feel: creamy and silky, light body.
Very high quality session porter. One of the best Ive tried', '2021-01-17');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('18', '4', '4', 'Opaque dark brown color, aroma of anise, chocolate, cinnamon, roasted malt', 'Small brownish head when poured from 12 oz. bottle.
Flavor is like a bitter dark chocolate with a hints of fish and metal. Finish favors the bitter side.
Good body, not over attenuated or over carbonated. While it is an interesting beer, it has some weirdness to it.
Possibly not the best sample, will try it fresh next time I visit OH.', '2021-01-10');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('19', '5', '3', 'They could have done better', 'A couple of 12 oz. cans fit into a clear glass liter mug, since the head,
though tight and durable, didnt overextend its welcome. Its color is a dense and dark orange-amber.
The nose picks up a little hoppiness, but not in abundance and not much more. The glass lacing is minimal.
Theres very little sweetness to the introduction, despite a decent amount of malts to the tongue. Self described as a NEIPA,
thats how it will be rated here. Unlike most in the category, theres very little starchy contributions that compliment or take the edge off a hoppy and relatively high ABV brew.
There is more alcohol in the finish than good NEIPAs that provide more proof than a 6.7% ABV. This is a far better than bad beer.
It took Great Lakes a while to add to the list of hazy beers.', '2020-12-20');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('19', '6', '4', 'Overall it is a good beer', 'I got a 6pck of this beer from my local meijer store.
It poured a hazy orangish with white head that is leaving a nice lace. The scent had fresh tropical fruit notes.
The taste was nicely balanced and easy to drink with fresh tropical fruit presence.
The mouthfeel was lighter in body with good carbonation.', '2020-11-17');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('19', '3', '3', 'Quite drinkable and solid', 'Pours a syrupy orange with very little head and negligible lacing.
Smells of general sweetness, hints of freshly cut melon. Very sharp upon the tongue; most discernible flavors are mango/papaya.
Not much punch to this one, loads of pulp, but minimal complexity.', '2020-09-18');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('20', '4', '5', 'Perfection for the style/intent', '
Pours a beautiful starburst of golden, marmalade, orange with a fairly resilient wheat beer head.
Surprising for its main objective of being a low calorie effort.
Aroma is a marriage of citrus zest and a classic, isoamyl acetate achievement-- again, considering its lightness,
the quality and quantity of peppery/clovey yeast character is rather unbelievable.
Flavor is as advertised from the aroma; leading with a refreshing citrus hit, finishing dry and bright,
and providing a lingering yeast complexity akin to a classic bavarian wheat... 
just slightly and understandably understated given its 105 calorie (per 12oz) designation.
Mouthfeel is super bright and effervescent with the silky benefit of the wheat malt and a clean, dry finish.
Overall, this is an excellent tweener for the shandy/seltzer crowd as well as true craft beer lovers.
Its a practically perfect, three-parted execution of tastiness, lightness, and craftiness all in one can/glass.', '2021-04-02');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('20', '5', '3', 'These would be great on a hot summer day after mowing the lawn', '12 FL. OZ. can
Served in a nonic pint glass
This beer pours pale yellow and is hazy. It is topped with an inch of beige head that leaves spotty lacing.
It has a fresh citrus aroma. The orange and lemon scream summer drink.
The taste is loaded with orange and lemon as well. It is really refreshing.
Lighter bodied with a slightly dry mouthfeel
I will admit the name says it all.', '2021-03-18');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('20', '6', '4', 'Very approachable', 'Straw yellow. Opaque. Moderate carbonation. Glossy surface.
Yeast esters especially a clove phenol. Lemon citrus and orange rind.
Very mellow flavor. A little sweet, some wheat, some barley, some lemon and rind to balance, and some clove on the finish. Awesome.
Crushable--Beer is made for drinking, therefore, drinkability is key. Full of real ingredients. Doesnt contain fermentation aids (corn/rice) or extracts. Im glad that Great Lakes is putting out a good quality light brew.
Cleveland has a high quality water supply to boot.', '2021-02-04');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('21', '3', '3', 'Will probably buy again if it is available', 'Poured from a bottle with an Enjoy By date of 3/31/21 into a pint glass.
Copper color with minimal head and little lacing. A pretty beer but not as red as I would expect.
Not much to say regarding aroma just faint smell of malt and caramel.
Taste is as expected-nice combo of sweet and mild bitters. Mouthfeel is also like "real beer" and a nice change from the populars.
I am a sucker for seasonals so I snatched this up even though it is a little early for Irish.', '2021-01-07');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('21', '4', '3', 'The Good Ol Days', 'The first beer I have had more than one of in 1 sitting was Smithwicks.
I still love it, but Conway’s gives me the same feeling I did about Smithwicks all those years ago', '2020-12-15');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('21', '5', '4', 'Overall, a good refreshing brew', 'Pours a clear, copper color with a tight head that leaves lots of lacing
Smells sweet, malty and fruity
Tastes of caramel, malt and dark fruit. Some bitterness but more malt forward.
Light bodied and refreshing
I will buy again', '2020-12-03');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('22', '6', '3', 'This one missed the mark', 'Appearance – This poured a dull, dingy dark brown with an unimpressive head.
Smell – The harsh coffee grounds are uncharacteristic of the style and the banana promised on the Great Lakes website is absent.
There is some light wheat and some darkish spicing.
Taste – The coffee is again harsh at the taste and the banana a little bigger.
Mouthfeel – This light-bodied dunkles lacks the feathery tingle that one comes to expect from a true German example of the style.
There is also an unflattering bitterness. The high ABV adds to the discomfort of the mouthfeel.
Drinkability – This is not a bad brew but a poor example of the style. I’m a big fan of the brewery,
especially the darker styles like the stouts.', '2021-01-17');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('22', '3', '4', 'Great Balance', 'Dark brown in color, a bit cloudy. Cream colored head that remains as a thing ring.
Aroma of rich pumpernickel bread, a touch of the cocoa and the citrus zest.
Similar flavors, good balance of sweet malt flavors and some earthy herbal dryness. Medium bodied.', '2021-01-03');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('22', '4', '4', 'Tasty and very complex', 'Look - clear dark reddish brown with a very slight head that goes away pretty quick
Smell - banana with a very slight cocoa and orange
Taste - tons of taste! has that transitional banana toasty taste that you get from a dunkelweizen but you get that slight chocolate orange taste like the chocolates with some orange in them. Also very slight cold brew coffee taste.
Feel - Medium body and carbonation
Overall - Interesting different twist on a dunkelweizen.', '2020-12-16');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('23', '5', '3', 'Not quite there', 'Golden with thin white head
smell is yeasty with lime in aroma and mild toasted malt scent
taste and feel are light body with subtle sweetness and citrus in taste tangy and dry in finish with moderate carbonation
this is a decent lager with lime but it does not stand out in the category
aimed more at corona or bud light lime consumers perhaps', '2020-06-12');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('23', '6', '3', 'Goes down easy', 'One of the better mexilagers Ive had.
Pours light gold. Lots of bubbles. Mild aroma. Very good flavor. Strong lime but not overpowering. Great summer brew.', '2020-05-26');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('23', '3', '4', 'This is very well executed and delivers what you would expect', '
The base beer seems like a better than average Mexican Adjunct Lager with a nice balance of grainy malts and light hops.
But it is definitely the fresh tasting lime that elevates this.
Usually when I have a beer with lime or lemon added I either think they needed more or less, but not this time.
This is the exact right amount of lime. Very refreshing.', '2020-05-10');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('24', '4', '4', 'One of the better DIPAs Ive had', 'Pours amber with a 1 inch white head. Heavy lacing. Slight haze.
Strong piney aroma, grapefruit, orange.
Taste is pine, grapefruit zest, resin.
Medium bodied, light carbonation. Dry, bitter finish.
Outstanding!', '2020-05-10');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('24', '5', '3', 'Needed More', 'Has a bronze color with amber highlights and a 1/2 inch head.
Smell is of tea, malts. Taste is dank, pine, alcohol, light malts, very bitter.
Feels medium/full bodied in the mouth and overall its pretty good, but I was expecting so much more.', '2020-05-10');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('24', '6', '3', 'A little sweeter for my tastes', ' Smooth with minimal hop taste.
More malty but I’m still giving it a good rating for its drinkability. Alcohol taste doesn’t linger.', '2020-05-10');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('25', '3', '4', 'What a surprise', 'I am not used to having an aggressive beer from Great Lakes.This is a great beer.
Very hoppy and bitter. Great mouthfeel. The smell seems a bit off to me. Taste is something else though.', '2020-05-11');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('25', '4', '1', 'Not my taste', 'I love Great Lakes, but this beer taught me I am not a fan at all of Red Ales.
I am sure since it is GLB, it is a good red ale, but that is just not the beer for me.
Was able to finish it, but a couple times I considered pouring it out, which is rare for me to even think that way.
If you like Red Ales with a lot of hops, you will most likely really like this.', '2020-03-16');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('25', '5', '3', 'The feel is not heavy at all', 'Pours a clear reddish-brown color with plenty of head.
Only slight carbonation though. Smell is kind of an odd hop scent. The initial taste is sweet and pleasant with only a slight finish.
Overall I think that this is a great summertime brew that I hope to enjoy more of', '2020-03-10');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('26', '6', '3', 'At $9.99/6 it will be a staple', 'Hazy yellow straw with a thin tan head that quickly dissolves into a ring.
A faint lemony scent
Some cloves, yeast, fresh bread upfront with a solid lemon finish
Picture lemonade made with a very good wheat beer instead of water and the year esters taking the place of sweeteners.
This is better than a shandy and a great summer beer.', '2020-06-18');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('26', '3', '3', 'Slightly dry but quenching at the same time', 'Pours a cloudy gold with a small yet creamy white head, doesn’t lace too much.
Nose is mild with subdued notes of clove, citrus peels and spice. Noticeable lemon flavor up front, the yeast and spices come on a little before some citrus closes it out.
Good summer beer, not great, but I’d buy it again without hesitation.', '2020-06-13');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('26', '4', '3', 'Overall its a decent beer', ' got a 6pck of this beer from my local meijer store.
It poured a slightly hazy golden with thin white head that is not leaving any lace.
The scent had crisp fresh lemon notes. The taste was nicely balanced and easy to drink with lemon tart presence.
The mouthfeel was lighter in body with good carbonation.', '2020-04-17');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('27', '5', '4', 'Very strong', 'Pours a clear amber. Not much foam. Mild hoppy aroma. The taste however is far from mild.
Almost like whiskey. Bitter syrupy finish.
Tastes like the lake monster pissed it out, but in a good way.', '2018-06-16');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('27', '6', '4', 'Amazing DIPA', ' Served on tap in a shaker pint.
Nice aromas of caramel and biscuit malt, floral and pine hops. Flavor, however, is intensely tropical and blooms over the palate.
Nice balance agaisnt sweet malt, with just enough of a bitter finish.', '2018-05-26');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('27', '3', '5', 'The taste follows the nose', 'Poured from a 12 OZ bottle into a pint glass.
The appearance is a cloudy gold color with a thick medium-sized white head.
The aroma is bread, malt and fruit.', '2018-02-22');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('28', '4', '5', 'One of the better American O-fests Ive come across', 'Poured from 12oz bottle into .5L stein. Clear bright orange/amber.
Off white head falls to a cap. Looks pretty still. Smell of bread dough, malt, and spicy hops. Taste follows nose with a
deep, malty, rich, doughy flavor. Sweet up front, but not overly so. Bitterness creeps in and spiciness from the hops finishes it up.
A bit of a black pepper kick in the middle. Its pretty flavorful and keeps me interested throughout.
Feel is medium with a hint of carbonation to keep it from seeming flat. Overall,
I enjoyed this beer and would seek it out again.', '2020-10-16');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('28', '5', '4', 'A hearty Oktoberfest', 'Very well done.
It has a bit more of a Hop bite than I would like, but other than that probably one of the better U.S. renditions of the style.
The smell is of malty wort with a floral bouquet background. Absolutely scrumptious.', '2020-10-14');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('28', '6', '4', 'Decent American Oktoberfest', 'Pours a light amber with white head. Some graham cracker crust aroma,
but it isnt particularly strong. Theres a lot of Honey Maid graham cracker/bready character. Honey wheat bread.
Its dry with some semblance of richness and enough hop character to break that up.', '2020-10-04');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('29', '3', '4', 'A good beer and a good representation of this style I feel', 'Poured out of a 12 oz. can into one of my stange glasses,
this beer pours a pretty clear, medium to dark golden color with a nice,
fluffy white head thats well over an inch thick when first poured. Head eventually settles to a fairly thick ring lining
the inside of the glass along with some nice cluster film layer swirls of surface foam with decent lacing.
Aromas of some crisp, bready malts and some floral and somewhat earthy hop notes. A very similar flavor profile,
with the aforementioned crisp, bready, and cracker like malts w/ a bit of grassy, herbal sweetness that gives way so some floral and earthy hop notes w/ just the right amount of bitterness.
Nicely balanced flavor profile here. Has a crisp, also smooth, light to medium bodied mouthfeel with light to moderate carbonation.
Has a clean finish.', '2020-10-04');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('29', '4', '5', 'Overall it is a solid beer', 'My Billet sons father gave me a 6pck of this beer.
It poured a clear golden with white head that is leaving some lace. The scent had a butter biscuit flare. 
The taste was nicely balanced and easy to drink with Nabisco club house cracker presence. 
The mouthfeel was lighter in body with good carbonation.', '2020-09-26');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('29', '5', '5', 'Its smooth and easy to drink', 'Pours golden with nice clarity; small white head that falls leaving nice retention and nice lacing. The aromas have hints of orange along with some mushrooms.
Its earthy. Hints of caramel and cream. Some bread. Malts are there. The flavors follow the nose perfectly. More orange notes.
Some fresh grass. More hints of caramel. Moderate sweetness. Low bitterness. Malts do their thing. Alcohol goes unnoticed.
Mouthfeel is light with moderate carbonation.', '2020-09-18');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('30', '6', '4', 'This is a great IPA for people who say they dont like IPAs', 'I really really love this beer - although not sure if it is technically an IPA, the IBUs seem a bit low.
If I had to rename this Id call it just a tropical pale ale.
First off the smell is amazing, big time fruitiness and citrus notes for sure.
The taste follows the nose, very fruity, very citrusy and bright. Not getting much mango or passion fruit,
its more like grapefruit if anything. It drinks like a session IPA despite its 7% ABV, very nicely hidden for sure.
Mouthfeel is very smooth, creamy and enjoyable.', '2021-04-10');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('30', '3', '4', 'The mango and passionfruit enhance without overwhelming', 'Pours golden with a white head that is fizzy, but holds up to a lasting thin cover.
A bit of lacing sticks.The smell is of mango and passionfruit with musty, grassy and citric hops.', '2021-04-02');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('30', '4', '4', 'Give it a try', 'Clear bright golden color, nice off-white head that slowly recedes, moderate amount of lacing. Very active carbonation streaming as it sits.
Citrus (Orange, lemon, tangerine, grapefruit), tropical fruit
(mango, passion fruit and pineapple), pine, some peach/nectarine and melon, bready malts, light floral notes.', '2021-03-14');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('31', '5', '4', 'This is a great occasional beer', 'From a bottle, pours as a haze deep copper with a thin off-white head plus loads of carbonation.
Aromas of caramel and grapefruit. Wow, loads of bitter hops and sweet malts with a citrus/grapefruit kick. Great because it is balanced enough, hops vs malt, that one can appreciate the added citrus,
etc, bonuses. Occasional because I have zero sweet tooth and so the solid sweetness dose of this brew means that having a second
is a real turn-off.', '2020-11-21');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('31', '6', '5', 'Been looking to review this one for a while', ' 
Creamy head above handsome amber head with orange and red highlights.
Nose is malty and funky with a bit of spice and yeasty weirdness,which is a plus here.
The taste starts similar but makes a hard turn to hoppy bitterness,
featuring citrus and herbal tones. Maybe a little overcaffeinated in the finish but the aftertaste
is still slightly oily and pleasing.', '2020-10-16');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('31', '3', '5', 'Look forward to this one every fall', 'Deep rich amber with a thick head that laces nicely. Dank hops smell.
Toasty malt body with a sharp hop bite. Best of both worlds.', '2020-10-02');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('32', '4', '3', 'A very typical, smooth Oatmeal Stout', 'Pretty good Oatmeal Stout!!!! Pours a dense dark brown color with no light coming through.
Small tan head with less than average retention and some lacing on the pint glass. Good Oatmeal Stout aroma and taste.
Rich malt and lactose and a little sweetness. Mouthfeel is fairly rich and smooth.
Not outstanding but solid enough.', '2021-02-23');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('32', '5', '2', 'This was just an incredible disappointment', 'Oh my gosh. This sounded like it should taste amazing.
But it just tastes like fake smoke flavor. I had to give it away to someone else because it honestly grossed me out.
And I love stouts.', '2021-2-13');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('32', '6', '2', 'Decent all around stout but nothing outrageous', 'Color is brown and somewhat light for a stout. 
Not clear per se, but some light does get through. Limited head and lacing. Smell is pretty standard for a stout with coffee,
roasted notes and oats. Taste follows the nose and has a bitter finish- nothing sweet or creamy about it. Body is pretty light and highly carbonated.
Overall: 3.75 (This beer is good but I would not likely drink it again)
I wouldnt go out of my way to find it as there are likely better options.', '2021-01-07');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('33', '3', '4', 'Love This', 'Great Lakes brings the honey to the Christmas Ale party.
This offering mimics mead and has just a touch of cinnamon.
Not a Winter warmer but a very good and sweet ale during the winter time.', '2021-01-07');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('33', '4', '4', 'Nice brew', 'Pours red with tall, long lasting,
fluffy off-white head and lively carbonation. Aroma is of caramel malt, red fruit, spices some cacao and piney hops.Body is medium and crisp.
Taste is of herbal hops, caramel malt, spices and red fruit. Finish is long and spicy.', '2020-11-27');

INSERT INTO reviews (beer_id, user_id, rating, review_title, review_body, date_of_review)
VALUES ('33', '5', '4', 'Surprising', 'I think spiced beers suck but this is very very good and I will attempt to get more,
I am in Massachusetts and was lucky to get this as a TYB in a trade.', '2020-11-20');

--Great Lakes Events For Demo

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES ('13', 'Christmas In July','The holidays are right around the corner and what better to celebrate
than with the chance to try some of the best Christmas Ales.','2021-07-03 18:00:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES ('13', 'Private Brewery Tour and Tasting','Private Guided Tour to our Brewhouse and Canning Facility 
- Welcome Beer - Beer Flight or Single Beer at the Taproom and Kitchen.','2021-05-01 12:00:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES ('13', 'Choose Your Ohio Sport | Paint + Brews!','Theres no better fan base than Cleveland!
Baseball is officially back, the NFL Draft is coming up and the Cavs host the NBA Draft next year.
Get HYPED and root for your home team by creating your own Cleveland sports themed painting','2021-04-27 21:00:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES ('13', 'Board Games and Brews','Bring some great friends and play your favorit board games & drinks some great beer.
Weekly drink specials. Bring your own games or check out our selection.','2021-05-22 18:30:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES ('13', 'Bands & Brews','Time to get drinking and jamming with our local artists! Enjoy the city whick truly rocks with us','2021-06-15 13:00:00');

-- Events other breweries

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES (1, 'Come by for wing night!', 'Come by next Wednesday for 50 cent wings and $2 drafts!  Wing special is for dine-in only.', '2021-04-21 18:00:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES (2, 'Nu Haze now on tap', 'Feel the haze with light citrue and ripe lemon.  Introducing our newest beer May 1st!', '2021-05-01 14:00:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES (3, 'Live music next Friday', 'Enjoy live music from Clevelands own local artists next Friday while drinking Forest City beer!', '2021-04-23 18:00:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES (4, 'Trivia night!', 'Bring your friends to drink beer and win prizes 4/19', '2021-04-19 20:30:00');

INSERT INTO brewery_events( brewery_id, title, description, date_and_time)
VALUES (5, 'Live music with Brent Kirby', 'Sip on a cold beer and enjoy live music.  Show begins at 7pm.', '2021-04-30');

































































































GO


