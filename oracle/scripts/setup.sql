-- Master setup script for Oracle initialization
WHENEVER SQLERROR EXIT SQL.SQLCODE
SET ECHO OFF
SET VERIFY OFF

-- Define arguments
DEFINE pass = '&1'
DEFINE tbs  = '&2'

ALTER SESSION SET CONTAINER = PDB1;

-- 1. Simpson's Schema and Data
PROMPT Installing Simpson's Schema...
@@01-simpsons-schema-oracle.sql "&pass"
PROMPT Loading Simpson's Data...
@@02-simpsons-data-oracle.sql

-- Restore DEFINE after data script (which sets it to OFF)
SET DEFINE ON

-- 2. HR Schema (Note: hr_install.sql ends with EXIT)
PROMPT Installing HR Sample Schema...
@@hr_install.sql "&pass" "&tbs" "YES"
