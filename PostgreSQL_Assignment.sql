CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(75) NOT NULL
)

INSERT INTO rangers (ranger_id,name,region) VALUES
        (1, 'Alice Green', 'Northern Hills'),
        (2, 'Bob White', 'River Delta'),
        (3, 'Carol King', 'Mountain Range');

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(75) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(25) NOT NULL
)

INSERT INTO species (species_id,common_name,scientific_name,discovery_date,conservation_status) VALUES
    (1,'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
    (2,'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
    (3,'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
    (4,'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');



CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
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


-- 1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (ranger_id,name,region) VALUES (4,'Derek Fox','Coastal Plains')

-- 2️⃣ Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

--3️⃣ Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location ILIKE '%pass%';

--4️⃣ List each ranger's name and their total number of sightings.
SELECT  rangers.name,count(rangers.ranger_id) AS total_sightings FROM rangers   
    INNER JOIN sightings ON rangers.ranger_id = sightings.ranger_id
    GROUP BY rangers.ranger_id;

-- 5️⃣ List species that have never been sighted.
SELECT species.common_name FROM species 
    LEFT JOIN sightings ON sightings.species_id = species.species_id
    WHERE sighting_id IS NULL;

-- 6️⃣ Show the most recent 2 sightings.
SELECT species.common_name, sightings.sighting_time, rangers.name FROM sightings
    JOIN species ON species.species_id = sightings.species_id
    JOIN rangers ON rangers.ranger_id = sightings.ranger_id
    ORDER BY sighting_time DESC
    LIMIT 2;

-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species  
    SET conservation_status = 'Historic'
    WHERE extract(year FROM discovery_date) < 1800;

CREATE OR REPLACE FUNCTION time_to_name(hour_value INT)
RETURNS TEXT AS 
$$
BEGIN
    IF hour_value >= 0 AND hour_value < 12 THEN
        RETURN 'Morning';
    ELSIF hour_value >= 12 AND hour_value < 17 THEN
        RETURN 'Afternoon';
    ELSE
        RETURN 'Evening';
    END IF;
END;
$$ LANGUAGE PLPGSQL;

SELECT sighting_id, time_to_name(extract(hour FROM sighting_time )::INT)  FROM sightings;



-- 9️⃣ Delete rangers who have never sighted any species
DELETE FROM rangers 
    WHERE ranger_id NOT IN(
        SELECT ranger_id FROM sightings
    );
