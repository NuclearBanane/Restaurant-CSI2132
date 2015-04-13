

/* ASSUMING that ratingitem.date is not a foreign key. 
	    that a Rater has to have rated one thing at least 
	    that a rating belongs to a location (cause that makes sense) 
	    locationID has now been added to ratingitem */


/*PG800 has a bug with capitalisations. I will post a bug report on their github soon
       - nuclearbanane
*/

create table "restaurant"
(
       restaurantID SERIAL PRIMARY KEY,
       resName varchar(20),
       restaurantType varchar(20),
       url varchar(60)

);

create table "rater"
(
       userID SERIAL PRIMARY KEY, 
       email varchar(60),
       userName varchar(32),
       password varchar(32), /*VERY BAD PRACTICE!!!!*/
       firstName varchar(20),
       lastName varchar(20),
       joinDate date,
       type varchar(20),
       reputation integer,

       constraint repBounds check (reputation between 0 and 5)
);

create table "location"
(
locationID SERIAL,
firstOpenDate date,
managerName varchar(20),
phoneNumber char(12),
streetAddress varchar(60),
hourOpen time,
hourClose time,
restaurantID integer,

constraint pk_location primary key(locationID),
constraint fk_restaurantID foreign key(restaurantID) references "restaurant"
);

create table "rating"
(
userID integer,
ratingdate date,
price integer,
food integer,
mood integer,
staff integer,
ratingComments varchar(100),
locationID integer,

constraint pk_rating primary key(userID, ratingdate),
constraint fk_ratingUserID foreign key(userID) references "rater",
constraint fk_ratinglocationID foreign key(locationID) references "location",

constraint priceBounds check (price between 1 and 5),
constraint foodBounds  check (food between 1 and 5),
constraint moodBounds  check (mood between 1 and 5),
constraint staffBounds check (staff between 1 and 5)
);

create table "menuitem"
(
itemID SERIAL,
menuitemName varchar(20),
menuitemType varchar(8),
menuitemCategory varchar(7),
description varchar(100),
price numeric(8,2),
restaurantID integer,

constraint pk_menuitem primary key(itemID),
constraint fk_restaurantID foreign key(restaurantID) references "restaurant",

constraint foodType check (menuitemType = 'food' or menuitemType = 'beverage'),
constraint foodCat check (menuitemCategory = 'starter' or menuitemCategory = 'main' or menuitemCategory = 'dessert' or menuitemCategory = 'side')
);

create table "ratingitem"
(
userID integer,
ratingitemDate date, 
itemID integer,
rating integer,
ratingitemComment varchar(100),
locationID integer,

constraint pk_ratingitem primary key(userID, ratingitemDate, itemID),

constraint fk_userID foreign key(userID) references "rater",
constraint fk_itemID foreign key(itemID) references "menuitem"
);


/* END */