/* ASSUMING that RatingItem.date is not a foreign key. */

create table "Restaurant"
(
restaurantID integer,
name varchar(20),
restaurantType varchar(20),
url varchar(20),

constraint pk_restaurant primary key(restaurantID)
);

create table "Rating"
(
userID integer,
ratingdate date,
price integer,
food integer,
mood integer,
staff integer,
comments varchar(100),
restaurantID integer,

constraint pk_rating primary key(userID, ratingdate),
constraint fk_ratingUserID foreign key(userID) references "Rater",
constraint fk_ratingRestaurantID foreign key(restaurantID) references "Restaurant",

constraint priceBounds check (0 < price < 6),
constraint foodBounds  check (0 < food < 6),
constraint moodBounds  check (0 < mood < 6),
constraint staffBounds check (0 < staff < 6)
);

create table "Rater"
(
userID integer, 
email varchar(20),
name varchar(20),
join-date date,
raterType varchar(20),
reputation integer,

constraint pk_rater primary key(userID),

constraint repBounds check (0 < reputation < 6)
);

create table "Location"
(
locationID integer,
firstOpenDate date,
managerName varchar(20),
phoneNumber integer,
streetAddress varchar(20),
hourOpen time,
hourClose time,
restaurantID integer,

constraint pk_location primary key(locationID),
constraint fk_restaurantID foreign key(restaurantID) references "Restaurant",

constraint phoneNumberLength check (len(phoneNumber) = 10)
);

create table "MenuItem"
(
itemID integer,
name varchar(20),
menuItemType varchar(8),
menuItemCategory varchar(7),
description varchar(100),
price numeric(8,2),
restaurantID integer,

constraint pk_menuItem primary key(itemID),
constraint fk_restaurantID foreign key(restaurantID) references "Restaurant",

constraint foodType check (menuItemType = "food" or menuItemType = "beverage"),
constraint foodCat check (menuItemCategory = "starter" or menuItemCategory = "main" or menuItemCategory = "desert")
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
constraint fk_itemID foreign key(itemID) references "MenuItem",
);