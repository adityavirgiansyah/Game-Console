-- Calculate what % of Global Sales were made in north america?

SELECT
	*
FROM
	PortofolioProject.dbo.['P9-ConsoleGames2$']

ALTER TABLE ['P9-ConsoleGames2$']
ADD global_sales FLOAT NULL;

UPDATE ['P9-ConsoleGames2$']
SET global_sales = NA_Sales + EU_Sales + JP_Sales + Other_Sales

ALTER TABLE ['P9-ConsoleGames2$']
ADD global_NA_sales_percentage FLOAT NULL;

UPDATE ['P9-ConsoleGames2$']
SET global_NA_sales_percentage = NA_Sales / global_sales * 100
WHERE global_sales > 0

-- Extract a view of the console game titles ordered by platform name in ascending order and year release in desending order

SELECT
	[Name],
	[Platform]
FROM
	PortofolioProject.dbo.['P9-ConsoleGames2$']
ORDER BY [Platform] ASC

SELECT
	[Name],
	[Year]
FROM
	PortofolioProject.dbo.['P9-ConsoleGames2$']
ORDER BY [Year] DESC

-- For each game title extract the first four letters of the publisher's name

SELECT
	SUBSTRING([Publisher], 1, 4)
FROM
	PortofolioProject.dbo.['P9-ConsoleGames2$']

-- Display all console platforms which were released either just before Black Friday or just before Christmas (in any year)

SELECT
	[Platform],
	FirstRetailAvailability
FROM
	PortofolioProject.dbo.['P9-ConsoleDates$']
WHERE
	(FirstRetailAvailability BETWEEN '1983-11-25' AND '2013-12-25')

-- Order the platform by longevity in ascending order (i.e the flatforms which was available for the longest at the bottom)

SELECT
	[Platform],
	FirstRetailAvailability,
	Discontinued,
	DATEDIFF(YEAR, FirstRetailAvailability, Discontinued) as Longevity
FROM
	PortofolioProject.dbo.['P9-ConsoleDates$']
WHERE
	Discontinued IS NOT NULL
ORDER BY 
	Longevity ASC

-- Demonstrate how to deal with the Game_Year column if the client wants to convert in to different data type

SELECT
	CONVERT(VARCHAR, [Year]) as Game_Year
FROM
	PortofolioProject.dbo.['P9-ConsoleGames2$']

-- Provide recommendations on how to deal with missing data in the field

-- i will recommend drop/delete statement or you can replace it

DELETE FROM PortofolioProject.dbo.['P9-ConsoleGames2$']
WHERE COALESCE ([Rank], [Name], [Platform], [Year], [Genre], [Publisher], [NA_Sales], [EU_Sales], [Other_Sales])  IS NULL;


	




