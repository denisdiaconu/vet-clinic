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