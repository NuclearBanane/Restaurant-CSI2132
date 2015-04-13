/*
 * Author : Rodger Waldron & Raj Pathak
 * 
 */

/*4. a*/
SELECT * FROM "Location"
	WHERE locationID = 'input';

/*4. b*/
SELECT * FROM "MenuItem"
	WHERE restaurantID = 'input'
	ORDER BY menuItemCategory;

/*4. c*/
SELECT "Restaurant".restaurantID, "Location".locationID, "Restaurant".restaurantType, "Location".managerName, "Location".firstOpenDate 
	FROM "Restaurant","Location"
	WHERE (restaurantType='input');

/*4. d 
/* Hasn't been designed to take only the Max price yet */
SELECT "Location".locationID, "Location".managerName, "Location".hourOpen, "Restaurant".url, "MenuItem".menuItemName, "MenuItem".price
	FROM "Location","Restaurant","MenuItem"
	WHERE (locationID = 'input' AND "Restaurant".restaurantID="Location".restaurantID);

/*4. e*/
/* This is working but doesn't yet display average price, just shows all */
SELECT "Restaurant".restaurantType, "MenuItem".menuItemName, "MenuItem".menuItemCategory, "MenuItem".price 
	FROM "Restaurant", "MenuItem"
	ORDER BY restaurantType;

/*4. f*/
SELECT "Restaurant".resName, "Location".locationID, "Location".streetAddress, "Rater".raterName, "Rating".ratingdate, "Rating".price, "Rating".mood, "Rating".food, "Rating".staff, "Rating".ratingComments
	FROM "Restaurant","Location","Rater","Rating"
	WHERE ("Restaurant".restaurantID = "Location".locationID AND "Rating".locationID = "Location".locationID AND "Rater".userID = "Rating".userID)
	ORDER BY resName, locationID, streetAddress, raterName, ratingDate;

/*4. g*/
SELECT "Restaurant".resName, "Location".locationID, "Restaurant".restaurantType, "Location".phoneNumber
	FROM "Restaurant","Location","Rating"
	WHERE ("Restaurant".restaurantID = "Location".restaurantID AND "Rating".ratingDate < '2015-01-01' AND "Rating".ratingDate > '2015-01-31' AND "Rating".locationID = "Location".locationID);

/*4. h*/

SELECT "Restaurant".resName, "Location".streetAddress, "Location".firstOpenDate, "Rater".raterName, "Rating".ratingdate, "Rating".staff
	FROM "Restaurant","Location","Rater","Rating"
	WHERE ("Restaurant".restaurantID = "Location".restaurantID AND "Rating".locationID = "Location".locationID AND "Rater".userID = "Rating".userID)
	ORDER BY ratingdate;

/*4. i*/
SELECT "Restaurant".resName, "Restaurant".restaurantType, "Location".streetAddress, "Rater".raterName, "Rating".food
	FROM "Restaurant","Location","Rater","Rating"
	WHERE ("Restaurant".restaurantID = "Location".restaurantID AND "Rating".locationID = "Location".locationID AND "Rater".userID = "Rating".userID AND "Restaurant".restaurantType = 'Pub')
	ORDER BY resName, food;
	
/*4. j*/
/* Select all restaurantIDs restaurantType that matches the input,
   then select the locationIDs from the Location table that have those restaurantIDs,
   then select the single highest rating for this restuarantID */

   	SELECT Location.restaurantID, Location.locationID, Restaurant.restaurantType, Rating.food INTO #ratingInfo FROM "Location" 
		GROUP BY Location.restaurantID 
		INNER JOIN "Restaurant"
		ON Restaurant.restaurantID=Location.restaurantID
		INNER JOIN "Rating"
		ON Rating.locationID=Location.locationID;
	SELECT a.restaurantType, MAX(a.food) FROM #ratingInfo a (
		SELECT a.food FROM ratingInfo a
			WHERE a.restaurantType = 'input') as toCompare
		WHERE (a.food > toCompare);

/*	SELECT Location.restaurantID, Location.locationID, Restaurant.restaurantType, Rating.food INTO #ratingInfo FROM "Location" 
		GROUP BY Location.restaurantID 
		INNER JOIN "Restaurant"
		ON Restaurant.restaurantID=Location.restaurantID
		INNER JOIN "Rating"
		ON Rating.locationID=Location.locationID*/

/*4. k*/
SELECT "Rater".raterName, "Rater".raterJoinDate, "Rater".reputation, "Rating".food, "Rating".mood, "Restaurant".resName, "Location".streetAddress
	FROM "Rater","Rating","Restaurant","Location"
	WHERE ("Restaurant".restaurantID="Location".locationID AND "Rating".locationID="Location".locationID AND "Rater".userID="Rating".userID AND "Rating".food=5 AND "Rating".mood=5)
	ORDER BY raterName;

/*4. l*/
SELECT "Rater".raterName, "Rater".raterJoinDate, "Rater".reputation, "Rating".food, "Rating".mood, "Restaurant".resName, "Location".streetAddress
	FROM "Rater","Rating","Restaurant","Location"
	WHERE ("Restaurant".restaurantID="Location".locationID AND "Rating".locationID="Location".locationID AND "Rater".userID="Rating".userID AND ("Rating".food=5 OR "Rating".mood=5))
	ORDER BY raterName;

/*4. m*/

/* this one is incomplete*/
SELECT Rater.raterName, Rater.reputation  FROM "Rater"

SELECT Rater.raterName INTO #theRaterID FROM "Rater"
	WHERE Rater.userID=(#myUserID b)
SELECT Rating.ratingComments, RatingItem.ratingItemComment, MenuItem.price, MenuItem.menuItemName 
	FROM "RatingItem"
	WHERE RatingItem.userID = (#theRaterID c)
	INNER JOIN "MenuItem"
	ON RatingItem.itemID=MenuItem.itemID
	INNER JOIN "Rating"
	ON Rating.userID

/*4. n*/
SELECT Rating.price, Rating.food, Rating.mood, Rating.staff, Rater.raterName, Rater.email FROM "Rating" (
	SELECT SUM((SUM(Rating.price) / COUNT (Rating.price)), (SUM(Rating.food) / COUNT(Rating.food)), (SUM(Rating.mood) / COUNT(Rating.mood)), (SUM(Rating.staff) / COUNT(Rating.staff)))/4
		WHERE Rating.userID='input') as averageRatingToCompare
	WHERE (SUM((SUM(Rating.price) / COUNT (Rating.price)), (SUM(Rating.food) / COUNT(Rating.food)), (SUM(Rating.mood) / COUNT(Rating.mood)), (SUM(Rating.staff) / COUNT(Rating.staff)))/4) < averageRatingToCompare
	INNER JOIN "Rater"
	ON Rater.userID=Rating.userID;

/*4. o*/