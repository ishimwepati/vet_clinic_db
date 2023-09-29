/*Queries that provide answers to the questions from all projects.*/

/* Find all animals whose name ends in "mon". */
SELECT * from animals WHERE like '%mon';

/*List the name of all animals born between 2016 and 2019. */
SELECT name from animals WHERE date_of_birth between '2016-01-01' and '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name from animals WHERE neutered = true and escape_attempts < 3;

/*List the date of birth of all animals named either "Agumon" or "Pikachu". */
SELECT date_of_birth FROM animals where (name='Agumon') OR (name='Pikachu');

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name,escape_attempts FROM animals where weight_kg > 10.5;

/*Find all animals that are neutered.*/
SELECT * from animals WHERE neutered = true;

/*Find all animals not named Gabumon.*/
SELECT * FROM animals WHERE name != 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT * from animals WHERE weight_kg between 10.4 and 17.3;


-- Start a transaction
BEGIN; 

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals; 

ROLLBACK;

-- this one Verify that the species column went back to the state before the transaction
SELECT * FROM animals; 
-- End of the script


-- Start a transaction
BEGIN; 

-- this one update animals with names ending in 'mon' to 'digimon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- also this one update animals with no species already set to 'pokemon'
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

COMMIT; 

-- this one verify that changes persist after commit
SELECT * FROM animals;


-- Start a transaction
BEGIN; 

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK; 
SELECT * FROM animals;

-- Start a transaction
BEGIN; 

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT update_weights;
UPDATE animals SET weight_kg = weight_kg * -1;


ROLLBACK TO update_weights;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


-- Count the total number of animals in the table
SELECT COUNT(*) FROM animals;

-- Count the animals with zero escape attempts
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- Calculate the average weight of all animals
SELECT AVG(weight_kg) FROM animals;

-- Identify whether neutered or not neutered animals have the most escape attempts
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- Find the minimum and maximum weight for each type of animal (by species)
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- Calculate the average escape attempts for animals born between 1990 and 2000, grouped by species
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;
