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
--Update made the id column the Primary key for the table
ALTER TABLE animals ADD PRIMARY KEY(id);
-- Update made the id of animals table be auto incremented
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
--Update Add a column species of type string to your animals table.
ALTER TABLE animals ADD COLUMN species VARCHAR(80);

ALTER TABLE animals
  ADD species VARCHAR;