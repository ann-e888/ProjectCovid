CREATE VIEW Cumulative_cases AS
SELECT date, new_cases, 
		sum(new_cases) over (order by date rows unbounded preceding) as cumulative_cases
FROM CovidDeaths$ 
WHERE continent IS NULL 
AND location = 'World'
GO

SELECT * FROM Cumulative_cases

CREATE VIEW Cumulative_deaths AS
SELECT date, new_deaths, 
		sum(new_cases) over (order by date rows unbounded preceding) as cumulative_deaths
FROM CovidDeaths$ 
WHERE continent IS NULL 
AND location = 'World'
GO

SELECT * FROM Cumulative_deaths

CREATE VIEW Total_deaths AS
SELECT MAX(CAST(total_deaths AS INT)) as death_count
FROM CovidDeaths$
WHERE continent IS NULL
AND location = 'World'
GO

SELECT * FROM Total_deaths

CREATE VIEW Total_cases AS
SELECT MAX(CAST(total_cases AS INT)) as cases_count
FROM CovidDeaths$
WHERE continent IS NULL
AND location = 'World'
GO

SELECT * FROM Total_cases

