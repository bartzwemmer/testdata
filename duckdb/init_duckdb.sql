INSTALL httpfs;
LOAD httpfs;
INSTALL spatial;
LOAD spatial;

-- Enable Garage S3 connectivity using modern SECRET syntax
CREATE SECRET s3_secret (
    TYPE s3,
    KEY_ID getenv('S3_ACCESS_KEY'),
    SECRET getenv('S3_SECRET_KEY'),
    REGION 'garage',
    ENDPOINT 'garage:3900',
    USE_SSL false,
    URL_STYLE 'path'
);

-- Create table in DuckDB referencing S3 parquet
CREATE SCHEMA IF NOT EXISTS test_data;
CREATE TABLE IF NOT EXISTS test_data.house_price AS
SELECT * FROM read_parquet('s3://test-data/house-price.parquet');

CREATE SCHEMA IF NOT EXISTS simpsons;
CREATE TABLE IF NOT EXISTS simpsons.characters AS
SELECT * FROM read_parquet('s3://simpsons/characters.parquet');
CREATE TABLE IF NOT EXISTS simpsons.episodes AS
SELECT * FROM read_parquet('s3://simpsons/episodes.parquet');
CREATE TABLE IF NOT EXISTS simpsons.locations AS
SELECT * FROM read_parquet('s3://simpsons/locations.parquet');
CREATE TABLE IF NOT EXISTS simpsons.script_lines AS
SELECT * FROM read_parquet('s3://simpsons/script_lines.parquet');

-- Start the UI
CALL start_ui();