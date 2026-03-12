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
CREATE TABLE IF NOT EXISTS house_price AS
SELECT * FROM read_parquet('s3://test-data/house-price.parquet');

-- Start the UI
CALL start_ui();