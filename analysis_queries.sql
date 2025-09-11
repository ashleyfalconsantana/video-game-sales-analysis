/* 
Business Question 1: How has the video game industry changed over time?
*/

-- sales trend by genre over time
SELECT
	Year,
	Genre,
	SUM(Global_Sales) AS TotalGlobalSales
FROM
	cleaned_vgsales
GROUP BY
	Year,
	Genre
ORDER BY
	Year ASC,
	TotalGlobalSales DESC;

-- sales trends by publisher over time
SELECT
	Year,
	Publisher_clean,
	SUM(Global_Sales) AS TotalGlobalSales
FROM
	cleaned_vgsales
GROUP BY
	Year,
	Publisher_clean
ORDER BY
	Year ASC,
	TotalGlobalSales DESC;

/*
Which gaming platforms were the most successful?
*/
SELECT
	Platform,
	SUM(Global_Sales) AS TotalGlobalSales
FROM
	cleaned_vgsales
GROUP BY
	Platform
ORDER BY
	TotalGlobalSales DESC;

/* 
Which games and genres dominate in America, Europe, and Japan?
*/

-- America
SELECT
	Name,
	Genre,
	NA_Sales
FROM
	cleaned_vgsales
ORDER BY
	NA_Sales DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;

-- Europe
SELECT
	Name,
	Genre,
	EU_Sales
FROM
	cleaned_vgsales
ORDER BY
	EU_Sales DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;

-- Japan
SELECT 
	Name,
	Genre,
	JP_Sales
FROM
	cleaned_vgsales
ORDER BY
	JP_Sales DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;

/*
What publisher consistenly produces top-selling games?
*/
-- identify the top 10 publishers by total sales
SELECT
	Publisher_clean,
	SUM(GLobal_Sales) AS TotalGlobalSales
FROM
	cleaned_vgsales
GROUP BY
	Publisher_clean
ORDER BY
	TotalGlobalSales DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

-- identify the publishers with the most individual top-selling games
SELECT
	Publisher_clean,
	COUNT(*) AS NumberOfTopGames
FROM
	(
		SELECT 
			Publisher_clean
		FROM
			cleaned_vgsales
		ORDER BY
			Global_Sales DESC
		OFFSET 0 ROWS
		FETCH NEXT 500 ROWS ONLY
	) AS TopGames
GROUP BY
	Publisher_clean
ORDER BY
	NumberOfTopGames DESC;
