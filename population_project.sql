CREATE DATABASE Population_Project;
USE Population_Project;

-- Purpose: The purpose of this project is to determine if there is a significant linear link between economic health/growth of a given state, and it's population growth. 
-- I found myself curious as to if the population of a given state could be predicted by economic factors within the state. 
-- The following data were obtained from bea.gov, and summarizes three datum types from 1929 to 2020: population, per capita income and overall state income. 

-- For the sake of brievity, I have accumulated data from years in ten year increments. 
-- Although this is not ideal, I believe that comparing the information in ten year intervals will still convey an accurate representation of each state. 
-- The intervals will be 1930 - 1939, 1940 - 1949 etc. 
-- I began by editing some of the data from each of the tables: PerCapita_Income, State_Population and State_Income tables. 
-- Editing each of the tables allowed for cleaner data, as well as simplicity when using all three of the tables at the same time. 
-- The table provided by bea.gov had each year from 1929 - 2020 as separate columns, to make queries easier, I made one column for "Year", and included all years.
-- The once single large table then became three separate tables that would be easier to work with for this project. 
-- The tables were made in Google Sheets. 
-- Let us begin with the State_Income table. 

SELECT *
FROM State_Income;
		-- Looks like all of our information is present, except for the NULL values, where information was not available. 
        -- Lets start by comparing all of the states at the same time.
        -- Lets look for the states with the most economic value throughout the years. 
        
SELECT MAX(Amount), State_Name, Year
FROM State_Income
GROUP BY Amount DESC, State_Name, Year
LIMIT 10;
		-- From this we can see which states are at the top as far as state revenue goes. 
        -- We can see here that there are only 4 different states that make the top 10 list of years with the most revenue per state. 

-- Lets see what the lower end looks like. 
SELECT  MIN(Amount), State_Name, Year
FROM State_Income
GROUP BY Amount ASC, State_Name, Year
LIMIT 10;
		-- This search gives us all NULL values, as there was no information for that time period. 
        -- Lets try again until we obtain numerical results. 
        
SELECT  MIN(Amount), State_Name, Year
FROM State_Income
WHERE Amount IS NOT NULL
GROUP BY Amount ASC, State_Name, Year
LIMIT 10;
		-- In this example, we added IS NOT NULL in order to omit null vales from the search. 
        -- We can now see the lowest income states, and the years assocaited with their low income. 
        -- Lets see if we can obtain more recent results. 
        
SELECT State_Name, MAX(Amount), Year
FROM State_Income
WHERE Year>'2018'
GROUP BY State_Name, Amount, Year
ORDER BY Amount DESC;
		-- Here we can see all 50 states and their reported state income for the year 2019. 
        -- This is organized by most to least income for 2019. 
        
-- Lets make this into a top 10 for simplicity. 
SELECT State_Name, MAX(Amount), Year
FROM State_Income
WHERE Year>'2018'
GROUP BY State_Name, Amount, Year
ORDER BY Amount DESC 
LIMIT 10;
		-- Lets keep this list of 10 states in mind for now, and investigate with these states. 
        -- TOP 10 STATE INCOME EARNERS 2019
        -- 'California','2544235','2019'
		-- 'Texas','1544021','2019'
		-- 'Florida','1139799','2019'
		-- 'Illinois','748812','2019'
		-- 'Pennsylvania','737161','2019'
		-- 'NewJersey','619066','2019'
		-- 'Ohio','587177','2019'
		-- 'Georgia','518278','2019'
		-- 'Massachusettes','506614','2019'
		-- 'Virginia','502601','2019'

	

-- Lets take a look at our State_Population table now. 
SELECT * 
FROM State_Population;
		-- Everything seems to be in order, as this table was made in the same way as the State_Income table. 
        -- Like the state income, lets look to see which states are our high, and low outliers. 
        
SELECT State_Name, MAX(Population), Year
FROM State_Population
WHERE Year>2018
GROUP BY State_Name, Population, Year; 
		-- This shows the total state population for 2019 for each of the states. 
        -- Lets obtain just the top ten states for 2019. 
        
