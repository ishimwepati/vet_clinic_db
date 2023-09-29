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

HERE SSEBO 

BEGIN; -- Start a transaction

-- Update the "species" column for all rows to 'unspecified'
UPDATE animals
SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals; -- View the updated data

-- Roll back the transaction to revert the changes
ROLLBACK;

-- Verify that the species column went back to the state before the transaction
SELECT * FROM animals; -- View the original data

-- End of the script


BEGIN; -- Start a transaction

-- Update animals with names ending in 'mon' to 'digimon'
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update animals with no species already set to 'pokemon'
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Verify the changes within the transaction
SELECT * FROM animals;

COMMIT; -- Commit the transaction

-- Verify that changes persist after commit
SELECT * FROM animals;



BEGIN; -- Start a transaction

-- Delete all records in the "animals" table
DELETE FROM animals;

-- Verify that records are deleted within the transaction
SELECT * FROM animals;

ROLLBACK; -- Roll back the transaction

BEGIN; -- Start a transaction

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT update_weights;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO update_weights;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
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
