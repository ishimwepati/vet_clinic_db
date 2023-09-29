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
