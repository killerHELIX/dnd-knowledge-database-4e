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

INSERT INTO race (name, stats, language, skill, traits)
VALUES ('Human', '+2 to one ability score of your choice', 'common and one language of your choice', 'no skill bonuses',
E'Bonus Feat: You gain a bonus feat at 1st level. You must meet the feat''s prerequisites. \n Bonus Skill: You gain training in one additional skill from your class skills list. \n Human defense Bonus: You gain a +1 racial bonus to Fortitude, Reflex and Will. \n Heroic Effort: You have the Heroic Effort power.');
INSERT INTO race (name, stats, language, skill, traits)
VALUES ('Dragonborn', '+2 Strength, +2 Charisma', 'Common, Draconic', '+2 History, +2 Intimidate', 
E'Dragonborn Fury: When you’re bloodied, you gain a +1 racial bonus to attack rolls. \n Draconic Heritage: Your healing surge value is equal to one-quarter of your maximum hit points + your Constitution modifier. \n Dragon Breath: You can use dragon breath as an encounter power.');
INSERT INTO race (name, stats, speed, vision, language, skill, traits)
VALUES ('Dwarf', '+2 Constitution, +2 Wisdom', 5, 'low-light', 'Common, Dwarven', '+2 Dungeoneering, +2 Endurance',
E'Cast-Iron Stomach: +5 racial bonus to saving throws against poison. \n Dwarven Resilience: You can use your second wind as a minor action instead of a standard action. \n Dwarven Weapon Proficiency: You gain proficiency with the throwing hammer and the warhammer. \n Encumbered Speed: You move at your normal speed even when it would normally be reduced by armor or a heavy load. Other effects that limit speed (such as difficult terrain or magical effects) affect you normally. \n Stand Your Ground: When an effect forces you to move—through a pull, a push, or a slide—you can move 1 square less than the effect specifies. This means an effect that normally pulls, pushes, or slides a target 1 square does not force you to move unless you want to. In addition, when an attack would knock you prone, you can immediately make a saving throw to avoid falling prone.');
INSERT INTO race (name, stats, vision, language, skill, traits)
VALUES ('Eladrin', '+2 Dexterity, +2 Intelligence', 'Low-Light', 'Common, Elven', '+2 Arcana, +2 History',
E'Eladrin Education: You gain training in one additional skill selected from the skill list in Chapter 5. Eladrin Weapon Proficiency: You gain proficiency with the longsword. \n Eladrin Will: You gain a +1 racial bonus to your Will defense. In addition, you gain a +5 racial bonus to saving throws against charm effects. \n Fey Origin: Your ancestors were native to the Feywild, so you are considered a fey creature for the purpose of effects that relate to creature origin. \n Trance: Rather than sleep, eladrin enter a meditative state known as trance. You need to spend 4 hours in this state to gain the same benefits other races gain from taking a 6-hour extended rest. While in a trance, you are fully aware of your surroundings and notice approaching enemies and other events as normal. \n Fey Step: You can use fey step as an encounter power.');
INSERT INTO race (name, stats, speed, vision, language, skill, traits)
VALUES ('Elf', '+2 Dexterity, +2 Wisdom', 7, 'Low-Light', 'Common, Elven', '+2 Nature, +2 Perception',
E'Elven Weapon Proficiency: You gain proficiency with the longbow and the shortbow. \n Fey Origin: Your ancestors were native to the Feywild, so you are considered a fey creature for the purpose of effects that relate to creature origin. Group Awareness: You grant non-elf allies within 5 squares of you a +1 racial bonus to Perception checks. \n Wild Step: You ignore difficult terrain when you shift (even if you have a power that allows you to shift multiple squares). \n Elven Accuracy: You can use elven accuracy as an encounter power.');
INSERT INTO race (name, stats, vision, language, skill, traits)
VALUES ('Half-Elf', '+2 Constitution, +2 Charisma', 'Low-Light', 'Common, Elven, Choice of another', '+2 Diplomacy, +2 Insight',
E'Dilettante: At 1st level, you choose an at-will power from a class different from yours. You can use that power as an encounter power. \n Dual Heritage: You can take feats that have either elf or human as a prerequisite (as well as those specifically for half-elves), as long as you meet any other requirements. \n Group Diplomacy: You grant allies within 10 squares of you a +1 racial bonus to Diplomacy checks.');
INSERT INTO race (name, stats, size, language, skill, traits)
VALUES ('Halfling', '+2 Dexterity, +2 Charisma', 'Small', 'Common, Choice of another', '+2 Acrobatics, +2 Thievery',
E'Bold: You gain a +5 racial bonus to saving throws against fear. \n Nimble Reaction: You gain a +2 racial bonus to AC against opportunity attacks. \n Second Chance: You can use second chance as an encounter power.');
INSERT INTO race (name, stats, vision, language, skill, traits)
VALUES ('Tiefling', '+2 Intelligence, +2 Charisma', 'Low-Light', 'Common, Choice of another', '+2 Bluff, +2 Stealth',
'Bloodhunt: You gain a +1 racial bonus to attack rolls against bloodied foes. \n Fire Resistance: You have resist fire 5 + one-half your level. \n Infernal Wrath: You can use infernal wrath as an encounter power.');




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
    implement varchar(50),
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

INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Cleric', 'Leader', 'Divine', 'Wisdom, Strength, Charisma', 'Cloth, leather, hide, chainmail', 'Simple melee, simple ranged', 'Holy Symbol', '+2 to Will', 12, 5, 7, 'Trained Skills: Religion. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Arcana (Int), Diplomacy (Cha), Heal (Wis), History (Int), Insight (Wis), Religion (Int)', 
E'Channel Divinity: Once per encounter you can invoke divine power, filling yourself with the might of your patron deity. With the divine might you invoke you can wield special powers, such as turn undead and divine fortune. Some clerics learn other uses for this feature; for instance, the divinity feats in Chapter 6 grant characters with access to the Channel Divinity class feature the ability to use additional special powers.  Regardless of how many different uses for Channel Divinity you know, you can use only one such ability per encounter. The special ability or power you invoke works just like your other powers. \n Healer’s Lore: Your study of healing allows you to make the most of your healing prayers. When you grant healing with one of your cleric powers that has the healing keyword, add your Wisdom modifier to the hit points the recipient regains. \n Healing Word: Using the healing word power, clerics can grant their comrades additional resilience with nothing more than a short prayer. \n Ritual Casting: You gain the Ritual Caster feat as a bonus feat, allowing you to use magical rituals. You possess a ritual book, and it contains two rituals you have mastered: the Gentle Repose ritual and one other 1st-level ritual of your choice. \n Clerics and Deities: All clerics choose a specific faith to which they devote themselves. Usually this faith is the worship of a specific patron deity—for example, Moradin, Pelor, or Erathis. Sometimes clerics are devoted to churches that venerate groups of deities or even philosophies. \n Cleric Powers: Your cleric powers are called prayers. Some are better for the battle cleric and some are better for the devoted cleric, but a cleric can choose any power when making a power selection. \n Class Features: The cleric has two class features that work like powers: Channel Divinity and healing word. The Channel Divinity class feature encompasses multiple powers, two of which (divine fortune and turn undead) are presented below.');
-- INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
-- VALUES ('Fighter', 'Defender', 'Martial', 'Strength, Wisdom, Dexterity, Constitution');
-- INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
-- VALUES ('Paladin', 'Defender', 'Divine', 'Strength, Charisma, Wisom');
-- INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
-- VALUES ('Ranger', 'Martial', 'Striker', 'Strength, Dexterity, Wisdom');
-- INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
-- VALUES ('Rogue', 'Martial', 'Striker', 'Dexterity, Strenght, Charisma');
-- INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
-- VALUES ('Warlock', 'Arcane', 'Striker', 'Charisma, Constitution, Intelligence');
-- INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
-- VALUES ('Warlord', 'Martial', 'Leader', 'Strength, Intelligence, Charisma');
-- INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
-- VALUES ('Wizard', 'Arcane', 'Controller', 'Intelligence, Wisdom, Dexterity');


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
CREATE TABLE powers (
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