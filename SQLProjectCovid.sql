SELECT * FROM CovidDeaths$
ORDER BY 3,4

--SELECT * FROM CovidVaccinations$
--ORDER BY 3,4

--Selecting data to use
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2


--Loking at total_cases vs total_deaths, likelihood of dying
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM CovidDeaths$
WHERE location LIKE '%states%'
AND continent IS NOT NULL
ORDER BY 2


--Looking at total cases vs population
SELECT location, date, total_cases, population, (total_cases/population)*100 as infection_percentage
FROM CovidDeaths$
WHERE location LIKE '%poland%'
AND continent IS NOT NULL
ORDER BY 2

--Looking at countries with highest infection rate vs their population
SELECT location, population, MAX(total_cases) as infection_count, MAX((total_cases/population)*100) as infection_percentage
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY population, location
ORDER BY 4 DESC

--Countries with highest death count per population
SELECT location, MAX(CAST(total_deaths AS INT)) as death_count
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC


--Looking at countires with highest death rate
SELECT location, MAX(CAST(total_deaths AS INT))/MAX(total_cases) as death_rate
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY  location
ORDER BY 2 DESC


--By continent
SELECT location, MAX(CAST(total_deaths AS INT)) as death_count
FROM CovidDeaths$
WHERE continent IS NULL
GROUP BY  location
ORDER BY 2 DESC

--Global numbers of death percentage
SELECT date, SUM(new_cases) cases, SUM(CAST(new_deaths AS INT)) deaths,
SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 as death_percentage
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 4 DESC


--Population vs vaccination, CTE
WITH vac_ratio (
continent, location, date, population, new_vacconations, rolling_count_vaccinations)
as(
SELECT cd.continent, cd.location, cd.date, cd.population,
		cv.new_vaccinations, 
		SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as rolling_count_vaccinations
FROM CovidDeaths$ cd
JOIN CovidVaccinations$ cv
	 ON cd.location = cv.location
	 AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
AND cv.continent IS NOT NULL
)
SELECT *, (rolling_count_vaccinations/population)*100
FROM vac_ratio
ORDER BY 2,3


--Temp table
DROP TABLE IF EXISTS #PopulationVaccinatedPercent
CREATE TABLE #PopulationVaccinatedPercent (
continent nvarchar(255), 
location nvarchar(255), 
date datetime, 
population numeric,
new_vaccination numeric,
rolling_count_vaccinations numeric)

INSERT INTO #PopulationVaccinatedPercent
SELECT cd.continent, cd.location, cd.date, cd.population,
		cv.new_vaccinations, 
		SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as rolling_count_vaccinations
FROM CovidDeaths$ cd
JOIN CovidVaccinations$ cv
	 ON cd.location = cv.location
	 AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
AND cv.continent IS NOT NULL


SELECT *, (rolling_count_vaccinations/population)*100
FROM #PopulationVaccinatedPercent
ORDER BY 2,3

--View
CREATE VIEW PopulationVaccinatedPercent AS
SELECT cd.continent, cd.location, cd.date, cd.population,
		cv.new_vaccinations, 
		SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as rolling_count_vaccinations
FROM CovidDeaths$ cd
JOIN CovidVaccinations$ cv
	 ON cd.location = cv.location
	 AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
AND cv.continent IS NOT NULL
