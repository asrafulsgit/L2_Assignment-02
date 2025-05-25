CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(75) NOT NULL
)

INSERT INTO rangers (ranger_id,name,region) VALUES
        (1, 'Alice Green', 'Northern Hills'),
        (2, 'Bob White', 'River Delta'),
        (3, 'Carol King', 'Mountain Range');





CREATE TABLE sepcies(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(75) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(25) NOT NULL
)

INSERT INTO sepcies (species_id,common_name,scientific_name,discovery_date,conservation_status) VALUES
    (1,'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
    (2,'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
    (3,'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
    (4,'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');



CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES sepcies(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT 
)

INSERT INTO sightings (sighting_id,species_id,ranger_id,location,sighting_time,notes) VALUES
        (1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
        (2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
        (3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
        (4, 1, 2, 'Snowfall Pass',  '2024-05-18 18:30:00', NULL);


SELECT * FROM rangers;
SELECT * FROM sepcies;
SELECT * FROM sightings;

-- 1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (ranger_id,name,region) VALUES (4,'Derek Fox','Coastal Plains')

-- 2️⃣ Count unique species ever sighted.

SELECT species_id FROM sightings GROUP BY species_id;

