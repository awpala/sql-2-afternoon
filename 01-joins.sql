 /*
 |--- Practice Joins ---|
 */
 
 -- Step 1
SELECT *
FROM invoice AS i
JOIN invoice_line AS l
	ON i.invoice_id = l.invoice_id
WHERE L.unit_price > 0.99;

-- Step 2
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice AS i
JOIN customer c ON i.customer_id = c.customer_id;

-- Step 3
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer AS c
JOIN employee AS e
	ON c.support_rep_id = e.employee_id;

-- Step 4
SELECT l.title, r.name
FROM album AS l
JOIN artist AS r
	ON l.artist_id = r.artist_id;

-- Step 5
SELECT pt.track_id
FROM playlist_track AS pt
JOIN playlist AS p
	ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

-- Step 6
SELECT t.name
FROM track AS t
JOIN playlist_track AS pt
	ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

-- Step 7
SELECT t.name AS "Track", p.name AS "Playlist"
FROM track AS t
JOIN playlist_track AS pt
	ON t.track_id = pt.track_id
JOIN playlist AS p
	ON pt.playlist_id = p.playlist_id;

-- Step 8
SELECT t.name AS "Track", a.title AS "Album"
FROM track AS t
JOIN album AS a
	ON t.album_id = a.album_id
JOIN genre AS g
	ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

-- Black Diamond
SELECT DISTINCT 
  g.name AS "Genre"
  , art.name AS "Artist"
  ,	t.name AS "Track"
  , al.title AS "Album"
FROM playlist AS pl
JOIN playlist_track AS pt
	ON pl.playlist_id = pt.playlist_id
JOIN track AS t
	ON pt.track_id = t.track_id
JOIN genre AS g
	ON t.genre_id = g.genre_id
JOIN album as al
	ON t.album_id = al.album_id
JOIN artist AS art
	ON al.artist_id = art.artist_id
WHERE pl.name LIKE '%Music%'
ORDER BY g.name, art.name, al.title, t.name;
