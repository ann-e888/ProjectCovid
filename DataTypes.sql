BEGIN TRANSACTION;
GO

-- Update non-numeric values to NULL
UPDATE CovidDeaths
SET 
	population = CASE WHEN ISNUMERIC(population) = 1 THEN population ELSE NULL END,
    total_cases = CASE WHEN ISNUMERIC(total_cases) = 1 THEN total_cases ELSE NULL END,
    new_cases = CASE WHEN ISNUMERIC(new_cases) = 1 THEN new_cases ELSE NULL END,
    new_deaths = CASE WHEN ISNUMERIC(new_deaths) = 1 THEN new_deaths ELSE NULL END,
    total_deaths = CASE WHEN ISNUMERIC(total_deaths) = 1 THEN total_deaths ELSE NULL END,
	new_tests = CASE WHEN ISNUMERIC(total_deaths) = 1 THEN total_deaths ELSE NULL END,
	total_tests = CASE WHEN ISNUMERIC(total_deaths) = 1 THEN total_deaths ELSE NULL END,
    female_smokers = CASE WHEN ISNUMERIC(female_smokers) = 1 THEN female_smokers ELSE NULL END,
    male_smokers = CASE WHEN ISNUMERIC(male_smokers) = 1 THEN male_smokers ELSE NULL END,
    handwashing_facilities = CASE WHEN ISNUMERIC(handwashing_facilities) = 1 THEN handwashing_facilities ELSE NULL END,
    hospital_beds_per_thousand = CASE WHEN ISNUMERIC(hospital_beds_per_thousand) = 1 THEN hospital_beds_per_thousand ELSE NULL END;

UPDATE CovidVaccinations
SET 
    total_vaccinations = CASE WHEN ISNUMERIC(total_vaccinations) = 1 THEN total_vaccinations ELSE NULL END,
    new_vaccinations = CASE WHEN ISNUMERIC(new_vaccinations) = 1 THEN new_vaccinations ELSE NULL END,
    people_vaccinated = CASE WHEN ISNUMERIC(people_vaccinated) = 1 THEN people_vaccinated ELSE NULL END,
	people_fully_vaccinated = CASE WHEN ISNUMERIC(people_fully_vaccinated) = 1 THEN people_fully_vaccinated ELSE NULL END


-- Alter column data types
ALTER TABLE CovidDeaths
ALTER COLUMN total_cases DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN new_cases DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN new_deaths DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN total_deaths DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN new_tests DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN total_tests DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN female_smokers DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN male_smokers DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN handwashing_facilities DECIMAL(18,2) NULL;
ALTER TABLE CovidDeaths
ALTER COLUMN hospital_beds_per_thousand DECIMAL(18,2) NULL;
ALTER TABLE CovidVaccinations
ALTER COLUMN total_vaccinations DECIMAL(18,2) NULL;
ALTER TABLE CovidVaccinations
ALTER COLUMN new_vaccinations DECIMAL(18,2) NULL;
ALTER TABLE CovidVaccinations
ALTER COLUMN people_vaccinated DECIMAL(18,2) NULL;
ALTER TABLE CovidVaccinations
ALTER COLUMN people_fully_vaccinated DECIMAL(18,2) NULL;

COMMIT TRANSACTION;