SELECT State_Name, MAX(Population), Year
FROM State_Population
WHERE Year>2018
GROUP BY State_Name, Population, Year
ORDER BY Population DESC
LIMIT 10;
		-- Here is our top ten states with the highest population in 2019. 
        -- Lets compare this to our top ten list from State_Income. 
		-- Interesting, here we can see that the relationship between total population and the entire states income are not strictly linked. 
        -- New York, North Carolina and Michigan are all ont the populated list, but are not on the top ten for state income. 
        -- New Jeresey, Massachusetts and virginia are seen in the top ten for income, but are not on the most populated list. 
        -- TOP 10 MOST POPULATED STATES 2019
		-- 'California','39437610','2019'
		-- 'Texas','28986794','2019'
		-- 'Florida','21492056','2019'
		-- 'NewYork','19463131','2019'
		-- 'Pennsylvania','12798883','2019'
		-- 'Illinois','12667017','2019'
		-- 'Ohio','11696507','2019'
		-- 'Georgia','10628020','2019'
		-- 'NorthCarolina','10501384','2019'
		-- 'Michigan','9984795','2019'

-- Lets make a note of this, and look into the lower end of the spectrum. 

SELECT State_Name, MIN(Population), Year 
FROM State_Population
WHERE Year>2018
GROUP BY State_Name, Population, Year 
ORDER BY Population ASC
LIMIT 10;
		-- Here we can see the lowest populated states in 2019, with Wyoming being the lowest populated state in the USA. 
        -- Lets compare this list with the one for state income to determine if there is a relationship between the two. 
        -- TOP 10 LOWEST POPULATION STATES 2019. 
        -- 'Wyoming','580116','2019'
		-- 'Vermont','624046','2019'
		-- 'DistrictofColumbia','708253','2019'
		-- 'Alaska','733603','2019'
		-- 'NorthDakota','763724','2019'
		-- 'SouthDakota','887127','2019'
		-- 'Delaware','976668','2019'
		-- 'RhodeIsland','1058158','2019'
		-- 'Montana','1070123','2019'
		-- 'Maine','1345770','2019'

         
SELECT State_Name, MIN(Amount), Year 
FROM State_Income
WHERE Year>2018
GROUP BY State_Name, Amount, Year 
ORDER BY Amount ASC
LIMIT 10;
		-- Here we can see a top ten list of the lowest state income states. 
		-- WY,VM,DC,AK,ND,SD,DW,RI,MO,ME. (population)
        -- VM,WY,ND,AK,AZ,SD,DW,MO,DC,ME. (state income)
		-- We can see that the two lists are relatively similar except for a few states.
        -- Arizona can be seen on the lowest income list, but not on the lowest population list. 
        -- Rhode Island is on the lowest population list, however, they are not seen on the lowest state income list. 
        -- This would theoretically imply that despite Arizona's large population, they are on the lowest end as far as state income goes. 
        -- Likewise, this would also mean that Rhode Island is generating more revenue despite their lack of numbers in their population. 
        -- TOP 10 LOWEST INCOME STATES
		-- 'Vermont','34570','2019'
		-- 'Wyoming','35425','2019'
		-- 'NorthDakota','44420','2019'
		-- 'Alaska','45294','2019'
		-- 'Arizona','45294','2019'
		-- 'SouthDakota','48548','2019'
		-- 'Delaware','52538','2019'
		-- 'Montana','53613','2019'
		-- 'DistrictofColumbia','57240','2019'
		-- 'Maine','67856','2019'
        -- We will make a note of this for later on. 
        
-- Lets now lets take a look into some of the individual income from the PerCapita_Income table. 

SELECT * 
FROM PerCapita_Income;
		-- This table shows the average individual income for all 50 states from 1930 to 2019 in ten year increments. 
        -- Lets take a closer look at the high and low ends of these data.
        
SELECT MAX(Average_Income), State_Name, Year
FROM PerCapita_Income
WHERE Year>2018
GROUP BY Average_Income, State_Name, Year;
		-- This query shows us all of the 50 states ranked low to high for average income for 2019. 
        -- Lets try to see if we can make this a top ten list. 
        
