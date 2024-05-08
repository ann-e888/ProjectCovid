CREATE VIEW ShareOfPeopleOver70 AS
SELECT continent, location, MAX(aged_70_older) share_over_70
FROM CovidDeaths
Group BY continent, location
GO

CREATE VIEW HDIvsDeathRate AS
SELECT location, MAX(human_development_index) HDI, ROUND(MAX(total_deaths)/MAX(total_cases),5) as death_rate
FROM CovidDeaths
Group BY continent, location
GO


CREATE VIEW CasesVaccinations AS
SELECT cd.date, 
		SUM(cd.new_cases) OVER (ORDER BY cd.date ROWS UNBOUNDED PRECEDING) AS cumulative_cases,
		SUM(cv.new_vaccinations) OVER (ORDER BY cd.date ROWS UNBOUNDED PRECEDING) AS cumulative_vaccinations
FROM CovidDeaths cd
JOIN CovidVaccinations cv
	ON cv.date = cd.date
	AND cv.location = cd.location
WHERE cd.location = 'World'
GO

CREATE VIEW CasesTests AS
SELECT date, 
		SUM(new_cases) OVER (ORDER BY date ROWS UNBOUNDED PRECEDING) AS cumulative_cases,
		SUM(new_tests) OVER (ORDER BY date ROWS UNBOUNDED PRECEDING) AS cumulative_tests
FROM CovidDeaths 
WHERE location = 'World'
GO

