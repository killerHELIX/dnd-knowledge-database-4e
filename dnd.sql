DROP DATABASE IF EXISTS dungeons;
CREATE DATABASE dungeons;
\c dungeons
-- CREATE EXTENSION PGCRYPTO; --Will be added with user fcns
--------------------------------------------------------------------------------

--
-- Table Structure for Race
--

DROP TABLE IF EXISTS race;
CREATE TABLE race (
    ID serial NOT NULL,
    name varchar(50) NOT NULL default '',
    stats varchar(50) NOT NULL DEFAULT '',
    size varchar(50) NOT NULL DEFAULT 'Medium',
    speed integer NOT NULL DEFAULT '6',
    vision varchar(50) NOT NULL DEFAULT 'Normal',
    language varchar(100) NOT NULL DEFAULT '',
    skill varchar(50) NOT NULL default '',
    traits text NOT NULL DEFAULT '',
    PRIMARY KEY (ID)
);