/*
|--- Group by ---|
*/
 
-- Step 1
SELECT g.name, COUNT(t.*)
FROM track AS t
JOIN genre AS g
	ON t.genre_id = g.genre_id
GROUP BY g.name;

-- Step 2
SELECT g.name, COUNT(t.*)
FROM track AS t
JOIN genre AS g
	ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

-- Step 3
SELECT ar.name, COUNT(al.*)
FROM album AS al
JOIN artist AS ar
	ON ar.artist_id = al.artist_id
GROUP BY ar.name;