SELECT MAX(Average_Income), State_Name, Year 
FROM PerCapita_Income
WHERE Year>2018
GROUP BY Average_Income DESC, State_Name, Year 
LIMIT 10;
		-- Here we can see our top ten list of highest average income for individuals throughout the USA. 
        -- We can immediately see a standout from this list. Alaska(AK) made it to the tenth spot on this list while we previously saw that it was the fourth lowest for population, as well as state income. 
        -- This would mean that despite the fact that Alaska is seen as a unpopulated, low income state, the average income for an individual is relatively high comparatively in the USA. 
        -- Another interesting observation that we can see involves the Dsitrict of Columbia.
        -- DC has the third lowest population, and is ninth lowest for state income, however, we can clearly see that the individuals residing there are, on average, the highrst paid individuals in the USA. 
        -- We will make a note of this list and return to it later on. 
        -- TOP 10 LIST OF PER CAPITA INCOME
        -- '80819','DistrictofColumbia','2019'
		-- '75794','Connecticut','2019'
		-- '73477','Massachusettes','2019'
		-- '69951','NewYork','2019'
		-- '69626','NewJersey','2019'
		-- '64513','California','2019'
		-- '63785','NewHamshire','2019'
		-- '63021','Washington','2019'
		-- '62989','Maryland','2019'
		-- '61742','Alaska','2019'
        
-- Lets take a look intot the lowest per capita income states. 

SELECT MAX(Average_Income), State_Name, Year 
FROM PerCapita_Income
WHERE Year>2018
GROUP BY Average_Income, State_Name, Year 
ORDER BY Average_Income ASC
LIMIT 10;
		-- Here we can see the top ten lowest personal income states in the USA, with $39,000 being the lowest average in Mississippi.  
		-- '39062','Mississippi','2019'
		-- '42500','WestVirginia','2019'
		-- '43121','NewMexico','2019'
		-- '43881','Kentucky','2019'
		-- '43996','Alabama','2019'
		-- '44788','Arkansas','2019'
		-- '45455','SouthCarolina','2019'
		-- '45741','Idaho','2019'
		-- '45808','Arizona','2019'
		-- '47660','NorthCarolina','2019'

-- Now that we have a general understanding of what state income, state population, and personal average income looks like throughout the USA, lets dive into the question at hand. 
-- Lets look into the data to determine if we can observe trends between economic health, and population growth. 

-- Lets begin with the first state in our list, as an example. 
SELECT
(SELECT Population
FROM State_Population
WHERE `Year` = 1939 AND State_Name = 'Alabama')
-
(SELECT Population
FROM State_Population
WHERE `Year` = 1930 AND State_Name = 'Alabama') AS Difference;
		-- This query shows us the difference between 1939 and 1930 for state population in Alabama. 
        -- i.e. 167000 people calimed residence to Alabama between 1930 and 1939. 
        
-- Lets take a look at a more recent example for Alabama. 
SELECT 
(SELECT Population
FROM State_Population
WHERE `Year` = 2019 AND State_Name = 'Alabama')
-
(SELECT Population
FROM State_Population
WHERE `Year` = 2010 AND State_Name = 'Alabama') AS Difference;
		-- This query is similar to the one above, except it shows the difference between 2019 and 2010. 
        -- The population increase from 2010 to 2019 is 122,451 people. 
        
-- Now, lets look into the data for personal income. 

SELECT
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 1939 AND State_Name = 'Alabama')
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 1930 AND State_Name = 'Alabama') AS Difference;
		-- Here we can see that the difference between 1939 and 1930 is -12. 
        -- Lets check our table to corroborate this value. 
SELECT * 
FROM PerCapita_Income;
		-- Indeed, this is correct. 
        -- The average income in 1930 was 263 dollars per year, as opposed to 251 dollars per year in 1939. 
        -- This is an interesting fact to make note of. 
        
-- Lets compare more recent years for Alabama. 
SELECT 'Alabama' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2019 AND State_Name = 'Alabama')
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2010 AND State_Name = 'Alabama') AS Difference;
		-- Here we can see a difference of 10033. 
        -- This would theoretically mean that the the average income of people living in Alabama increases at a rate of about 1,000 per year. 
        
-- Lets finally look into the state income for Alabama. 
SELECT 'Alabama' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE `Year` = 1939 AND State_Name = 'Alabama')
-
(SELECT Amount
FROM State_Income
WHERE `Year` = 1930 AND State_Name = 'Alabama');
		-- The difference between 1930 and 1939 can be seen as 8 million in revenue. 
        
