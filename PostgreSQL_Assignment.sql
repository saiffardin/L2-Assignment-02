-- Problem 1
INSERT into rangers(name,region) VALUES (
  'Derek Fox', 'Coastal Plains'
)

-- Problem 2
SELECT count(DISTINCT(species_id)) as unique_species_count FROM sightings;

-- Problem 3
SELECT * from sightings WHERE location LIKE '%Pass%'

-- Problem 4
SELECT name, count(species_id) as total_sightings from 
rangers JOIN sightings
ON rangers.ranger_id = sightings.ranger_id
GROUP BY name
ORDER BY name

-- Problem 5
select common_name from species
WHERE species.species_id not in (
  SELECT species.species_id from species JOIN sightings
  on species.species_id = sightings.species_id
)

-- Problem 6
select common_name, sighting_time, name from
(SELECT common_name, sighting_time, ranger_id FROM sightings JOIN species
on sightings.species_id = species.species_id
ORDER BY sighting_time DESC LIMIT 2) t1 
JOIN rangers on rangers.ranger_id = t1.ranger_id

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

---- Problem 8
SELECT sighting_id,
CASE
  WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
  WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
END 
AS time_of_day FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT ranger_id FROM sightings
)