CREATE VIEW Cumulative_cases AS
SELECT date, new_cases, 
		SUM(new_cases) OVER (order by date rows unbounded preceding) AS cumulative_cases
FROM CovidDeaths
WHERE location = 'World'
GO

CREATE VIEW Cumulative_cases_continents AS
SELECT location, date, new_cases, 
		SUM(new_cases) OVER (PARTITION BY location ORDER BY date) AS cumulative_cases
FROM CovidDeaths 
WHERE location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia')
GO 

CREATE VIEW Cumulative_deaths AS
SELECT date, new_deaths, 
		SUM(new_deaths) OVER (ORDER BY date ROWS UNBOUNDED PRECEDING) AS cumulative_deaths
FROM CovidDeaths 
WHERE location = 'World'
GO


CREATE VIEW Cumulative_deaths_continents AS
SELECT location, date, new_deaths, 
		SUM(new_deaths) OVER (PARTITION BY location ORDER BY date) AS cumulative_deaths_continets
FROM CovidDeaths 
WHERE location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia')
GO 


CREATE VIEW Cumulative_vaccinations AS
SELECT date, new_vaccinations, 
		SUM(new_vaccinations) OVER (ORDER BY date ROWS UNBOUNDED PRECEDING) AS cumulative_vaccinations,
		SUM(people_fully_vaccinated) OVER (ORDER BY date ROWS UNBOUNDED PRECEDING) AS people_fully_vaccinated
FROM CovidVaccinations 
WHERE location = 'World'
GO

CREATE VIEW Total_deaths AS
SELECT MAX(CAST(total_deaths AS INT)) AS death_count
FROM CovidDeaths
WHERE location = 'World'
GO

CREATE VIEW Total_cases AS
SELECT MAX(CAST(total_cases AS INT)) AS cases_count
FROM CovidDeaths
WHERE location = 'World'
GO

CREATE VIEW Total_vaccinations AS
SELECT MAX(total_vaccinations) AS vaccinations_count
FROM CovidVaccinations
WHERE location = 'World'
GO

--SELECT DISTINCT(location) FROM CovidDeaths
--WHERE location LIKE '%income%'

CREATE VIEW Total_deaths_location AS
SELECT location, MAX(total_deaths) AS death_count
FROM CovidDeaths
WHERE location NOT IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia', 'World', 
'High income', 'Low income', 'Lower middle income', 'Upper middle income', 'Oceania')
GROUP BY location
GO

CREATE VIEW Total_deaths_continents AS
SELECT location, MAX(total_deaths) AS death_count
FROM CovidDeaths
WHERE location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia', 'Oceania')
GROUP BY location
GO

CREATE VIEW Total_deaths_income AS
SELECT location, MAX(total_deaths) AS death_count
FROM CovidDeaths
WHERE location IN ('High income', 'Low income', 'Lower middle income', 'Upper middle income')
GROUP BY location
GO

CREATE VIEW Total_cases_location AS
SELECT location, 
MAX(CAST(total_cases AS INT)) AS cases_count
FROM CovidDeaths
WHERE location NOT IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia', 'World', 
'High income', 'Low income', 'Lower middle income', 'Upper middle income', 'Oceania')
GROUP BY location
GO

CREATE VIEW Total_cases_continent AS
SELECT location, 
MAX(CAST(total_cases AS INT)) AS cases_count
FROM CovidDeaths
WHERE location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia', 'Oceania')
GROUP BY location
GO