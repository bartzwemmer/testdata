-- DROP SCHEMA simpsons;

CREATE SCHEMA simpsons AUTHORIZATION postgres;

-- simpsons."characters" definition

-- Drop table

-- DROP TABLE simpsons."characters";

CREATE TABLE simpsons."characters" (
	"characters" text NULL
);

-- simpsons.episodes definition

-- Drop table

-- DROP TABLE simpsons.episodes;

CREATE TABLE simpsons.episodes (
	episodes text NULL
);

-- simpsons.locations definition

-- Drop table

-- DROP TABLE simpsons.locations;

CREATE TABLE simpsons.locations (
	locations text NULL
);

-- simpsons.script_lines definition

-- Drop table

-- DROP TABLE simpsons.script_lines;

CREATE TABLE simpsons.script_lines (
	script_lines text NULL
);