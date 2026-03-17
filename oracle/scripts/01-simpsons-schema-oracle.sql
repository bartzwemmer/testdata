WHENEVER SQLERROR EXIT SQL.SQLCODE
ALTER SESSION SET CONTAINER = PDB1;

-- Clean up Simpson's schema if it exists
SET SERVEROUTPUT ON;
DECLARE
   v_user_exists NUMBER;
BEGIN
   SELECT COUNT(*) INTO v_user_exists FROM all_users WHERE username = 'SIMPSONS';
   IF v_user_exists > 0 THEN
      EXECUTE IMMEDIATE 'DROP USER SIMPSONS CASCADE';
      DBMS_OUTPUT.PUT_LINE('Old SIMPSONS schema has been dropped.');
   END IF;
END;
/

-- Create user with provided password (passed as &1)
CREATE USER simpsons IDENTIFIED BY "&1";

-- Grant unlimited tablespace to allow creating objects on any tablespace (including default)
GRANT UNLIMITED TABLESPACE TO simpsons;

GRANT CREATE SESSION, CREATE TABLE TO simpsons;

-- Create tables explicitly in SIMPSONS schema
CREATE TABLE simpsons.characters (
    characters CLOB
);

CREATE TABLE simpsons.episodes (
    episodes CLOB
);

CREATE TABLE simpsons.locations (
    locations CLOB
);

CREATE TABLE simpsons.script_lines (
    script_lines CLOB
);
