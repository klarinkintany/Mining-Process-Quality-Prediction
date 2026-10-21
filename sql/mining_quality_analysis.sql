
-- =====================================================
-- PROJECT: Mining Process Quality Prediction
-- PURPOSE: SQL Data Analysis
-- DATASET: Mining Process Flotation Plant
-- =====================================================

USE mining_quality;
CREATE DATABASE IF NOT EXISTS mining_quality;
USE mining_quality;
SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';
USE mining_quality;
SELECT COUNT(*) AS total_rows
FROM mining_process;

-- Check Total Rows
SELECT COUNT(*) AS total_rows
FROM mining_process;

Use mining_quality;
-- Memahami isi dataset
select *
from mining_process
limit 10;

-- 1. BASIC QUALITY STATISTICS
-- Analisis statistik dasar iron concentrate dan silica concentrate

SELECT
    COUNT(*) AS total_rows,
    ROUND(AVG(iron_concentrate), 2) AS avg_iron,
    ROUND(MIN(iron_concentrate), 2) AS min_iron,
    ROUND(MAX(iron_concentrate), 2) AS max_iron,
    ROUND(AVG(silica_concentrate), 2) AS avg_silica,
    ROUND(MIN(silica_concentrate), 2) AS min_silica,
    ROUND(MAX(silica_concentrate), 2) AS max_silica
FROM mining_process;


-- 2. MONTHLY QUALITY TREND
-- Analisis tren kualitas iron dan silica per bulan

SELECT
    DATE_FORMAT(date, '%Y-%m') AS month,
    COUNT(*) AS total_observations,
    ROUND(AVG(iron_concentrate), 2) AS avg_iron,
    ROUND(AVG(silica_concentrate), 2) AS avg_silica
FROM mining_process
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY month;


-- 3. SILICA CATEGORY ANALYSIS
-- Tujuan: Membandingkan kategori silica

SELECT
    CASE
        WHEN silica_concentrate <= 2.00 THEN 'Low Silica'
        WHEN silica_concentrate <= 3.00 THEN 'Medium Silica'
        ELSE 'High Silica'
    END AS silica_category,
    COUNT(*) AS total_rows,
    ROUND(AVG(iron_concentrate), 2) AS avg_iron,
    ROUND(AVG(ore_pulp_ph), 3) AS avg_pH,
    ROUND(AVG(flotation_01_air_flow), 2) AS avg_air_flow,
    ROUND(AVG(flotation_01_level), 2) AS avg_column_level
FROM mining_process
GROUP BY silica_category
ORDER BY silica_category;


-- 4. HIGH IRON CONCENTRATE ANALYSIS
-- Menampilkan 20 observasi dengan kadar iron tertinggi

SELECT
    date,
    iron_concentrate,
    silica_concentrate,
    ore_pulp_ph,
    flotation_01_air_flow,
    flotation_01_level
FROM mining_process
ORDER BY iron_concentrate DESC
LIMIT 20;

-- 5. AIR FLOW CATEGORY ANALYSIS
-- Perbandingan kualitas berdasarkan kategori air flow

SELECT
    CASE
        WHEN flotation_01_air_flow < 250 THEN 'Low Air Flow'
        WHEN flotation_01_air_flow < 300 THEN 'Medium Air Flow'
        ELSE 'High Air Flow'
    END AS air_flow_category,
    COUNT(*) AS total_rows,
    ROUND(AVG(iron_concentrate), 2) AS avg_iron,
    ROUND(AVG(silica_concentrate), 2) AS avg_silica
FROM mining_process
GROUP BY air_flow_category
ORDER BY air_flow_category;

-- 6. pH CATEGORY ANALYSIS
-- Perbandingan kualitas berdasarkan kategori pH

SELECT
    CASE
        WHEN ore_pulp_ph < 9.5 THEN 'Low pH'
        WHEN ore_pulp_ph < 10.0 THEN 'Medium pH'
        ELSE 'High pH'
    END AS ph_category,
    COUNT(*) AS total_rows,
    ROUND(AVG(iron_concentrate), 2) AS avg_iron,
    ROUND(AVG(silica_concentrate), 2) AS avg_silica
FROM mining_process
GROUP BY ph_category
ORDER BY ph_category;

-- 7. TOP 10 DAYS WITH LOWEST AVERAGE SILICA
-- Menampilkan 10 hari dengan rata-rata silica terendah

SELECT
    DATE(date) AS production_date,
    COUNT(*) AS total_observations,
    ROUND(AVG(iron_concentrate), 2) AS avg_iron,
    ROUND(AVG(silica_concentrate), 2) AS avg_silica
FROM mining_process
GROUP BY DATE(date)
ORDER BY avg_silica ASC
LIMIT 10;