SELECT 'Alabama' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE `Year` = 2019 AND State_Name = 'Alabama')
-
(SELECT Amount
FROM State_Income
WHERE `Year` = 2010 AND State_Name = 'Alabama');
		-- We can observe that between the decade starting in 2010, Alabama saw an increase in state income on the scale of 53,399 in millions. 
        
-- Now that have an understanding of the comparisons between decades on all fronts, lets see if we can use this to help paint a picture for our project question. 


-- Let's begin by going back to our top earing states, and use them as a point of reference. 
-- Recall that this was our top ten list for highest paid workers in the USA in 2019. 
-- We will update this list by adding the average income differential between 2010 and 2019. 
		-- '80819','DistrictofColumbia','2019'	$17,502 growth rate= 27%
		-- '75794','Connecticut','2019'			$14,032 growth rate= 22%
		-- '73477','Massachusettes','2019'		$20,558 growth rate= 38%
		-- '69951','NewYork','2019'				$21,133 growth rate= 43%
		-- '69626','NewJersey','2019'			$18,495 growth rate= 36%
		-- '64513','California','2019'			$21,264 growth rate= 49%
		-- '63785','NewHamshire','2019'			$16,677 growth rate= 35%
		-- '63021','Washington','2019'			$20,669 growth rate= 48%
		-- '62989','Maryland','2019'			$13,298 growth rate= 26%
		-- '61742','Alaska','2019'				$12,088 growth rate= 24%

SELECT (17502/(80819-17502)) * 100;
SELECT (14032/(75794-14032)) * 100;
SELECT (20558/(73477-20558)) * 100;
SELECT (21133/(69951-21133)) * 100;
SELECT (18495/(69626-18495)) * 100;
SELECT (21264/(64513-21264)) * 100;
SELECT (16677/(63785-16677)) * 100;
SELECT (20669/(63021-20669)) * 100;
SELECT (13298/(62989-13298)) * 100;
SELECT (12088/(61742-12088)) * 100;





-- DC
SELECT 'DistrictofColumbia' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2019 AND State_Name = 'DistrictofColumbia')
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2010 AND State_Name = 'DistrictofColumbia');

-- Connecticut
SELECT 'Connecticut' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2019 AND State_Name = 'Connecticut')
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2010 AND State_Name = 'Connecticut');

-- Massachusettes
SELECT 'Massachusettes' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2019 AND State_Name = 'Massachusettes')
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2010 AND State_Name = 'Massachusettes');

SELECT 'New York' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2019 AND State_Name = 'NewYork')
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE `Year` = 2010 AND State_Name = 'NewYork');

SELECT 'NewJersey' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NewJersey' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NewJersey' AND `Year` = 2010);


SELECT 'California' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'California' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'California' AND `Year` = 2010);

SELECT 'NewHamshire' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NewHamshire' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NewHamshire' AND `Year` = 2010);


SELECT 'Washington' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Washington' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Washington' AND `Year` = 2010);

SELECT 'Maryland' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Maryland' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Maryland' AND `Year` = 2010);

SELECT 'Alaska' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Alaska' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Alaska' AND `Year` = 2010);

-- Perfect, now we have an understanding of the average income differentials from 2010 to 2019 for some of the highest earning states. 
-- Lets conduct this same search for our lowest ranking states.
-- Lets refer back to our lowest income list from before. 
-- The income differentials can be seen adjacent to the corresponding states.

		-- '39062','Mississippi','2019'		$7,778 growth rate = 24%
		-- '42500','WestVirginia','2019'	$9,736 growth rate =29%
		-- '43121','NewMexico','2019'		$9,407 growth rate =27%
		-- '43881','Kentucky','2019'		$10,467 growth rate =31%
		-- '43996','Alabama','2019'			$10,033 growth rate =29%
		-- '44788','Arkansas','2019'		$12,421 growth rate =65%
		-- '45455','SouthCarolina','2019'	$12,617 growth rate =66%
		-- '45741','Idaho','2019'			$13,365 growth rate =67%
		-- '45808','Arizona','2019'			$11,960 growth rate =66%
		-- '47660','NorthCarolina','2019'	$11,800 growth rate =69%
        
