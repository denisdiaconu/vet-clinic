/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name = 'Luna';
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-01';
SELECT name FROM animals WHERE neutered = true; AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* part 2 */

BEGIN:
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;


BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SAVE_POINT_1_ANIMALS;
UPDATE animals SET weight_kg = (-1 * weight_kg);
ROLLBACK TO SAVEPOINT SAVE_POINT_1_ANIMALS;
UPDATE animals SET weight_kg = (-1 * weight_kg) WHERE weight_kg < 0;
COMMIT;



SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT * FROM animals WHERE neutered = true OR neutered = false GROUP BY neutered;

SELECT neutered, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY neutered;
SELECT AVG(escape_attempts), species FROM animals WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-01' GROUP BY species;




/* part 3 */


SELECT * FROM animals
    INNER JOIN owners
    ON owner_id = owners.id WHERE full_name = 'Melody Pond';

SELECT * FROM animals
    INNER JOIN species
    ON species.id = animals.species_id WHERE species.name = 'Pokemon';

SELECT full_name, name FROM owners
    LEFT JOIN animals
    ON animals.owner_id = owners.id;

SELECT species.name, COUNT(*) FROM animals
    FULL OUTER JOIN species
    ON species.id = animals.species_id GROUP BY species.id;

SELECT animals.name, species.name FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    INNER JOIN species
    ON species.id = animals.species_id
    WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name FROM animals
    LEFT JOIN owners ON owners.id = animals.owner_id
    WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT owners.full_name, COUNT(animals.owner_id) FROM animals
    FULL OUTER JOIN owners
    ON animals.owner_id = owners.id GROUP BY owners.id;


/* part 4 */


SELECT animals.name, visits.date_of_visit AS visited FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'William Tatcher'
    GROUP BY animals.name, visits.date_of_visit ORDER BY visited DESC LIMIT 1;


SELECT COUNT(DISTINCT visits.animals_id)
    FROM visits WHERE visits.vets_id = 3;


SELECT vets.name, species.name FROM vets 
    LEFT JOIN specializations ON specializations.vets_id = vets.id
    LEFT JOIN species ON species.id = specializations.species_id;

SELECT DISTINCT animals_id FROM visits
    JOIN animals ON visits.vets_id = 3
    AND visits.date_of_visit > '2020-04-01'
    AND visits.date_of_visit < '2020-08-30';


SELECT DISTINCT animals.name, COUNT(visits.animals_id) FROM visits
    JOIN animals ON visits.animals_id = animals.id
    GROUP BY animals.name ORDER BY COUNT(animals_id) DESC LIMIT 1;

SELECT visits.animals_id, visits.date_of_visit FROM visits
    WHERE visits.vets_id = 2 ORDER BY visits.date_of_visit ASC LIMIT 1;

SELECT * FROM visits
    JOIN vets ON vets.id = visits.vets_id
    JOIN animals ON animals.id = visits.animals_id
    ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.animals_id) FROM visits
    JOIN vets ON vets.id = visits.vets_id
    JOIN animals ON animals.id = visits.animals_id
    JOIN specializations ON specializations.vets_id = vets.id
    WHERE specializations.species_id != animals.species_id;

SELECT species.name, COUNT(visits.animals_id) AS species_count FROM visits
    JOIN vets ON vets.id = visits.vets_id
    JOIN animals ON animals.id = visits.animals_id
    JOIN species ON species.id = animals.species_id
    WHERE vets.id = 2 GROUP BY species.name
    ORDER BY species_count DESC LIMIT 1;
