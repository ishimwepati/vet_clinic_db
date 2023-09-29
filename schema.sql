/* Database schema to keep the structure of entire database. */

-- DROP TABLE IF EXISTS public.animals;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY, 
    name text, 
    date_of_birth date, 
    escape_attempts integer,
    neutered boolean, 
    weight_kg decimal, 
    species text );

ALTER TABLE animals ADD COLUMN species text;

CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name varchar(255),
    age integer
);

CREATE TABLE species (
    id serial PRIMARY KEY,
    name varchar(255)
);

-- Below are what I did to achieve this :
/* 
Modify animals table:
Make sure that id is set as autoincremented PRIMARY KEY
Remove column species
Add column species_id which is a foreign key referencing species table
Add column owner_id which is a foreign key referencing the owners table
*/

-- I created a new "animals" table with the structure below :
CREATE TABLE animals_new (
    id serial PRIMARY KEY,
    name text,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species_id integer REFERENCES species(id),
    owner_id integer REFERENCES owners(id)
);

-- Then I Copied data from the old table to the new one
INSERT INTO animals_new (name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id)
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, NULL, NULL FROM animals;

-- After I Droped the old "animals" table
DROP TABLE animals;

-- Lastly I renamed the new table to "animals"
ALTER TABLE animals_new RENAME TO animals;


CREATE TABLE vets (
    id serial PRIMARY KEY,
    name varchar(255),
    age integer,
    date_of_graduation date
);

CREATE TABLE specializations (
    vet_id integer REFERENCES vets(id),
    species_id integer REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    vet_id integer REFERENCES vets(id),
    animal_id integer REFERENCES animals(id),
    visit_date date,
    PRIMARY KEY (vet_id, animal_id, visit_date)
);
