--DATABASE STRUCTURES AND DATA FOR DUNGEONS AND DRAGONS 4TH ED. PROJECT
--V 0.0.1
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
    stats varchar(50) NOT NULL default '',
    size varchar(50) NOT NULL default 'Medium',
    speed integer NOT NULL default '6',
    vision varchar(50) NOT NULL default 'Normal',
    language varchar(100) NOT NULL default 'common',
    skill varchar(50) NOT NULL default '',
    traits text NOT NULL default '',
    PRIMARY KEY (ID)
);

--
-- Table Dump for Race
--



--
-- Table Structure for Class
--

DROP TABLE IF EXISTS class;
CREATE TABLE class (
    ID serial NOT NULL,
    name varchar(50) NOT NULL default '',
    role varchar(50) NOT NULL default '',
    source varchar(50) NOT NULL default '',
    keystat varchar(50) NOT NULL default '',
    armor varchar(80) NOT NULL default '',
    weapon varchar(150) NOT NULL default '',
    implement varchar(50) NOT NULL default '',
    defense varchar(50) NOT NULL default '',
    starthp integer NOT NULL default '0',
    levelhp integer NOT NULL default '0',
    surge integer NOT NULL default '0',
    skills text NOT NULL default '',
    features text NOT NULL default '',
    PRIMARY KEY (ID)
);

--
-- Table Dump for Class
--



--
-- Table Structure for Feats
--

DROP TABLE IF EXISTS feats;
CREATE TABLE feats (
    ID serial NOT NULL,
    name varchar(50) NOT NULL default '',
    prereq text NOT NULL default '',
    benefit text NOT NULL default '',
    PRIMARY KEY (ID)
);

--
-- Table Dump for Feats
--



--
-- Table Structure for Powers
--

DROP TABLE IF EXISTS powers;
CREATE TABLE IF EXISTS powers (
    ID serial NOT NULL,
    name varchar(50) NOT NULL default '',
    origin varchar(50) NOT NULL default '',
    level integer NOT NULL default '1',
    flavor text NOT NULL default '',
    encountertype varchar(20) NOT NULL default 'Encounter',
    keywords text NOT NULL default '',
    actiontype varchar(20) NOT NULL default '',
    range varchar(50) NOT NULL default '',
    target text,
    attack text,
    trigger text,
    hit text,
    effect text,
    miss text,
    special text,
    sustain text,
    PRIMARY KEY (ID)
);