SET search_path = "DBProj";

/* ASSUMING that RatingItem.date is not a foreign key. 
	    that a Rater has to have rated one thing at least */


create table "Restaurant"
(
restaurantID integer,
resName varchar(20),
restaurantType varchar(20),
url varchar(20),

constraint pk_restaurant primary key(restaurantID)
);

create table "Rater"
(
userID integer, 
email varchar(20),
raterName varchar(20),
raterJoinDate date,
raterType varchar(20),
reputation integer,

constraint pk_rater primary key(userID),

constraint repBounds check (reputation between 1 and 5)
);

create table "Rating"
(
userID integer,
ratingdate date,
price integer,
food integer,
mood integer,
staff integer,
ratingComments varchar(100),
restaurantID integer,

constraint pk_rating primary key(userID, ratingdate),
constraint fk_ratingUserID foreign key(userID) references "Rater",
constraint fk_ratingRestaurantID foreign key(restaurantID) references "Restaurant",

constraint priceBounds check (price between 1 and 5),
constraint foodBounds  check (food between 1 and 5),
constraint moodBounds  check (mood between 1 and 5),
constraint staffBounds check (staff between 1 and 5)
);

create table "Location"
(
locationID integer,
firstOpenDate date,
managerName varchar(20),
phoneNumber char(10),
streetAddress varchar(20),
hourOpen time,
hourClose time,
restaurantID integer,

constraint pk_location primary key(locationID),
constraint fk_restaurantID foreign key(restaurantID) references "Restaurant"
);

create table "MenuItem"
(
itemID integer,
menuItemName varchar(20),
menuItemType varchar(8),
menuItemCategory varchar(7),
description varchar(100),
price numeric(8,2),
restaurantID integer,

constraint pk_menuItem primary key(itemID),
constraint fk_restaurantID foreign key(restaurantID) references "Restaurant",

constraint foodType check (menuItemType = 'food' or menuItemType = 'beverage'),
constraint foodCat check (menuItemCategory = 'starter' or menuItemCategory = 'main' or menuItemCategory = 'desert')
);

create table "RatingItem"
(
userID integer,
ratingItemDate date, 
itemID integer,
rating integer,
ratingItemComment varchar(100),

constraint pk_ratingItem primary key(userID, ratingItemDate, itemID),

constraint fk_userID foreign key(userID) references "Rater",
constraint fk_itemID foreign key(itemID) references "MenuItem"
);

INSERT INTO "Restaurant"
VALUES (1,'McDonalds','Fast Food','http://www.mcdonalds.ca/'),
       (2,'Snobs','Fancy','http://www.snobs.com/'),
       (3,'Father and Sons','Pub','http://www.fatherandsonsottawa.com/');

INSERT INTO "Location"
VALUES (1,2000-01-01,'Joey Styles','613-666-1313','111 Lulz Avenue',06:00:00,18:00:00,1),
       (2,2001-01-01,'Ultimate Warrior','613-666-1313','222 Noob Avenue',06:00:00,18:00:00,1),
       (3,2002-01-01,'Bret Hart','613-666-1313','333 Meow Avenue',06:00:00,18:00:00,1),
       (4,2003-01-01,'Jim Cornette','613-666-1313','444 Omg Avenue',06:00:00,18:00:00,1),
       (5,2004-01-01,'AJ Lee','613-666-1313','555 Maccaron Avenue',06:00:00,18:00:00,2),
       (6,2005-01-01,'Billy Gunn','613-666-1313','666 Chaccaron Avenue',06:00:00,18:00:00,2),
       (7,2006-01-01,'Lex Luger','613-666-1313','777 Shoopdawhoop Avenue',06:00:00,18:00:00,2),
       (8,2007-01-01,'Macho Man','613-666-1313','888 Trololol Avenue',06:00:00,18:00:00,2),
       (9,2008-01-01,'Scott Steiner','613-666-1313','999 Screwdriver Avenue',06:00:00,18:00:00,3),
       (10,2009-01-01,'Shawn Michaels','613-666-1313','111 Frankensteiner Avenue',06:00:00,18:00:00,3),
       (11,2010-01-01,'Kevin Nash','613-666-1313','222 Powerbomb Avenue',06:00:00,18:00:00,3),
       (12,2011-01-01,'Hurricane Helmsley','613-666-1313','333 Standback Avenue',06:00:00,18:00:00,3);



create or replace trigger ratingMinimum
after insert or update of Rater.userID

delete from Rater where userID