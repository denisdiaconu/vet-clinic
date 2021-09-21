/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT AUTO_INCREMENT PRIMARY KEY (id),
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals ADD COLUMN species varchar(100);