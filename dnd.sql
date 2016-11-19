--DATABASE STRUCTURES AND DATA FOR DUNGEONS AND DRAGONS 4TH ED. PROJECT
--V 0.2.1
DROP DATABASE IF EXISTS dungeons;
CREATE DATABASE dungeons;
\c dungeons
--CREATE EXTENSION PGCRYPTO;
--------------------------------------------------------------------------------
CREATE TABLE "class" (
	"name" TEXT NOT NULL,
	"role" TEXT NOT NULL,
	"source" TEXT NOT NULL UNIQUE,
	"keystat" TEXT NOT NULL,
	"armor" TEXT NOT NULL UNIQUE,
	"weapon" TEXT NOT NULL UNIQUE,
	"implement" TEXT NOT NULL DEFAULT 'None',
	"defense" TEXT NOT NULL,
	"starthp" integer NOT NULL,
	"levelhp" integer NOT NULL,
	"surge" integer NOT NULL,
	"skills" TEXT NOT NULL,
	"features" TEXT NOT NULL,
	"book" TEXT NOT NULL DEFAULT 'PHB1',
	CONSTRAINT class_pk PRIMARY KEY ("name")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "race" (
	"name" TEXT NOT NULL,
	"skill" TEXT NOT NULL,
	"stats" TEXT NOT NULL,
	"size" TEXT NOT NULL DEFAULT 'Medium',
	"speed" integer NOT NULL DEFAULT '6',
	"vision" TEXT NOT NULL DEFAULT 'Normal',
	"language" TEXT NOT NULL DEFAULT 'Normal',
	"traits" TEXT NOT NULL,
	"book" TEXT NOT NULL DEFAULT 'PHB1',
	CONSTRAINT race_pk PRIMARY KEY ("name")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "powers" (
	"name" TEXT NOT NULL,
	"origin" TEXT NOT NULL,
	"levelreq" integer NOT NULL,
	"flavor" TEXT NOT NULL,
	"encountertype" TEXT NOT NULL DEFAULT 'Encounter',
	"keywords" TEXT NOT NULL,
	"actiontype" TEXT NOT NULL,
	"range" TEXT NOT NULL,
	"target" TEXT NOT NULL,
	"attack" TEXT NOT NULL,
	"trigger" TEXT NOT NULL,
	"hit" TEXT NOT NULL,
	"effect" TEXT NOT NULL,
	"miss" TEXT NOT NULL,
	"special" TEXT NOT NULL,
	"sustain" TEXT NOT NULL,
	"book" TEXT NOT NULL DEFAULT 'PHB1',
	CONSTRAINT powers_pk PRIMARY KEY ("name")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "feats" (
	"name" serial NOT NULL,
	"benefit" TEXT NOT NULL,
	"special" TEXT NOT NULL,
	"levelreq" integer NOT NULL DEFAULT 1,
	"racereq" TEXT NOT NULL,
	"classreq" TEXT NOT NULL,
	"sourcereq" TEXT NOT NULL,
	"str" integer NOT NULL DEFAULT 0,
	"con" integer NOT NULL DEFAULT 0,
	"dex" integer NOT NULL DEFAULT 0,
	"int" integer NOT NULL DEFAULT 0,
	"wis" integer NOT NULL DEFAULT 0,
	"char" integer NOT NULL DEFAULT 0,
	"acrobatics" BOOLEAN NOT NULL DEFAULT FALSE,
	"arcana" BOOLEAN NOT NULL DEFAULT FALSE,
	"athletics" BOOLEAN NOT NULL DEFAULT FALSE,
	"bluff" BOOLEAN NOT NULL DEFAULT FALSE,
	"dungeoneering" BOOLEAN NOT NULL DEFAULT FALSE,
	"endurance" BOOLEAN NOT NULL DEFAULT FALSE,
	"heal" BOOLEAN NOT NULL DEFAULT FALSE,
	"intimidate" BOOLEAN NOT NULL DEFAULT FALSE,
	"nature" BOOLEAN NOT NULL DEFAULT FALSE,
	"perception" BOOLEAN NOT NULL DEFAULT FALSE,
	"religion" BOOLEAN NOT NULL DEFAULT FALSE,
	"stealth" BOOLEAN NOT NULL DEFAULT FALSE,
	"feats" TEXT NOT NULL,
	"god" TEXT NOT NULL,
	"armor_proficiency" TEXT NOT NULL,
	CONSTRAINT feats_pk PRIMARY KEY ("name")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "users" (
	"username" varchar(20) NOT NULL,
	"password" varchar(20) NOT NULL,
	" character" integer NOT NULL UNIQUE,
	CONSTRAINT users_pk PRIMARY KEY ("username")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "character" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"level" integer NOT NULL DEFAULT 1,
	"race" TEXT NOT NULL UNIQUE,
	"class" TEXT NOT NULL UNIQUE,
	"source" TEXT NOT NULL UNIQUE,
	"str" integer NOT NULL DEFAULT 10,
	"con" integer NOT NULL DEFAULT 10,
	"dex" integer NOT NULL DEFAULT 10,
	"int" integer NOT NULL DEFAULT 10,
	"wis" integer NOT NULL DEFAULT 10,
	"cha" integer NOT NULL DEFAULT 10,
	"acrobatics" BOOLEAN NOT NULL DEFAULT FALSE,
	"arcana" BOOLEAN NOT NULL DEFAULT FALSE,
	"athletics" BOOLEAN NOT NULL DEFAULT FALSE,
	"bluff" BOOLEAN NOT NULL DEFAULT FALSE,
	"dungeoneering" BOOLEAN NOT NULL DEFAULT FALSE,
	"endurance" BOOLEAN NOT NULL DEFAULT FALSE,
	"heal" BOOLEAN NOT NULL DEFAULT FALSE,
	"intimidate" BOOLEAN NOT NULL DEFAULT FALSE,
	"nature" BOOLEAN NOT NULL DEFAULT FALSE,
	"perception" BOOLEAN NOT NULL DEFAULT FALSE,
	"religion" BOOLEAN NOT NULL DEFAULT FALSE,
	"stealth" BOOLEAN NOT NULL DEFAULT FALSE,
	"feats" TEXT NOT NULL,
	"god" TEXT NOT NULL,
	"armor_proficiency" TEXT NOT NULL UNIQUE,
	"weapon_proficiency" TEXT NOT NULL UNIQUE,
	CONSTRAINT character_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "books" (
	"book" TEXT NOT NULL,
	"book_name" TEXT NOT NULL,
	CONSTRAINT books_pk PRIMARY KEY ("book")
) WITH (
  OIDS=FALSE
);

ALTER TABLE "class" ADD CONSTRAINT "class_fk0" FOREIGN KEY ("name") REFERENCES "character"("class");
ALTER TABLE "class" ADD CONSTRAINT "class_fk1" FOREIGN KEY ("source") REFERENCES "character"("source");
ALTER TABLE "class" ADD CONSTRAINT "class_fk3" FOREIGN KEY ("armor") REFERENCES "character"("armor_proficiency");
ALTER TABLE "class" ADD CONSTRAINT "class_fk4" FOREIGN KEY ("weapon") REFERENCES "character"("weapon_proficiency");

ALTER TABLE "race" ADD CONSTRAINT "race_fk0" FOREIGN KEY ("name") REFERENCES "character"("race");

ALTER TABLE "character" ADD CONSTRAINT "character_fk0" FOREIGN KEY ("id") REFERENCES "users"(" character");
--------------------------------------------------------------------------------
DROP ROLE IF EXISTS dnduser;
CREATE USER dnduser;
--Enter dnd without quotes when prompted 
\password dnduser
GRANT SELECT ON class, feats, powers, race, skill, stats, source, weapon_proficiency, armor_proficiency, keyword, book to dnduser;
GRANT SELECT, INSERT ON character, users to dnduser;