-- Question 1
SELECT MOB_NAME
FROM fortress1
WHERE SPAWNS = (SELECT MAX(SPAWNS) FROM fortress1);

-- Question 2
SELECT MOB_NAME, SPAWNS
FROM fortress1
WHERE SPAWNS > ANY(SELECT SPAWNS FROM fortress2);

-- Question 3
SELECT MOB_NAME, BIOME_ID
FROM fortress1
WHERE (mob_name, biome_id) IN (
    SELECT mob_name, biome_id
    FROM fortress2
);

-- Question 4
SELECT f1.MOB_NAME, f1.BIOME_ID, f1.SPAWNS, (SELECT AVG(SPAWNS) 
FROM fortress1 f2 
WHERE f2.BIOME_ID = f1.BIOME_ID) AS AVG_BIOME_SPAWNS,
    CASE 
        WHEN f1.SPAWNS > (SELECT AVG(SPAWNS) 
                          FROM fortress1 f2 
                          WHERE f2.BIOME_ID = f1.BIOME_ID)
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS STATUS
FROM fortress1 f1;

