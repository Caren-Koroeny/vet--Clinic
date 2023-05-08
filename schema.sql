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

-- Day 3 query multiple table day
-- Update drop table to make sure it does not exist
DROP TABLE IF EXISTS owners;

-- Update create the owners table row
CREATE TABLE IF NOT EXISTS owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

-- Update drop table to make sure it does not exist
DROP TABLE IF EXISTS species;
-- Update create species table
CREATE TABLE IF NOT EXISTS species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(40),
    PRIMARY KEY(id)
);
-- Update remove the species column from the animals table
ALTER TABLE animals DROP COLUMN species CASCADE;

-- Update started the transaction for creating specied_id column to table
BEGIN;
-- Update Add column species_id to animals table
ALTER TABLE animals ADD COLUMN species_id INT;
-- Update made the species_id column a foreign key referencing species table
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id);
-- Update commited changes after making sure everything is fine
COMMIT;
-- Update started the transaction for creating owner_id column to table
BEGIN;
-- Update add a column called owber_id to animals table
ALTER TABLE animals ADD COLUMN owner_id INT;
-- Update made the owner_id a foreign key referencing the owners table
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);
-- Update commited changes after making sure everything is fine
COMMIT;

--DAY 4
-- Create table called vets

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar NOT NULL,
    date_of_graduation date NOT NULL,
    age INT DEFAULT 0,
    PRIMARY KEY(id)
);

-- create specializations table with many-to-many relationship between species and vets
CREATE TABLE specializations(
  species_id INT,
  vet_id INT,
  FOREIGN KEY(species_id) REFERENCES species(id),
  FOREIGN KEY(vet_id) REFERENCES vets(id),
  PRIMARY KEY (species_id, vet_id)
);
-- create visits table with many-to-many relationship between animals and vets
CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animals INT REFERENCES animals(id),
  vets INT REFERENCES vets (id),
  date_of_visit date
);

/* Vet clinic database: database performance audit */

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';