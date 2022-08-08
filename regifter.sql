-- Getting started, do not update
DROP DATABASE IF EXISTS regifter;
CREATE DATABASE regifter;
\c regifter
-- End getting started code

--
-- Write your code below each prompt

--
\echo Create a table called gifts
-- with the following columns
-- id serial primary KEY
-- gift - string
-- giver - string
-- value - integer
-- previously_regifted boolean
CREATE TABLE gifts (id SERIAL PRIMARY KEY, gift TEXT, giver TEXT, value INT, previously_regifted BOOL);



-- 
\echo See details of the table you created
-- 
SELECT * FROM gifts;



-- 
\echo Alter the table so that the column price is changed to value 
-- 
ALTER TABLE gifts RENAME price TO value;

-- 
\echo Insert a peach candle, given by 'Santa' thats value is 9 and has been previously regifted
-- 
INSERT INTO gifts(gift, giver, value, previously_gifted) 
VALUES ('peach candle', 'Santa', '9', true);

--
\echo Query for all the columns in your gifts table
-- 
\d gifts;

--
\echo Uncomment below to insert 5 more gifts
-- 

INSERT INTO gifts (gift, giver, value, previously_gifted)
VALUES
('peach candle', 'Santa', '9', TRUE),
('cinnamon candle', 'Nick', '19', TRUE),
('soap on a rope', 'Rudolf', '29', FALSE),
('potpurri', 'Elf on the Shelf', '39', TRUE),
('mango candle', 'The Boss', '49', FALSE)
;

-- 
\echo Insert 5 more gifts of your own choosing,  include 1 more candle
--
regifter=# INSERT INTO gifts (gift, giver, value, previously_gifted)
regifter-# VALUES
regifter-# ('magic silver broom', 'tinkerbell', '9', TRUE),
regifter-# ('gold medallion', 'melchezidek', '13', TRUE),
regifter-# ('coal', 'Mrs.Santa', '4', FALSE),
regifter-# ('tea', 'the Queen', '100', TRUE),
regifter-# ('hot sauce', 'Satan', '1', FALSE)
regifter-# ;
INSERT 0 5
regifter=# SELECT * FROM gifts;
 id |        gift        |      giver       | value | previously_gifted
----+--------------------+------------------+-------+-------------------
  1 | peach candle       | Santa            |     9 | t
  2 | peach candle       | Santa            |     9 | t
  3 | cinnamon candle    | Nick             |    19 | t
  4 | soap on a rope     | Rudolf           |    29 | f
  5 | potpurri           | Elf on the Shelf |    39 | t
  6 | mango candle       | The Boss         |    49 | f
  7 | magic silver broom | tinkerbell       |     9 | t
  8 | gold medallion     | melchezidek      |    13 | t
  9 | coal               | Mrs.Santa        |     4 | f
 10 | tea                | the Queen        |   100 | t
 11 | hot sauce          | Satan            |     1 | f
(11 rows)


--
\echo Query for gifts with a price greater than or equal to 20
--
regifter=# SELECT * FROM gifts WHERE value >= 20;
 id |      gift      |      giver       | value | previously_gifted
----+----------------+------------------+-------+-------------------
  4 | soap on a rope | Rudolf           |    29 | f
  5 | potpurri       | Elf on the Shelf |    39 | t
  6 | mango candle   | The Boss         |    49 | f
 10 | tea            | the Queen        |   100 | t
(4 rows)

--
\echo Query for every gift that has the word candle in it, only show the gift column
--
regifter=# SELECT * FROM gifts WHERE gift LIKE '%candle%';
 id |      gift       |  giver   | value | previously_gifted
----+-----------------+----------+-------+-------------------
  1 | peach candle    | Santa    |     9 | t
  2 | peach candle    | Santa    |     9 | t
  3 | cinnamon candle | Nick     |    19 | t
  6 | mango candle    | The Boss |    49 | f
(4 rows)

--
\echo Query for every gift whose giver is Santa OR value is greater than 30
--
regifter=# SELECT * FROM gifts WHERE giver LIKE '%Santa%' OR value > 30;
 id |     gift     |      giver       | value | previously_gifted
----+--------------+------------------+-------+-------------------
  1 | peach candle | Santa            |     9 | t
  2 | peach candle | Santa            |     9 | t
  5 | potpurri     | Elf on the Shelf |    39 | t
  6 | mango candle | The Boss         |    49 | f
  9 | coal         | Mrs.Santa        |     4 | f
 10 | tea          | the Queen        |   100 | t
(6 rows)

--
\echo Query for every gift whose giver is NOT Santa
--
regifter=# SELECT * FROM gifts WHERE giver NOT LIKE '%Santa%';
 id |        gift        |      giver       | value | previously_gifted
----+--------------------+------------------+-------+-------------------
  3 | cinnamon candle    | Nick             |    19 | t
  4 | soap on a rope     | Rudolf           |    29 | f
  5 | potpurri           | Elf on the Shelf |    39 | t
  6 | mango candle       | The Boss         |    49 | f
  7 | magic silver broom | tinkerbell       |     9 | t
  8 | gold medallion     | melchezidek      |    13 | t
 10 | tea                | the Queen        |   100 | t
 11 | hot sauce          | Satan            |     1 | f
(8 rows)

--
\echo Update the second gift to have a value of 2999
-- 
regifter=# UPDATE gifts SET value = 2999 WHERE id=4;
UPDATE 1
regifter=# SELECT * FROM gifts;
 id |        gift        |      giver       | value | previously_gifted
----+--------------------+------------------+-------+-------------------
  1 | peach candle       | Santa            |     9 | t
  2 | peach candle       | Santa            |     9 | t
  3 | cinnamon candle    | Nick             |    19 | t
  5 | potpurri           | Elf on the Shelf |    39 | t
  6 | mango candle       | The Boss         |    49 | f
  7 | magic silver broom | tinkerbell       |     9 | t
  8 | gold medallion     | melchezidek      |    13 | t
  9 | coal               | Mrs.Santa        |     4 | f
 10 | tea                | the Queen        |   100 | t
 11 | hot sauce          | Satan            |     1 | f
  4 | soap on a rope     | Rudolf           |  2999 | f
(11 rows)

--
\echo Query for the updated item
--
UPDATE gifts SET value = 2999 WHERE id=4 RETURNING *; 
RETURNING *  -- returns the updated item.

--
\echo Delete all the gifts from Santa and return the 'value' and 'gift' of the gift you have deleted
--
DELETE FROM gifts WHERE giver = 'Santa' RETURNING value, gift;

--
\echo Query for all the columns in your gifts table one more time
--
SELECT * FROM gifts;


-- BONUSES

--
 \echo Count the total number of gifts that have the word candle in it
-- 
SELECT COUNT(gift) FROM gifts WHERE gift ILIKE '%candles%';

--
\echo Get the AVEREAGE value from all the gifts
--
SELECT AVG(value) FROM gifts;

-- 
 \echo Limit to 3 gifts, offset by 2 and order by price descending
--
SELECT * FROM gifts ORDER BY value DESC LIMIT 3 OFFSET 2;
--
-- finish
--
DROP TABLE IF EXISTS gifts;
DROP TABLE gifts;
