select *
from ProjectPortfolio..CovidDeaths
order by 3,4

--select *
--from ProjectPortfolio..CovidVaccinations
--order by 3,4;

select location,date,total_cases,new_cases, total_deaths,population
from ProjectPortfolio..CovidDeaths
order by 1,2;

select location, date, total_cases, total_deaths, (total_deaths / total_cases ) * 100 as DeathsPercentage
from ProjectPortfolio..CovidDeaths
where location = 'Afghanistan' and date > '2020-03-01'
order by 1,2;

--, (total_deaths / total_cases ) * 100 as DeathsPercentage

select location, date, total_cases, total_deaths, (total_deaths / total_cases ) * 100 as DeathsPercentage
from ProjectPortfolio..CovidDeaths
where location like '%pak%' and total_cases > 0
order by 1,2;

-- cases vs population what percentage of population got covid

select location, date, total_cases, total_deaths, population, (total_cases / population ) * 100 as InfectedPopulationPercent
from ProjectPortfolio..CovidDeaths
where location like '%pak%'
order by 1,2;

-- highest infected rate vs population

select location, population, Max(total_cases) as MaxCasesCount, Max((total_cases / population )) * 100 as InfectedPopulationPercent
from ProjectPortfolio..CovidDeaths
group by location, population
order by InfectedPopulationPercent desc;

-- countries with highest deaths 

select location, Max(cast(total_deaths as int)) as MaxDeathsCount
from ProjectPortfolio..CovidDeaths
where continent is not null
group by location
order by MaxDeathsCount desc;


-- by continent

select continent, Max(total_deaths) as MaxDeathsCount
from ProjectPortfolio..CovidDeaths
where continent is not null
group by continent
order by MaxDeathsCount desc;


select continent, Max(total_deaths) as MaxDeathsCount
from ProjectPortfolio..CovidDeaths
group by continent
order by MaxDeathsCount desc;


-- entire world

select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths) / sum(new_cases) * 100 as DeathsPercentage
from ProjectPortfolio..CovidDeaths
where new_cases > 0
group by date
order by 1,2;

select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths) / sum(new_cases) * 100 as DeathsPercentage
from ProjectPortfolio..CovidDeaths
--where new_cases > 0
order by 1,2;

--  Covid Vaccination 

select *
from [dbo].[CovidVaccinations]

select *
from ProjectPortfolio..CovidDeaths dea
join ProjectPortfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
order by dea.date asc;

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
from ProjectPortfolio..CovidDeaths dea
join ProjectPortfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3;


select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
from ProjectPortfolio..CovidDeaths dea
join ProjectPortfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where vac.new_vaccinations is not null and dea.continent is not null
order by 2,3;

--select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
--sum(convert(int,vac.new_vaccinations)) over(partition by dea.location)
--from ProjectPortfolio..CovidDeaths dea
--join ProjectPortfolio..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where vac.new_vaccinations is not null and dea.continent is not null
--order by 2,3;

-- Rolling Sum

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(float,vac.new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as total_vaccinated
from ProjectPortfolio..CovidDeaths dea
join ProjectPortfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where vac.new_vaccinations is not null and dea.continent is not null
order by 2,3;



--   CTEs
with PopulationVsVaccination (continent,location,date,population,new_vaccinations,total_vaccinated)
as (
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(float,vac.new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as total_vaccinated
from ProjectPortfolio..CovidDeaths dea
join ProjectPortfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where vac.new_vaccinations is not null and dea.continent is not null
)
select * 
from PopulationVsVaccination
order by 2,3;

-- Temporary Tables

drop table if exists #PercentPopVsVac
create table #PercentPopVsVac
(
Continent nvarchar(50),
Location nvarchar(50),
Date datetime,
Population numeric,
NewVaccinations float,
TotalVaccinated numeric
)
insert into #PercentPopVsVac
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(float,vac.new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as total_vaccinated
from ProjectPortfolio..CovidDeaths dea
join ProjectPortfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
 where vac.new_vaccinations is not null

select * 
from #PercentPopVsVac
order by 2,3;


-- Creating Views

use ProjectPortfolio
go
create view Percent_Pop_vs_Vac as
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(float,vac.new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as total_vaccinated
from ProjectPortfolio..CovidDeaths dea
join ProjectPortfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
 where vac.new_vaccinations is not null

 select *
 from Percent_Pop_vs_Vac
 order by 2,3;