SELECT (7778/(39062-7778)) * 100;
SELECT (9736/(42500-9736)) * 100;
SELECT (9407/(43121-9407)) * 100;
SELECT (10467/(43881-10467)) * 100;
SELECT (10033/(43996-10033)) * 100;
SELECT (44788/(80819-12421)) * 100;
SELECT (45455/(80819-12617)) * 100;
SELECT (45741/(80819-13365)) * 100;
SELECT (45808/(80819-11960)) * 100;
SELECT (47660/(80819-11800)) * 100;

        
       
        
        
SELECT 'Mississippi' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Mississippi' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Mississippi' AND `Year` = 2010);

SELECT 'WestVirginia' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'WestVirginia' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'WestVirginia' AND `Year` = 2010);

SELECT 'NewMexico' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NewMexico' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NewMexico' AND `Year` = 2010);

SELECT 'Kentucky' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Kentucky' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Kentucky' AND `Year` = 2010);

SELECT 'Alabama' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Alabama' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Alabama' AND `Year` = 2010);

SELECT 'Arkansas' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Arkansas' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Arkansas' AND `Year` = 2010);

SELECT 'SouthCarolina' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'SouthCarolina' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'SouthCarolina' AND `Year` = 2010);

SELECT 'Idaho' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Idaho' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Idaho' AND `Year` = 2010);

SELECT 'Arizona' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Arizona' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'Arizona' AND `Year` = 2010);

SELECT 'NorthCarolina' AS State_Name,
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NorthCarolina' AND `Year` = 2019)
-
(SELECT Average_Income
FROM PerCapita_Income
WHERE State_Name = 'NorthCarolina' AND `Year` = 2010);

-- Perfect, now we have obtained the lowest average percapita incoe states, with their average incoome differentials from 2010 to 2019. 
-- Now that we have some income information for both the high end and the low end of income, lets look into some more population data. 
-- Lets us refer back to our most populated states table, and add the population change from 2010 to 2019 next to it. 

		-- 'California','39437610','2019'		2,118,060 growth rate = 5%
		-- 'Texas','28986794','2019'			3,744,897 growth rate = 14%
		-- 'Florida','21492056','2019'			2,645,913 growth rate = 14%
		-- 'NewYork','19463131','2019'			63,175 growth rate = 0.3%
		-- 'Pennsylvania','12798883','2019'		87,477 growth rate = 0.6%
		-- 'Illinois','12667017','2019'			-173,528 growth rate = -1%
		-- 'Ohio','11696507','2019'				157,058 growth rate = 1%
		-- 'Georgia','10628020','2019'			915,811 growth rate = 9%
		-- 'NorthCarolina','10501384','2019'	926,798 growth rate = 9%
		-- 'Michigan','9984795','2019'			107,198 growth rate = 1%
        
SELECT (2118060/(39437610-2118060)) * 100;
SELECT (3744897/(28986794-3744897)) * 100;
SELECT (2645913/(21492056-2645913)) * 100;
SELECT (63175/(19463131-63175)) * 100;
SELECT (87477/(12798883-87477)) * 100;
SELECT (-173528/(12667017-173528)) * 100;
SELECT (157058/(11696507-157058)) * 100;
SELECT (915811/(10628020-915811)) * 100;
SELECT (926798/(10501384-926798)) * 100;
SELECT (107198/(9984795-107198)) * 100;

        
SELECT 'California' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'California' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'California' AND `Year` = 2010);

SELECT 'Texas' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Texas' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Texas' AND `Year` = 2010);

SELECT 'Florida' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Florida' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Florida' AND `Year` = 2010);

SELECT 'NewYork' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'NewYork' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'NewYork' AND `Year` = 2010);

SELECT 'Pennsylvania' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Pennsylvania' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Pennsylvania' AND `Year` = 2010);

SELECT 'Illinois' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Illinois' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Illinois' AND `Year` = 2010);

SELECT 'Ohio' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Ohio' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Ohio' AND `Year` = 2010);

SELECT 'Georgia' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Georgia' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Georgia' AND `Year` = 2010);

SELECT 'NorthCarolina' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'NorthCarolina' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'NorthCarolina' AND `Year` = 2010);

SELECT 'Michigan' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Michigan' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Michigan' AND `Year` = 2010);

