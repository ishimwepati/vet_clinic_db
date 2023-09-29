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


-- Here I count the total number of animals in the table
SELECT COUNT(*) FROM animals;

-- Here I count the animals with zero escape attempts
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- I calculate the average weight of all animals
SELECT AVG(weight_kg) FROM animals;

-- Identify whether neutered or not neutered animals have the most escape attempts
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- Find the minimum and maximum weight for each type of animal (by species)
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- Calculate the average escape attempts for animals born between 1990 and 2000, grouped by species
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

-----------------------
-- What animals belong to Melody Pond?
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

-- List of all animals that are Pokemon (their type is Pokemon).
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those who don't own any animal.
SELECT o.full_name, COALESCE(array_agg(a.name), '{}'::text[]) AS owned_animals FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name;

-- How many animals are there per species?
SELECT s.name AS species, COUNT(*) AS animal_count FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id JOIN owners o ON a.owner_id = o.id WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(a.*) AS animal_count FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;


-------------------------

-- Find the last animal seen by William Tatcher
SELECT a.name AS last_animal_seen_by_William_Tatcher
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
WHERE vet.name = 'Vet William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- Count the number of different animals seen by Stephanie Mendez
SELECT COUNT(DISTINCT v.animal_id) AS animals_seen_by_Stephanie_Mendez
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
WHERE vet.name = 'Vet Stephanie Mendez';

-- List all vets and their specialties, including those with no specialties
SELECT vet.name, COALESCE(species.name, 'No Specialty') AS specialty
FROM vets vet
LEFT JOIN specializations spec ON vet.id = spec.vet_id
LEFT JOIN species ON spec.species_id = species.id;

-- List all animals that visited Stephanie Mendez in a specified date range
SELECT a.name AS animal_name, v.visit_date
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
WHERE vet.name = 'Vet Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- Find the animal with the most visits to vets
SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

-- Find the first animal visited by Maisy Smith
SELECT a.name AS first_visit_animal
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
WHERE vet.name = 'Vet Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

-- Find details of the most recent visit, including animal, vet, and date
SELECT a.name AS animal_name, vet.name AS vet_name, v.visit_date
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
ORDER BY v.visit_date DESC
LIMIT 1;

-- Count the number of visits with vets not specialized in the animal's species
SELECT COUNT(*) AS visits_with_unspecialized_vet
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations spec ON vet.id = spec.vet_id AND spec.species_id = a.species_id
WHERE spec.species_id IS NULL;

-- Find the specialty that Maisy Smith should consider based on the species she sees the most
SELECT s.name AS suggested_specialty
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
JOIN specializations spec ON vet.id = spec.vet_id
JOIN species s ON spec.species_id = s.id
WHERE vet.name = 'Vet Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;

