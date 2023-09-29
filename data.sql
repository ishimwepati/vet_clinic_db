/* Populate database with sample data. */
INSERT INTO animals 
(name,date_of_birth,escape_attempts,neutered,weight_kg) 

VALUES 
('Agumon','2020/02/03',0,true,10.23), 
('Gabumon','2018/11/15',2,true, 8),
('Pikachu','2021/01/07',1,false,15.04),
('Devimon','2017/05/12',5,true,11) ; 

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
    ('Charmander', '2020-02-08', 0, false, -11),
    ('Plantmon', '2021-11-15', 2, true, -5.7),
    ('Squirtle', '1993-04-02', 3, true, -12.13),
    ('Angemon', '2005-06-12', 1, true, -45),
    ('Boarmon', '2005-06-07', 7, true, 20.4),
    ('Blossom', '1998-10-13', 3, true, 17),
    ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

UPDATE animals
SET species_id = (
    CASE 
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);

-- Update animals owned by Sam Smith
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';

-- Update animals owned by Jennifer Orwell
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');

-- Update animals owned by Bob
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');

-- Update animals owned by Melody Pond
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Update animals owned by Dean Winchester
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('Vet William Tatcher', 45, '2000-04-23'),
    ('Vet Maisy Smith', 26, '2019-01-17'),
    ('Vet Stephanie Mendez', 64, '1981-05-04'),
    ('Vet Jack Harkness', 38, '2008-06-08');

-- Find the vet IDs based on vet names
INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
JOIN species s ON s.name = 'Pokemon'
WHERE v.name = 'Vet William Tatcher';

INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
JOIN species s ON s.name = 'Digimon'
WHERE v.name = 'Vet Stephanie Mendez';

INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
JOIN species s ON s.name = 'Pokemon'
WHERE v.name = 'Vet Stephanie Mendez';

INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
JOIN species s ON s.name = 'Digimon'
WHERE v.name = 'Vet Jack Harkness';

-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-05-24'::date
FROM vets v
JOIN animals a ON a.name = 'Agumon'
WHERE v.name = 'Vet William Tatcher';

-- Agumon visited Stephanie Mendez on Jul 22nd, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-07-22'::date
FROM vets v
JOIN animals a ON a.name = 'Agumon'
WHERE v.name = 'Vet Stephanie Mendez';

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2021-02-02'::date
FROM vets v
JOIN animals a ON a.name = 'Gabumon'
WHERE v.name = 'Vet Jack Harkness';

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-01-05'::date
FROM vets v
JOIN animals a ON a.name = 'Pikachu'
WHERE v.name = 'Vet Maisy Smith';

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-03-08'::date
FROM vets v
JOIN animals a ON a.name = 'Pikachu'
WHERE v.name = 'Vet Maisy Smith';

-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-05-14'::date
FROM vets v
JOIN animals a ON a.name = 'Pikachu'
WHERE v.name = 'Vet Maisy Smith';

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2021-05-04'::date
FROM vets v
JOIN animals a ON a.name = 'Devimon'
WHERE v.name = 'Vet Stephanie Mendez';

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2021-02-24'::date
FROM vets v
JOIN animals a ON a.name = 'Charmander'
WHERE v.name = 'Vet Jack Harkness';

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2019-12-21'::date
FROM vets v
JOIN animals a ON a.name = 'Plantmon'
WHERE v.name = 'Vet Maisy Smith';

-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-08-10'::date
FROM vets v
JOIN animals a ON a.name = 'Plantmon'
WHERE v.name = 'Vet William Tatcher';

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2021-04-07'::date
FROM vets v
JOIN animals a ON a.name = 'Plantmon'
WHERE v.name = 'Vet Maisy Smith';

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2019-09-29'::date
FROM vets v
JOIN animals a ON a.name = 'Squirtle'
WHERE v.name = 'Vet Stephanie Mendez';

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-10-03'::date
FROM vets v
JOIN animals a ON a.name = 'Angemon'
WHERE v.name = 'Vet Jack Harkness';

-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-11-04'::date
FROM vets v
JOIN animals a ON a.name = 'Angemon'
WHERE v.name = 'Vet Jack Harkness';

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2019-01-24'::date
FROM vets v
JOIN animals a ON a.name = 'Boarmon'
WHERE v.name = 'Vet Maisy Smith';

-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2019-05-15'::date
FROM vets v
JOIN animals a ON a.name = 'Boarmon'
WHERE v.name = 'Vet Maisy Smith';

-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-02-27'::date
FROM vets v
JOIN animals a ON a.name = 'Boarmon'
WHERE v.name = 'Vet Maisy Smith';

-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-08-03'::date
FROM vets v
JOIN animals a ON a.name = 'Boarmon'
WHERE v.name = 'Vet Maisy Smith';

-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2020-05-24'::date
FROM vets v
JOIN animals a ON a.name = 'Blossom'
WHERE v.name = 'Vet Stephanie Mendez';

-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (vet_id, animal_id, visit_date)
SELECT v.id, a.id, '2021-01-11'::date
FROM vets v
JOIN animals a ON a.name = 'Blossom'
WHERE v.name = 'Vet William Tatcher';
