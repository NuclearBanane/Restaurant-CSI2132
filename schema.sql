

/* ASSUMING that RatingItem.date is not a foreign key. 
	    that a Rater has to have rated one thing at least 
	    that a rating belongs to a location (cause that makes sense) 
	    locationID has now been added to RatingItem */


create table "Restaurant"
(
       restaurantID integer,
       resName varchar(20),
       restaurantType varchar(20),
       url varchar(60),

       constraint pk_restaurant primary key(restaurantID)
);

create table "Rater"
(
       userID integer, 
       userName varchar(32),
       email varchar(60),
       raterFirstName varchar(20),
       raterLastName varchar(20),
       raterJoinDate date,
       raterType varchar(20),
       reputation integer,

       constraint pk_rater primary key(userID),
       constraint repBounds check (reputation between 0 and 5)
);

create table "Location"
(
locationID integer,
firstOpenDate date,
managerName varchar(20),
phoneNumber char(12),
streetAddress varchar(60),
hourOpen time,
hourClose time,
restaurantID integer,

constraint pk_location primary key(locationID),
constraint fk_restaurantID foreign key(restaurantID) references "Restaurant"
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
locationID integer,

constraint pk_rating primary key(userID, ratingdate),
constraint fk_ratingUserID foreign key(userID) references "Rater",
constraint fk_ratingLocationID foreign key(locationID) references "Location",

constraint priceBounds check (price between 1 and 5),
constraint foodBounds  check (food between 1 and 5),
constraint moodBounds  check (mood between 1 and 5),
constraint staffBounds check (staff between 1 and 5)
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
constraint foodCat check (menuItemCategory = 'starter' or menuItemCategory = 'main' or menuItemCategory = 'dessert' or menuItemCategory = 'side')
);

create table "RatingItem"
(
userID integer,
ratingItemDate date, 
itemID integer,
rating integer,
ratingItemComment varchar(100),
locationID integer,

constraint pk_ratingItem primary key(userID, ratingItemDate, itemID),

constraint fk_userID foreign key(userID) references "Rater",
constraint fk_itemID foreign key(itemID) references "MenuItem"
);


/* END */