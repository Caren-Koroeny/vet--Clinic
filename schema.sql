/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

DROP TABLE IF EXISTS animals;

CREATE TABLE IF NOT EXISTS animals (
    id INT,
    name VARCHAR(80),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC
);

-- Update made the id column not null
ALTER TABLE animals ALTER COLUMN id SET NOT NULL;

ALTER TABLE animals
  ADD species VARCHAR;