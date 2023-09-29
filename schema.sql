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

-- First, i setted "id" as autoincremented PRIMARY KEY
ALTER TABLE animals
ALTER COLUMN id SET GENERATED ALWAYS AS IDENTITY;

-- Next, I removed the column "species"
ALTER TABLE animals
DROP COLUMN species;

-- Then I added column "species_id" as a foreign key referencing "species" table
ALTER TABLE animals
ADD COLUMN species_id integer REFERENCES species(id);

-- LAslty I added column "owner_id" as a foreign key referencing "owners" table
ALTER TABLE animals
ADD COLUMN owner_id integer REFERENCES owners(id);
