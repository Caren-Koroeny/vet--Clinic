/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
   ('Agumon', '2020-02-03', 0, true, 10.23),
   ('Gabumon', '2018-11-15', 2, true, 8),
   ('Pikachu', '2021-01-07', 1, false, 15.04),
   ('Devimon', '2017-05-12', 5, true, 11);

-- update table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander','2020-02-08', 0, false,  -11),
('Plantmon','2021-11-15', 2, true,  -5.7),
('Squirtle','1993-04-02', 3, false,  -12.13),
('Angemon','2005-06-12', 1, true,  -45),
('Boarmon','2005-06-07', 7, true,  20.4),
('Blossom','1998-10-13', 3, true,  17),
('Ditto','2022-05-14', 4, true,  22);

INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Jodie Whittaker', 38);

-- Update insert data into the species table
INSERT INTO species(name) Values('Pokemon');
INSERT INTO species(name) Values('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- Start the transaction for modifying the species_id column in animals table


BEGIN;
-- If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
-- All other animals are Pokemon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';
-- Update commit the transaction to make sure it persists
COMMIT;

-- Modify your inserted animals to include owner information (owner_id)
-- Update start the transaction for adding owner id to animals table
Begin;

-- Update Sam Smith owns Agumon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name IN ('Agumon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon','Pikachu');