/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT AUTO_INCREMENT,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE animals ADD COLUMN species varchar(100);


/* Part 3 */


CREATE TABLE owners (
    id INT NOT NULL AUTO_INCREMENT,
    full_name varchar(100),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT NOT NULL AUTO_INCREMENT,
    name varchar(100),
    PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);