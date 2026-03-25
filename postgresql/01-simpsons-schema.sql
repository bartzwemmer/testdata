-- DROP SCHEMA simpsons;

CREATE SCHEMA simpsons AUTHORIZATION postgres;

-- simpsons."characters" definition

-- Drop table

-- DROP TABLE simpsons."characters";

CREATE TABLE simpsons."characters" (
	id int8 PRIMARY KEY,
	character_id int8 NOT NULL,
	"name" text NULL,
	normalized_name text NULL,
	sex text NULL
);

-- simpsons.episodes definition

-- Drop table

-- DROP TABLE simpsons.episodes;

CREATE TABLE simpsons.episodes (
	id int8 PRIMARY KEY,
	episode_id int8 NOT NULL,
	title text NULL,
	original_air_date text NULL,
	production_code text NULL,
	season int8 NULL,
	number_in_season int8 NULL,
	number_in_series int8 NULL,
	us_viewers_in_millions float8 NULL,
	"views" int8 NULL,
	imdb_rating float8 NULL,
	imdb_votes int8 NULL,
	image_url text NULL,
	video_url text NULL
);

-- simpsons.locations definition

-- Drop table

-- DROP TABLE simpsons.locations;

CREATE TABLE simpsons.locations (
	id int8 PRIMARY KEY,
	location_id int8 NOT NULL,
	"name" text NULL,
	normalized_name text NULL
);

-- simpsons.script_lines definition

-- Drop table

-- DROP TABLE simpsons.script_lines;

CREATE TABLE simpsons.script_lines (
	id int8 PRIMARY KEY,
	sl_id int8 NOT NULL,
	episode_id int8 NULL,
	"number" int8 NULL,
	raw_text text NULL,
	timestamp_in_ms int8 NULL,
	speaking_line bool NULL,
	character_id int8 NULL,
	location_id int8 NULL,
	raw_character_text text NULL,
	raw_location_text text NULL,
	spoken_words text NULL,
	normalized_text text NULL,
	word_count int8 NULL
);