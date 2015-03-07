create table "Artwork"
(
title varchar(20),
year integer,
type varchar(20),
price numeric(8,2),
aname varchar(20),
constraint pk_artwork primary key(title),
constraint fk_artwork foreign key(aname) references "Artist"
);

---
---
---

create table "Restaurant"
(
restaurantID
name varchar(20),
type
url
constraint pk_restaurant primary key(restaurantID)
);

create table "Rating"
(
userID integer,
date Date,
price integer,
food integer,
mood integer,
staff integer,
comments
restaurantID
constraint pk_rating primary key(userID, date)
constraint priceBounds check (0 < price < 6)
constraint foodBounds  check (0 < food < 6)
constraint moodBounds  check (0 < mood < 6)
constraint staffBounds check (0 < staff < 6)
);

create table "Rater"
(
userID integer, 
email varchar(20),
name varchar(20),
join-date Date,
type varchar(20),
reputation integer,
constraint pk_rater primary key(userID)
constraint repBounds check (0 < reputation < 6)
);

create table "Location"
(
locationID
firstOpenDate
managerName
phoneNumber
streetAddress
hourOpen
hourClose
restaurantID
constraint pk_location primary key(locationID)
);

create table "MenuItem"
(
itemID
name varchar(20),
type
category
decription
price
restaurantID
constraint pk_menuItem primary key()
);

create table "RatingItem"
(
userID
date
itemID
rating
comment
constraint pk_ratingItem primary key()
);