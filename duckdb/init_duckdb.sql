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
CREATE OR REPLACE TABLE test_data.house_price AS
SELECT * FROM read_parquet('s3://test-data/house-price.parquet');

CREATE SCHEMA IF NOT EXISTS simpsons;

CREATE OR REPLACE TABLE simpsons.characters AS
SELECT c.* FROM (
    SELECT CAST(characters AS STRUCT(id INT, name VARCHAR, normalized_name VARCHAR, sex VARCHAR)) AS c
    FROM read_parquet('s3://simpsons/characters.parquet')
);

CREATE OR REPLACE TABLE simpsons.episodes AS
SELECT e.* FROM (
    SELECT CAST(episodes AS STRUCT(id INT, title VARCHAR, original_air_date DATE, production_code VARCHAR, season INT, number_in_season INT, number_in_series INT, us_viewers_in_millions DOUBLE, views INT, imdb_rating DOUBLE, imdb_votes INT, image_url VARCHAR, video_url VARCHAR)) AS e
    FROM read_parquet('s3://simpsons/episodes.parquet')
);

CREATE OR REPLACE TABLE simpsons.locations AS
SELECT l.* FROM (
    SELECT CAST(locations AS STRUCT(id INT, name VARCHAR, normalized_name VARCHAR)) AS l
    FROM read_parquet('s3://simpsons/locations.parquet')
);

CREATE OR REPLACE TABLE simpsons.script_lines AS
SELECT s.* FROM (
    SELECT CAST(script_lines AS STRUCT(id INT, episode_id INT, number INT, raw_text VARCHAR, timestamp_in_ms BIGINT, speaking_line BOOLEAN, character_id INT, location_id INT, raw_character_text VARCHAR, raw_location_text VARCHAR, spoken_words VARCHAR, normalized_text VARCHAR, word_count INT)) AS s
    FROM read_parquet('s3://simpsons/script_lines.parquet')
);

-- Start the UI
CALL start_ui();