-- Now that we can see the changes in population for our most populated state, lets now look into our least populated states. 
-- Lets view our lowest population list for reference. 

        -- 'Wyoming','580116','2019'			15,585	Growth rate = 2%
		-- 'Vermont','624046','2019'			-1,840	Growth rate = -0.2%
		-- 'DistrictofColumbia','708253','2019'	102,971 Growth rate = 17%
		-- 'Alaska','733603','2019'				19,621	Growth rate = 2%
		-- 'NorthDakota','763724','2019'		88,972	Growth rate = 1%
		-- 'SouthDakota','887127','2019'		70,934	Growth rate = 8%
		-- 'Delaware','976668','2019'			77,021	Growth rate = 8%
		-- 'RhodeIsland','1058158','2019'		4,164	Growth rate = 0.3%
		-- 'Montana','1070123','2019'			79,393	Growth rate = 8%
		-- 'Maine','1345770','2019'				18,119	Growth rate = 1%
        
SELECT (15585/(580116-15585)) * 100;
SELECT (-1840/(624046-1840)) * 100;
SELECT (102971/(708253-102971)) * 100;
SELECT (19621/(733603-19621)) * 100;
SELECT (88972/(7633724-88972)) * 100;
SELECT (70934/(887127-70934)) * 100;
SELECT (77021/(976668-77021)) * 100;
SELECT (4164/(1058158-4164)) * 100;
SELECT (79393/(1070123-79393)) * 100;
SELECT (18119/(1345770-18119)) * 100;


SELECT 'Wyoming' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Wyoming' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Wyoming' AND `Year` = 2010);

SELECT 'Vermont' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Vermont' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Vermont' AND `Year` = 2010);

SELECT 'DistrictofColumbia' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'DistrictofColumbia' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'DistrictofColumbia' AND `Year` = 2010);

SELECT 'Alaska' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Alaska' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Alaska' AND `Year` = 2010);

SELECT 'NorthDakota' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'NorthDakota' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'NorthDakota' AND `Year` = 2010);

SELECT 'SouthDakota' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'SouthDakota' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'SouthDakota' AND `Year` = 2010);

SELECT 'Delaware' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Delaware' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Delaware' AND `Year` = 2010);

SELECT 'RhodeIsland' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'RhodeIsland' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'RhodeIsland' AND `Year` = 2010);

SELECT 'Montana' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Montana' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Montana' AND `Year` = 2010);

SELECT 'Maine' AS State_Name,
(SELECT Population
FROM State_Population
WHERE State_Name = 'Maine' AND `year` = 2019)
-
(SELECT Population
FROM State_Population
WHERE State_Name = 'Maine' AND `Year` = 2010);

-- Now that have our population change information for the lowest populated states, lets start determining if there are any trends. 
-- HIGHEST POPULATION STATE (GROWTH RATE)
-- 'California'		 growth rate = 5%				 
-- 'Texas'			 growth rate = 14%
-- 'Florida'		 growth rate = 14%
-- 'NewYork'		 growth rate = 0.3%
-- 'Pennsylvania',	 growth rate = 0.6%
-- 'Illinois'		 growth rate = -1%
-- 'Ohio',			 growth rate = 1%
-- 'Georgia'		 growth rate = 9%
-- 'NorthCarolina'	 growth rate = 9%
-- 'Michigan'	 	 growth rate = 1%
-- AVERAGE GROWTH RATE = 5.29%
SELECT (5+14+14+0.3+0.6-1+1+9+9+1)/10;


-- LOWEST POPULATION STATES (GROWTH RATE)
-- 'Wyoming',				Growth rate = 2%
-- 'Vermont','				Growth rate = -0.2%
-- 'DistrictofColumbia',	Growth rate = 17%
-- 'Alaska',				Growth rate = 2%
-- 'NorthDakota','			Growth rate = 1%
-- 'SouthDakota','			Growth rate = 8%
-- 'Delaware','				Growth rate = 8%
-- 'RhodeIsland','			Growth rate = 0.3%
-- 'Montana','				Growth rate = 8%
-- 'Maine','				Growth rate = 1%
-- AVERAGE GROWTH RATE = 4.71%
SELECT (2-0.2+17+2+1+8+8+0.3+8+1)/10;


