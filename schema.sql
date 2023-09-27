/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic
    WITH
    OWNER = wazacode
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

    
CREATE TABLE animals (
    name varchar(100)
);
