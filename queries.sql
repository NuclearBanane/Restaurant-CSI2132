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
 This could be improved
*/
SELECT M.Price, M.Name, L.Manager, L.HourOpen 
FROM Location L, MenuItems M
WHERE L.restaurantID = M.restaurantID = 
	( SELECT R.Name 
	  FROM Restaurants R 
	  WHERE R.Name = 'input') 
	AND M.Price = max(Price);

/*4. e*/
SELECT avg(M.Price) 
FROM MenuItems M 
	LEFT JOIN restaurant R 
	ON M.restaurantID = R.restaurantID 
WHERE R.category= 'input' 
	AND M.category = 'input2';

/*4. f*/
SELECT R.Name,RT.Name, RT.rating 
	ORDER BY R.Name, RT.Name, RT.rating
FROM Ratings RT 
	LEFT JOIN Restaurants R 
	ON rt.restaurantID = R.restaurantID;

/*4. g*/
/*
Get all of the restaurant IDs out of the ratings (possibly switch rsID to locationID)
Get the phone numbers of all of the locations and the name of the chain they belong to and the type of food they serve. 
*/
//SELECT resName, restaurantType, locPhone FROM "Restaurant"

SELECT Location.phoneNumber, Restaurant.resName, Restaurant.restaurantType FROM "Location" (
	SELECT locationID FROM Rating 
		WHERE (ratingDate < '2015-01-01') AND (ratingDate > '2015-01-31')) as thisLid
	WHERE thisLid=locationID
	INNER JOIN "Restaurant"
	ON Location.restaurantID=Restaurant.restaurantID;

/*4. h*/
SELECT Location.locationID, Location.firstOpenDate, Restaurant.resName FROM "Location" 
	SELECT locationID FROM "Rating" (
		SELECT Rating.staff FROM "Rating" (
			WHERE userID = 'input') as toBeCompared
		WHERE toBeCompared > Rating.staff ) as selectedLocationId
	INNER JOIN "Restaurant"
	ON Restaurant.restaurantID=selectedLocationId;

/*4. i*/
/* Select the restaurantIDs that have the restaurantType that matches the input,
   then select all of the locationIDs in the Location table that have this restaurantID,
   then select locationID that has the highest food rating.*/
SELECT Rating.userID, Rating.locationID, MAX(Rating.food) FROM "Rating" (
	SELECT Location.locationID FROM "Location" (
		SELECT restaurantID FROM "Restaurant"
			WHERE restaurantType = 'input' ) as relevantChains
		WHERE Location.restaurantID = relevantChains GROUP BY relevantChains ) as relevantLocations
	WHERE Rating.locationID = relevantLocations;
	
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
SELECT Rating.userID, Rating.ratingdate, Rating.food, Rating.mood, Rating.locationID, Rater.raterName, Rater.raterJoinDate, Rater.reputation, Location.restaurantID
	FROM "Rating"
	WHERE ((Rating.food = 5) AND (Rating.mood = 5))
	INNER JOIN "Rater"
	ON Rater.userID=Rating.userID
	INNER JOIN "Location"
	ON Location.locationID=Rating.locationID;

/*4. l*/
SELECT Rating.userID, Rating.ratingdate, Rating.food, Rating.mood, Rating.locationID, Rater.raterName, Rater.raterJoinDate, Rater.reputation, Location.restaurantID
	FROM "Rating"
	WHERE ((Rating.food = 5) OR (Rating.mood = 5))
	INNER JOIN "Rater"
	ON Rater.userID=Rating.userID
	INNER JOIN "Location"
	ON Location.locationID=Rating.locationID;

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