-- LOWEST INCOME STATES (PERCAPITA INCOME GROWTH)
-- '39062','Mississippi','2019'		$7,778 growth rate = 24%
-- '42500','WestVirginia','2019'	$9,736 growth rate =29%
-- '43121','NewMexico','2019'		$9,407 growth rate =27%
-- '43881','Kentucky','2019'		$10,467 growth rate =31%
-- '43996','Alabama','2019'			$10,033 growth rate =29%
-- '44788','Arkansas','2019'		$12,421 growth rate =65%
-- '45455','SouthCarolina','2019'	$12,617 growth rate =66%
-- '45741','Idaho','2019'			$13,365 growth rate =67%
-- '45808','Arizona','2019'			$11,960 growth rate =66%
-- '47660','NorthCarolina','2019'	$11,800 growth rate =69%
-- AVERAGE INCOME GROWTH RATE = 47.3%
SELECT (24+29+27+31+29+65+66+67+66+69)/10;


-- HIGHEST INCOME STATES (PERCAPITA INCOME GROWTH)
-- '80819','DistrictofColumbia','2019'	$17,502 growth rate= 27%
-- '75794','Connecticut','2019'			$14,032 growth rate= 22%
-- '73477','Massachusettes','2019'		$20,558 growth rate= 38%
-- '69951','NewYork','2019'				$21,133 growth rate= 43%
-- '69626','NewJersey','2019'			$18,495 growth rate= 36%
-- '64513','California','2019'			$21,264 growth rate= 49%
-- '63785','NewHamshire','2019'			$16,677 growth rate= 35%
-- '63021','Washington','2019'			$20,669 growth rate= 48%
-- '62989','Maryland','2019'			$13,298 growth rate= 26%
-- '61742','Alaska','2019'				$12,088 growth rate= 24%
-- AVERAGE INCOME GROWTH RATE = 34.8%
SELECT (27+22+38+43+36+49+35+48+26+24)/10;



-- What can we interpret from the information above?
-- The information above can express a few different details about the high end of the USA and the low end. 
-- We can see that the average growt rate for the top 10 states with the highest population is around 0.5 percent greater than the lowest top 10 states. 
-- We can also see that despite the fact that the lowest income states has an average over 10 percent higher than the top 10 income states, their highest income increase was lower than the 10th place for the high income states. 
-- We can conclude from these data, that the top 10 states are not only growing slight faster, but their income growth, despite being a lower average increase percentage, vastly outweighs even the most growth for the lower 10 states. 
-- Another interesting point to bring up is that out of all of the states listed above, the only state to appear on both the most populated, AND the highest income states is California. 
-- This would mean that high population numbers, does not yield high average income. 


-- Lets add some information from our State_Income table to see if it makes us see something significant. 
-- 'Vermont','34570','2019'		Difference = 8430
-- 'Wyoming','35425','2019'		Difference = 9096
-- 'NorthDakota','44420','2019'		Difference =14539
-- 'Alaska','45294','2019'		Difference =9842
-- 'Arizona','45294','2019'			Difference =9842
-- 'SouthDakota','48548','2019'		Difference =14744
-- 'Delaware','52538','2019'		Difference =NULL
-- 'Montana','53613','2019'		Difference =17553
-- 'DistrictofColumbia','57240','2019'		Difference =18916
-- 'Maine','67856','2019'		Difference =17252

SELECT 'Vermont' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Vermont' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Vermont' AND `Year` = 2010);

SELECT 'Wyoming' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Wyoming' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Wyoming' AND `Year` = 2010);

SELECT 'NorthDakota' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'NorthDakota' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'NorthDakota' AND `Year` = 2010);

SELECT 'Alaska' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Alaska' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Alaska' AND `Year` = 2010);


SELECT 'Arizona' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Arizona' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Arizona' AND `Year` = 2010);

SELECT 'SouthDakota' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'SouthDakota' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'SouthDakota' AND `Year` = 2010);


SELECT 'Delware' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Delware' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Delware' AND `Year` = 2010);

SELECT 'Montana' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Montana' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Montana' AND `Year` = 2010);


SELECT 'Districtof Columbia' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'DistrictofColumbia' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'DistrictofColumbia' AND `Year` = 2010);

SELECT 'Maine' AS State_Name,
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Maine' AND `year` = 2019)
-
(SELECT Amount
FROM State_Income
WHERE State_Name = 'Maine' AND `Year` = 2010);

-- Conclusively, this project will more than likely require far more time than I previously anticipated.
-- Ideally, I would look into the information above for all years for each of the states, however more time is required for this effort. 

















        
	
        

		









































 























