/*
 * Author : Rodger Waldron & Raj 
 * 
 */

/*4. a*/
SELECT * FROM Location L WHERE L.restaurant = 'input';

/*4. b*/
SELECT * ORDER BY I.category FROM MenuItems I WHERE I.restaurantID = 'input';

/*4. c*/

SELECT L.Manager, L.FirstOpen FROM Location WHERE L.category='input';

/*4. d*/