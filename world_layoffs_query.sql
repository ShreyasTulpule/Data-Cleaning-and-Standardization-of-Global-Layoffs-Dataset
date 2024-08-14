# Data Cleaning and Standardization of Global Layoffs Dataset

use world_layoffs;
select * from layoffs;

## STEP 1 => CREATE A STAGING TABLE TO MAKING ANY CHANGES SO RAW DATA IS NOT DAMAGED 

create table layoff_staging
like layoffs;

INSERT INTO layoff_staging
SELECT * FROM layoffs;

SELECT * FROM layoff_staging;


## STEP 2 => REMOVE DUPLICATES IF ANY

-- Use a CTE to assign unique row numbers based on all columns
with duplicate_cte as
(
	select *,
	row_number() 
	over
	(partition by company, location, industry, total_laid_off, percentage_laid_off, 
		`date`, stage, country, funds_raised_millions) as row_num
	from layoff_staging
)

-- viewing duplicates with row_num > 1
select *
from duplicate_cte
where row_num >1;

-- View data for a specific company (example: Casper)
select * 
from layoff_staging
WHERE company = 'Casper';

-- Create a new table with an additional row_num column
CREATE TABLE `layoff_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_staging_2;

insert into layoff_staging_2
select *,
row_number() 
over
	(partition by company, location, industry, total_laid_off, percentage_laid_off, 
		`date`, stage, country, funds_raised_millions) as row_num
from layoff_staging;

select * 
from layoff_staging_2
where row_num > 1;

-- delete all duplicates
delete 
from layoff_staging_2
where row_num > 1;

select * 
from layoff_staging_2
where row_num > 1;


## STEP 3 => STANDARDIZE THE DATA 

-- Trim whitespace from text fields
select company
from layoff_staging_2;

update layoff_staging_2
set company = trim(company),
	industry = trim(industry);

-- Standardize industry names ie Checking for multiple variations of industry names for a single industry
select DISTINCT industry
from layoff_staging_2
ORDER BY 1;

select * 
from layoff_staging_2
where industry like 'Crypto%';

update layoff_staging_2
set industry = 'Crypto'
where industry like 'Crypto%';

-- Checking for multiple variations of country names for a single country
select DISTINCT country
from layoff_staging_2
ORDER BY 1;

select * 
from layoff_staging_2
where country like 'United States%';

update layoff_staging_2
set country = 'United States'
where country like 'United States%';

-- Change date column datatype from TEXT to DATE
update layoff_staging_2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoff_staging_2
modify column `date` DATE;


## STEP 4 => CHECK NULL AND BLANK VALUES TO CHEKC IF YOU CAN POPULATE THAT OR NOT

-- Identify rows with NULL or blank values
select * 
from layoff_staging_2
where total_laid_off is NULL
and percentage_laid_off is NULL;

select * 
from layoff_staging_2
where industry is NULL
OR industry = '';

-- chnange blank values ot null
UPDATE layoff_staging_2
set industry = NULL
where industry = '';

-- Fill missing industry values based on other records
SELECT *
FROM layoff_staging_2 as t1
join layoff_staging_2 as t2
	on t1.company = t2.company
    and  t1.location = t2.location
where (t1.industry is null)
and t2.industry is not null
;

update layoff_staging_2 as t1
join layoff_staging_2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null)
and t2.industry is not null
;


## STEP 5 => REMOVE UNNECCESARY COLUMNS AND ROWS

select * 
from layoff_staging_2
where total_laid_off is NULL
and percentage_laid_off is NULL;

DELETE	
FROM layoff_staging_2
where total_laid_off is NULL
and percentage_laid_off is NULL;

Alter table layoff_staging_2
Drop column row_num;

select * from layoff_staging_2;