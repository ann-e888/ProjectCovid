CREATE VIEW Cumulative_cases AS
SELECT date, new_cases, 
		sum(new_cases) OVER (order by date rows unbounded preceding) AS cumulative_cases
FROM CovidDeaths
WHERE location = 'World'
GO

CREATE VIEW Cumulative_cases_continents
SELECT location, date, new_cases, 
		sum(new_cases) OVER (PARTITION BY location ORDER BY date) AS cumulative_cases
FROM CovidDeaths 
WHERE location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia')

CREATE VIEW Cumulative_deaths AS
SELECT date, new_deaths, 
		sum(new_cases) OVER (ORDER BY date ROWS UNBOUNDED PRECEDING) AS cumulative_deaths
FROM CovidDeaths 
WHERE location = 'World'
GO

CREATE VIEW Cumulative_vaccinations AS
SELECT date, new_vaccinations, 
		sum(new_vaccinations) OVER (ORDER BY date ROWS UNBOUNDED PRECEDING) AS cumulative_vaccinations,
		people_fully_vaccinated
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

