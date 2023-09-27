/* Database schema to keep the structure of entire database. */

-- DROP TABLE IF EXISTS public.animals;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY, 
    name text, 
    date_of_birth date, 
    escape_attempts integer,
    neutered boolean, 
    weight_kg decimal );

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.animals
    OWNER to wazacode;