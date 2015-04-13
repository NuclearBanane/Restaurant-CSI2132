SET search_path = "DBProj";

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
email varchar(60),
raterName varchar(20),
raterJoinDate date,
raterType varchar(20),
reputation integer,

constraint pk_rater primary key(userID),

constraint repBounds check (reputation between 1 and 5)
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

INSERT INTO "Restaurant"
VALUES (1,'McDonalds','Fast Food','http://www.mcdonalds.ca/'),
       (2,'Snobs','Fancy','http://www.snobs.com/'),
       (3,'Father and Sons','Pub','http://www.fatherandsonsottawa.com/');

INSERT INTO "Location"
VALUES (1,'2000-01-01','Joey Styles','613-666-1313','111 Lulz Avenue','06:00:00','18:00:00',1),
       (2,'2001-01-01','Ultimate Warrior','613-666-1313','222 Noob Avenue','06:00:00','18:00:00',1),
       (3,'2002-01-01','Bret Hart','613-666-1313','333 Meow Avenue','06:00:00','18:00:00',1),
       (4,'2003-01-01','Jim Cornette','613-666-1313','444 Omg Avenue','06:00:00','18:00:00',1),
       (5,'2004-01-01','AJ Lee','613-666-1313','555 Maccaron Avenue','06:00:00','18:00:00',2),
       (6,'2005-01-01','Billy Gunn','613-666-1313','666 Chaccaron Avenue','06:00:00','18:00:00',2),
       (7,'2006-01-01','Lex Luger','613-666-1313','777 Shoopdawhoop Avenue','06:00:00','18:00:00',2),
       (8,'2007-01-01','Macho Man','613-666-1313','888 Trololol Avenue','06:00:00','18:00:00',2),
       (9,'2008-01-01','Scott Steiner','613-666-1313','999 Screwdriver Avenue','06:00:00','18:00:00',3),
       (10,'2009-01-01','Shawn Michaels','613-666-1313','111 Frankensteiner Avenue','06:00:00','18:00:00',3),
       (11,'2010-01-01','Kevin Nash','613-666-1313','222 Powerbomb Avenue','06:00:00','18:00:00',3),
       (12,'2011-01-01','Hurricane Helmsley','613-666-1313','333 Standback Avenue','06:00:00','18:00:00',3);
/* starter, side, main, dessert, breakfast */
INSERT INTO "MenuItem"
VALUES (1,'burger',          'food','main',     'beef and bread',4.99,1),
       (2,'chicken nuggets', 'food','side',     'you do not want to know',2.99,1),
       (3,'fries',           'food','side',     'potatoes',3.99,1),
       (4,'pop',             'beverage','side', 'water and syrup',1.99,1),
       (5,'milk',            'beverage','side', 'moo',1.99,1),
       (6,'chicken burger',  'food','main',     'chicken and bread',9.99,1),
       (7,'poutine',         'food','main',     'potatoes and cheese',9.99,1),
       (8,'mcflurry',        'food','dessert',  'cold moo',9.99,1),
       (9,'big mac',         'food','main',     'twice the beef and bread',9.99,1),
       (10,'salad',          'food','side',     'leaves',9.99,1),
       (11,'egg mcmuffin',   'food','main','egg and bread',9.99,1),
       (12,'big breakfast',  'food','main','egg, bread, and a hashbrown',9.99,1),
       
       (13,'steak',          'food','main',     'beef',9.99,2),
       (14,'wine',           'beverage','side', 'grapes',9.99,2),
       (15,'champagne',      'beverage','side', 'something',9.99,2),
       (16,'ribs',           'food','main',     'oink',9.99,2),
       (17,'guinness',       'beverage','side', 'barley',9.99,2),
       (18,'rickards',       'beverage','side', 'barley',9.99,2),
       (19,'keiths',         'beverage','side', 'barley',9.99,2),
       (20,'canadian',       'beverage','side', 'rancid barley',9.99,2),
       (21,'fancier steak',  'food','main',     'fancier beef',9.99,2),
       (22,'chicken on a plate','food','main',  'chicken',9.99,2),
       (23,'duck',           'food','main',     'duck',9.99,2),
       (24,'wabbit',         'food','main',     'wabbit',9.99,2),
       (25,'greek salad',    'food','side',     'tasty stuff',9.99,2),
       (26,'caesar salad',   'food','side',     'stuff',9.99,2),
       
       (27,'nachos',              'food','starter',  'nachos and stuff',9.99,3),
       (28,'pizza',               'food','main',     'sauce and stuff',9.99,3),
       (29,'f and s burger',      'food','main',     'beef',9.99,3),
       (30,'swiss burger',        'food','main',     'beef',9.99,3),
       (31,'pulled pork sandwich','food','main',     'pork',9.99,3),
       (32,'chicken sandwich',    'food','main',     'chicken',9.99,3),
       (33,'salad',               'food','side',     'leaves',9.99,3),
       (34,'denis salad',         'food','starter',  'lots of stuff',9.99,3),
       (35,'poutine',             'food','side',     'potatoes',9.99,3),
       (36,'chili poutine',       'food','side',     'meat and potatoes',9.99,3),
       (37,'rickards',            'beverage','side', 'alcoholic stuff',9.99,3),
       (38,'keiths',              'beverage','side', 'alcoholic stuff',9.99,3),
       (39,'pop',                 'beverage','side', 'sugar',9.99,3),
       (40,'milk',                'beverage','side', 'moo',9.99,3);

