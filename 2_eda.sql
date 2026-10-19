SET PAGESIZE 100
SET LINESIZE 200
SET SQLFORMAT ansiconsole

-- ============================================
-- UPPGIFT 1 - GRUNDLÄGGANDE EDA
-- ============================================

-- a) Antal ansökningar per utbildningsområde, sorterat på flest ansökningar
SELECT utbildningsomrade, COUNT(*) AS antal_ansokningar
FROM ansokningar
GROUP BY utbildningsomrade
ORDER BY antal_ansokningar DESC;

-- b) Antal BEVILJADE ansökningar per utbildningsområde
SELECT utbildningsomrade, COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE beslut = 'Beviljad'
GROUP BY utbildningsomrade
ORDER BY antal_beviljade DESC;

-- c) Antal AVSLAGNA ansökningar per utbildningsområde
SELECT utbildningsomrade, COUNT(*) AS antal_avslagna
FROM ansokningar
WHERE beslut = 'Avslag'
GROUP BY utbildningsomrade
ORDER BY antal_avslagna DESC;

-- d) Antal BEVILJADE ansökningar per utbildningsnamn inom Data/IT
SELECT utbildningsnamn, COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE beslut = 'Beviljad' AND utbildningsomrade = 'Data/IT'
GROUP BY utbildningsnamn
ORDER BY antal_beviljade DESC;

-- e) Antal AVSLAGNA ansökningar per utbildningsnamn inom Data/IT
SELECT utbildningsnamn, COUNT(*) AS antal_avslagna
FROM ansokningar
WHERE beslut = 'Avslag' AND utbildningsomrade = 'Data/IT'
GROUP BY utbildningsnamn
ORDER BY antal_avslagna DESC;

-- f) Antal BEVILJADE ansökningar per utbildningsanordnare & utbildningsnamn, inom Data/IT
SELECT utbildningsanordnare_administr, utbildningsnamn, COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE beslut = 'Beviljad' AND utbildningsomrade = 'Data/IT'
GROUP BY utbildningsanordnare_administr, utbildningsnamn
ORDER BY antal_beviljade DESC;

-- g) Topp 5 län efter antal beviljade ansökningar
SELECT lan, COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE beslut = 'Beviljad'
GROUP BY lan
ORDER BY antal_beviljade DESC
FETCH FIRST 5 ROWS ONLY;

-- h) Andel distans och andel bundna utbildningar inom respektive utbildningsområde
SELECT
    utbildningsomrade,
    ROUND(SUM(CASE WHEN studieform = 'Distans' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS andel_distans_procent,
    ROUND(SUM(CASE WHEN studieform = 'Bunden' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS andel_bunden_procent
FROM ansokningar
GROUP BY utbildningsomrade
ORDER BY utbildningsomrade;

-- i) Antal utbildningar som innehåller ordet AI
SELECT COUNT(*) AS antal_utbildningar_med_AI
FROM ansokningar
WHERE UPPER(utbildningsnamn) LIKE '%AI%';

COMMIT;
EXIT;

