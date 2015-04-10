/*
 * Author : Rodger Waldron & Raj 
 * 
 */

/*4. a*/
SELECT * 
FROM Location L 
WHERE L.restaurant = 'input';

/*4. b*/
SELECT * ORDER BY M.category 
FROM MenuItems M 
WHERE M.restaurantID = 'input';

/*4. c*/
SELECT L.Manager, L.FirstOpen 
FROM Location L 
WHERE L.category = 'input';

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