INSERT INTO "Rater"
VALUES (1,'noob@lol.com','Johnny Goode','2000-01-01','blog',1),
       (2,'noob@lol.com','Johnny Goode','2000-01-01','blog',2),
       (3,'noob@lol.com','Johnny Goode','2000-01-01','blog',3),
       (4,'noob@lol.com','Johnny Goode','2000-01-01','blog',4),
       (5,'noob@lol.com','Johnny Goode','2000-01-01','blog',5),
       (6,'noob@lol.com','Johnny Goode','2000-01-01','blog',1),
       (7,'noob@lol.com','Johnny Goode','2000-01-01','blog',2),
       (8,'noob@lol.com','Johnny Goode','2000-01-01','blog',3),
       (9,'noob@lol.com','Johnny Goode','2000-01-01','blog',4),
       (10,'noob@lol.com','Johnny Goode','2000-01-01','blog',5),
       (11,'noob@lol.com','Johnny Goode','2000-01-01','blog',1),
       (12,'noob@lol.com','Johnny Goode','2000-01-01','blog',2),
       (13,'noob@lol.com','Johnny Goode','2000-01-01','blog',3),
       (14,'noob@lol.com','Johnny Goode','2000-01-01','blog',4),
       (15,'noob@lol.com','Johnny Goode','2000-01-01','blog',5);
       
INSERT INTO "Rating"
VALUES (1,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       (2,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       (3,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       (4,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       (5,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       (6,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       (7,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       (8,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',1),
       
       (9,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',2),
       (10,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',2),
       (11,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',2),
       (12,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',2),
       (13,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',2),
       (14,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',2),
       (15,'2000-01-01',5,5,5,5,'Omnomnomnomnomnomnom',2),
       (1,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',2),
       
       (1,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',3),
       (2,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',3),
       (3,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',3),
       (4,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',3),
       (5,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',3),
       (6,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',3),
       (7,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',3),
       (8,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',3),
       
       (9,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',4),
       (10,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',4),
       (11,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',4),
       (12,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',4),
       (13,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',4),
       (14,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',4),
       (15,'2000-01-02',5,5,5,5,'Omnomnomnomnomnomnom',4),
       (1,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',4),
       
       (2,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       (3,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       (4,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       (5,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       (6,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       (7,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       (8,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       (9,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',5),
       
       (10,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',6),
       (11,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',6),
       (12,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',6),
       (13,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',6),
       (14,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',6),
       (15,'2000-01-03',5,5,5,5,'Omnomnomnomnomnomnom',6),
       (1,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',6),
       (2,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',6),
     
       (3,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       (4,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       (5,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       (6,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       (7,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       (8,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       (9,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       (10,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',7),
       
       (11,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',8),
       (12,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',8),
       (13,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',8),
       (14,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',8),
       (15,'2000-01-04',5,5,5,5,'Omnomnomnomnomnomnom',8),
       (1,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',8),
       (2,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',8),
       (3,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',8),
       
       (4,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       (5,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       (6,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       (7,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       (8,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       (9,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       (10,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       (11,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',9),
       
       (12,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',10),
       (13,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',10),
       (14,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',10),
       (15,'2000-01-05',5,5,5,5,'Omnomnomnomnomnomnom',10),
       (1,'2000-01-07',5,5,5,5,'Omnomnomnomnomnomnom',10),
       (2,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',10),
       (3,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',10),
       (4,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',10),
       
       (5,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       (6,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       (7,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       (8,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       (9,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       (10,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       (11,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       (12,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',11),
       
       (13,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',12),
       (14,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',12),
       (15,'2000-01-06',5,5,5,5,'Omnomnomnomnomnomnom',12),
       (1,'2000-01-08',5,5,5,5,'Omnomnomnomnomnomnom',12),
       (2,'2000-01-07',5,5,5,5,'Omnomnomnomnomnomnom',12),
       (3,'2000-01-07',5,5,5,5,'Omnomnomnomnomnomnom',12),
       (4,'2000-01-07',5,5,5,5,'Omnomnomnomnomnomnom',12),
       (5,'2000-01-07',5,5,5,5,'Omnomnomnomnomnomnom',12);
       

INSERT INTO "RatingItem"
VALUES (1,'2000-01-01',1,1,'trolololololololololololololol',1),
       (2,'2000-01-01',2,2,'trolololololololololololololol',2),
       (3,'2000-01-01',3,3,'trolololololololololololololol',3),
       (4,'2000-01-01',4,4,'trolololololololololololololol',4),
       (5,'2000-01-01',4,5,'trolololololololololololololol',5),
       (6,'2000-01-01',5,2,'trolololololololololololololol',6),
       (7,'2000-01-01',6,3,'trolololololololololololololol',7),
       (8,'2000-01-01',6,4,'trolololololololololololololol',8),
       (9,'2000-01-01',6,5,'trolololololololololololololol',9),
       (10,'2000-01-01',7,1,'trolololololololololololololol',10),
       (11,'2000-01-01',7,3,'trolololololololololololololol',11),
       (12,'2000-01-01',2,3,'trolololololololololololololol',12),
       (13,'2000-01-01',3,3,'trolololololololololololololol',2),
       (14,'2000-01-01',2,4,'trolololololololololololololol',3),
       (15,'2000-01-01',4,2,'trolololololololololololololol',4),
       (1,'2000-01-02',1,5,'trolololololololololololololol',1),
       (2,'2000-01-02',6,1,'trolololololololololololololol',1),
       (3,'2000-01-02',2,2,'trolololololololololololololol',2),
       (4,'2000-01-02',3,3,'trolololololololololololololol',2),
       (5,'2000-01-02',4,4,'trolololololololololololololol',3);
/* END */