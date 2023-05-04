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

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon','Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander','Squirtle','Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon','Boarmon');

-- Day 4

INSERT INTO vets(name,age,date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations(species_id,vet_id)
SELECT species.id, vets.id FROM species JOIN vets ON species.name = 'Pokemon' AND vets.name = 'William Tatcher';
INSERT INTO specializations(species_id,vet_id)
SELECT species.id, vets.id FROM species JOIN vets ON species.name = 'Digimon' AND vets.name = 'Stephanie Mendez';
INSERT INTO specializations(species_id,vet_id)
SELECT species.id, vets.id FROM species JOIN vets ON species.name = 'Pokemon' AND vets.name = 'Stephanie Mendez';
INSERT INTO specializations(species_id,vet_id)
SELECT species.id, vets.id FROM species JOIN vets ON species.name = 'Digimon' AND vets.name = 'Jack Harkness';

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Agumon'),
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  '2020-05-24' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Agumon'),
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  '2020-07-22' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Pikachu'),
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  '2020-01-05' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Pikachu'),
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  '2020-03-08' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Pikachu'),
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  '2020-05-14' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Devimon'),
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  '2021-05-04' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Charmander'),
  (SELECT id FROM vets WHERE name = 'Jack Harkness'),
  '2021-02-24' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Plantmon'),
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  '2019-12-21' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Plantmon'),
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  '2020-08-10' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Plantmon'),
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  '2021-04-07' 
);

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES (
  (SELECT id FROM animals WHERE name = 'Squirtle'),
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  '2019-09-29' 
);