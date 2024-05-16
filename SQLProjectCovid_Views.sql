--Creating view for visualization of life expectancy vs deaths
CREATE VIEW LifeExp_Deaths AS
SELECT v.location,
       v.life_expectancy,
       MAX(CAST(d.total_deaths AS INT))/MAX(d.total_cases) as death_rate
FROM CovidVaccinations v
JOIN CovidDeaths d 
	ON v.date = d.date AND v.location = d.location
WHERE v.continent IS NOT NULL
AND d.continent IS NOT NULL
GROUP BY v.location, v.life_expectancy
GO

--Extreme poverty vs deaths
CREATE VIEW ExtrPovVsDeaths AS
SELECT v.location, 
       v.extreme_poverty, 
       MAX(CAST(d.total_deaths AS INT))/MAX(d.total_cases) as death_rate 
FROM CovidVaccinations v
JOIN CovidDeaths d ON v.date = d.date AND v.location = d.location
WHERE d.continent IS NOT NULL AND v.continent IS NOT NULL
GROUP BY v.location, v.extreme_poverty
GO

--Beds per thousand vs death rate
CREATE VIEW BedsVsDeathRate AS
SELECT v.location, v.hospital_beds_per_thousand, MAX(CAST(d.total_deaths AS INT))/MAX(d.total_cases) as death_rate
FROM CovidVaccinations v
JOIN CovidDeaths d 
	ON v.date = d.date AND v.location = d.location
WHERE v.continent IS NOT NULL
AND d.continent IS NOT NULL
GROUP BY v.location, v.hospital_beds_per_thousand
GO


--Handwashing facilties vs death rate
CREATE VIEW HandwashingFacVsDeathRate AS
SELECT v.location, v.handwashing_facilities, MAX(CAST(d.total_deaths AS INT))/MAX(d.total_cases) as death_rate
FROM CovidVaccinations v
JOIN CovidDeaths d 
	ON v.date = d.date AND v.location = d.location
WHERE v.continent IS NOT NULL
AND d.continent IS NOT NULL
GROUP BY v.location, v.handwashing_facilities
GO

