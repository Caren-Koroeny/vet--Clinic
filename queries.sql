/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon":
SELECT * FROM animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;
-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- start transaction
BEGIN;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
-- Commit the transaction.
COMMIT;
-- Verify that change was made and persists after commit.
SELECT * FROM animals;


-- start transaction
BEGIN;
-- delete all records in the animals table, then roll back the transaction
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
-- after rollback verify if all records in the animals table still exists. 
SELECT * FROM animals;

-- start transaction
BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
-- create savepoint
SAVEPOINT SP1;
-- update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = (weight_kg * -1);
-- Rollback to the savepoint
ROLLBACK TO SP1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
-- commit transaction
COMMIT;
SELECT * FROM animals;

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts > 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) AS escapes FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS minimum_weight, MAX(weight_kg) AS maximum_weight
FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT animals.species_id, AVG(escape_attempts) 
FROM animals 
WHERE EXTRACT(YEAR FROM date_of_birth) 
BETWEEN 1990 AND 2000 
GROUP BY animals.species_id;

/* DAY 3 */
--Day 3
-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- Update List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, animals.species_id, animals.owner_id, species.name as species_name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name, full_name as owners
FROM animals JOIN owners ON owners.id = animals.owner_id;

-- How many animals are there per species
SELECT species.name, COUNT(animals.name)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;
-- Update List all Digimon owned by Jennifer Orwell.
SELECT animals.name as animals, full_name as owner, species.name as species
FROM animals
JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- Update List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name, full_name as owner_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;
-- Who owns the most animals?
SELECT full_name, COUNT(animals.owner_id)
FROM animals
JOIN owners ON owners.id = animals.owner_id
GROUP BY full_name ORDER BY count DESC LIMIT 1;
-- DAY 4
SELECT animals.name, visits.date_of_visit, vets.name AS vet_name
  FROM animals 
  JOIN visits ON visits.animal_id = animals.id 
  JOIN vets ON vets.id = visits.vet_id 
  WHERE vets.name = 'William Tatcher' 
  ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(DISTINCT animals.name) AS animals_checked
FROM animals 
JOIN visits ON visits.animal_id = animals.id 
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name AS vets_name, species.name AS species_name
  FROM vets 
  LEFT JOIN specializations ON vets.id = specializations.vet_id 
  LEFT JOIN species ON species.id = specializations.species_id;


SELECT DISTINCT animals.name AS animal_name, visits.date_of_visit
  FROM animals 
  JOIN visits ON visits.animal_id = animals.id 
  JOIN vets ON vets.id = visits.vet_id 
  WHERE vets.name = 'Stephanie Mendez'
  AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


SELECT animals.name, COUNT(visits.date_of_visit) AS visit_count
  FROM animals JOIN visits ON visits.animal_id = animals.id 
  GROUP BY animals.name 
  ORDER BY visit_count 
  DESC LIMIT 1;

SELECT animals.name, visits.date_of_visit
  FROM animals JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visits.date_of_visit ASC LIMIT 1;

SELECT 
  animals.name As animal_name,
  animals.weight_kg,
  animals.date_of_birth,
  animals.neutered,
  vets.name AS vet_name,
  vets.date_of_graduation,
  visits.date_of_visit
  FROM animals JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.animal_id) AS non_specialized_visits
  FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN specializations ON specializations.species_id = vets.id
  WHERE specializations.species_id != animals.species_id;

SELECT species.name, COUNT(visits.animal_id)
  FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN species ON species.id = animals.species_id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
  ORDER BY COUNT DESC LIMIT 1; 

  ------------------------------------------------------
-- Find a way to decrease the execution time of the first query. Look for hints in the previous lessons
  SELECT COUNT(*) FROM visits where animal_id = 4;
  SELECT COUNT(*) FROM animals_visit where animal_id = 4;
-- Find a way to improve execution time of the other two queries.
  SELECT * FROM visits where vet_id = 2;
  SELECT * FROM animals_vet WHERE vet_id = 2;
  SELECT * FROM owners where email = 'owner_18327@mail.com';
  SELECT * FROM email where email = 'owner_18327@mail.com';

  