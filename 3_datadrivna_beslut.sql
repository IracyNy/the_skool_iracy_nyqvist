-- Fråga 1: Vilka utbildningsområden har högst andel avslag?
SELECT 
    utbildningsomrade,
    COUNT(*) AS totalt_antal,
    SUM(CASE WHEN beslut = 'Avslag' THEN 1 ELSE 0 END) AS antal_avslag,
    ROUND(SUM(CASE WHEN beslut = 'Avslag' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS andel_avslag_procent
FROM ansokningar
GROUP BY utbildningsomrade
ORDER BY andel_avslag_procent DESC;

-- Fråga 2: Vilka är de vanligaste utbildningsnamnen totalt?
SELECT 
    utbildningsnamn, 
    COUNT(*) AS antal_ansokningar
FROM ansokningar
GROUP BY utbildningsnamn
ORDER BY antal_ansokningar DESC
FETCH FIRST 10 ROWS ONLY;

-- Fråga 3: Hur ser fördelningen ut mellan olika huvudmän (privata, kommunala, etc.)?
SELECT 
    huvudmannatyp, 
    COUNT(*) AS antal_ansokningar,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM ansokningar) * 100, 2) AS andel_procent
FROM ansokningar
GROUP BY huvudmannatyp
ORDER BY antal_ansokningar DESC;

-- Fråga 4: Vilka utbildningar inom Data/IT har flest beviljade platser totalt?
SELECT 
    utbildningsnamn, 
    SUM(beviljade_platser_totalt) AS totalt_beviljade_platser
FROM ansokningar
WHERE utbildningsomrade = 'Data/IT' AND beslut = 'Beviljad'
GROUP BY utbildningsnamn
ORDER BY totalt_beviljade_platser DESC
FETCH FIRST 5 ROWS ONLY;

