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
	"source" TEXT NOT NULL,
	"keystat" TEXT NOT NULL,
	"armor" TEXT NOT NULL,
	"weapon" TEXT NOT NULL,
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
  OIDS=false
);
--------------------------------------------------------------------------------
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
  OIDS=false
);
--------------------------------------------------------------------------------
CREATE TABLE "powers" (
	"name" TEXT NOT NULL,
	"origin" TEXT NOT NULL,
	"level" integer NOT NULL,
	"flavor" TEXT NOT NULL,
	"encountertype" TEXT NOT NULL DEFAULT 'Encounter',
	"keywords" TEXT NOT NULL,
	"actiontype" TEXT NOT NULL,
	"range" TEXT NOT NULL,
	"target" TEXT,
	"attack" TEXT ,
	"trigger" TEXT,
	"hit" TEXT,
	"effect" TEXT,
	"miss" TEXT,
	"special" TEXT,
	"sustain" TEXT,
	"book" TEXT NOT NULL DEFAULT 'PHB1',
	CONSTRAINT powers_pk PRIMARY KEY ("name")
) WITH (
  OIDS=false
);
--------------------------------------------------------------------------------
CREATE TABLE "feats" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"benefit" TEXT NOT NULL,
	"special" TEXT,
	"level" integer,
	"race" TEXT,
	"class" TEXT,
	"source" TEXT,
	"str" integer NOT NULL DEFAULT 0,
	"con" integer NOT NULL DEFAULT 0,
	"dex" integer NOT NULL DEFAULT 0,
	"int" integer NOT NULL DEFAULT 0,
	"wis" integer NOT NULL DEFAULT 0,
	"cha" integer NOT NULL DEFAULT 0,
	"acrobatics" BOOLEAN NOT NULL DEFAULT false,
	"arcana" BOOLEAN NOT NULL DEFAULT false,
	"athletics" BOOLEAN NOT NULL DEFAULT false,
	"bluff" BOOLEAN NOT NULL DEFAULT false,
	"dungeoneering" BOOLEAN NOT NULL DEFAULT false,
	"endurance" BOOLEAN NOT NULL DEFAULT false,
	"heal" BOOLEAN NOT NULL DEFAULT false,
	"intimidate" BOOLEAN NOT NULL DEFAULT false,
	"nature" BOOLEAN NOT NULL DEFAULT false,
	"perception" BOOLEAN NOT NULL DEFAULT false,
	"religion" BOOLEAN NOT NULL DEFAULT false,
	"stealth" BOOLEAN NOT NULL DEFAULT false,
	"feat" TEXT,
	"god" TEXT,
	"armor_proficiency" TEXT,
	CONSTRAINT feats_pk PRIMARY KEY ("id")
) WITH (
  OIDS=false
);
--------------------------------------------------------------------------------
CREATE TABLE "users" (
	"username" varchar(20) NOT NULL,
	"password" varchar(20) NOT NULL,
	" character" integer NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY ("username")
) WITH (
  OIDS=false
);
--------------------------------------------------------------------------------
CREATE TABLE "character" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"level" integer NOT NULL DEFAULT '1',
	"race" TEXT NOT NULL UNIQUE,
	"class" TEXT NOT NULL UNIQUE,
	"source" TEXT NOT NULL UNIQUE,
	"str" integer NOT NULL DEFAULT 10,
	"con" integer NOT NULL DEFAULT 10,
	"dex" integer NOT NULL DEFAULT 10,
	"int" integer NOT NULL DEFAULT 10,
	"wis" integer NOT NULL DEFAULT 10,
	"cha" integer NOT NULL DEFAULT 10,
	"acrobatics" BOOLEAN NOT NULL DEFAULT false,
	"arcana" BOOLEAN NOT NULL DEFAULT false,
	"athletics" BOOLEAN NOT NULL DEFAULT false,
	"bluff" BOOLEAN NOT NULL DEFAULT false,
	"dungeoneering" BOOLEAN NOT NULL DEFAULT false,
	"endurance" BOOLEAN NOT NULL DEFAULT false,
	"heal" BOOLEAN NOT NULL DEFAULT false,
	"intimidate" BOOLEAN NOT NULL DEFAULT false,
	"nature" BOOLEAN NOT NULL DEFAULT false,
	"perception" BOOLEAN NOT NULL DEFAULT false,
	"religion" BOOLEAN NOT NULL DEFAULT false,
	"stealth" BOOLEAN NOT NULL DEFAULT false,
	"feats" TEXT NOT NULL,
	"god" TEXT NOT NULL,
	"armor_proficiency" TEXT NOT NULL UNIQUE,
	"weapon_proficiency" TEXT NOT NULL UNIQUE,
	CONSTRAINT character_pk PRIMARY KEY ("id")
) WITH (
  OIDS=false
);
--------------------------------------------------------------------------------
CREATE TABLE "books" (
	"book" TEXT NOT NULL,
	"book_name" TEXT NOT NULL,
	CONSTRAINT books_pk PRIMARY KEY ("book")
) WITH (
  OIDS=false
);
--------------------------------------------------------------------------------
DROP ROLE IF EXISTS dnduser;
CREATE USER dnduser;
--Enter dnd without quotes when prompted 
\password dnduser
GRANT SELECT ON class, feats, powers, race, books to dnduser;
GRANT SELECT, INSERT ON character, users to dnduser;
GRANT ALL ON character_id_seq to dnduser;

--
-- Table Dump for Class
--
-- PLAYER HANDBOOK 1 CLASSES
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Cleric', 'Leader', 'Divine', 'Wisdom, Strength, Charisma', 'Cloth, leather, hide, chainmail', 'Simple melee, simple ranged', 'Holy Symbol', '+2 to Will', 12, 5, 7, 'Trained Skills: Religion. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Arcana (Int), Diplomacy (Cha), Heal (Wis), History (Int), Insight (Wis), Religion (Int)', 
E'Channel Divinity: Once per encounter you can invoke divine power, filling yourself with the might of your patron deity. With the divine might you invoke you can wield special powers, such as turn undead and divine fortune. Some Clerics learn other uses for this feature; for instance, the divinity feats in Chapter 6 grant characters with access to the Channel Divinity class feature the ability to use additional special powers.Regardless of how many different uses for Channel Divinity you know, you can use only one such ability per encounter. The special ability or power you invoke works just like your other powers. <br/><br/> Healer’s Lore: Your study of healing allows you to make the most of your healing prayers. When you grant healing with one of your Cleric powers that has the healing keyword, add your Wisdom modifier to the hit points the recipient regains. <br/><br/> Healing Word: Using the healing word power, Clerics can grant their comrades additional resilience with nothing more than a short prayer. <br/><br/> Ritual Casting: You gain the Ritual Caster feat (page 200) as a bonus feat, allowing you to use magical rituals (see Chapter 10). You possess a ritual book, and it contains two rituals you have mastered: the Gentle Repose ritual and one other 1st-level ritual of your choice.');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Fighter', 'Defender', 'Martial', 'Strength, Wisdom, Dexterity, Constitution', 'Cloth, leather, hide, chainmail, scale; light shield, heavy shield', 'Simple melee, military melee, simple ranged, military ranged', '+2 Fortitude', 15, 6, 9, 'Trained Skills: From the class skills list below, choose three trained skills at 1st level. Class Skills: Athletics (Str), Endurance (Con), Heal (Wis), Intimidate (Cha), Streetwise (Cha)',
E'Combat Challenge: In combat, it’s dangerous to ignore a Fighter. Every time you attack an enemy, whether the attack hits or misses, you can choose to mark that target. The mark lasts until the end of your next turn. While a target is marked, it takes a –2 penalty to attack rolls for any attack that doesn’t include you as a target. A creature can be subject to only one mark at a time. A new mark supersedes a mark that was already in place. In addition, whenever a marked enemy that is adjacent to you shifts or makes an attack that does not include you, you can make a melee basic attack against that enemy as an immediate interrupt. <br/><br/> Combat Superiority: You gain a bonus to opportunity attacks equal to your Wisdom modifier. An enemy struck by your opportunity attack stops moving, if a move provoked the attack. If it still has actions remaining, it can use them to resume moving. <br/><br/> Fighter Weapon Talent: Choose either one-handed or two-handed weapons. When using a weapon of your chosen style, you gain a +1 bonus to attack rolls. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Paladin', 'Defender', 'Divine', 'Strength, Charisma, Wisom', 'Cloth, leather, hide, chainmail, scale, plate; light shield, heavy shield', 'Simple melee, military melee, simple ranged', 'Holy Symbol', '+1 Fortitude, +1 Reflex, +1 Will', 15, 6, 10, 'Trained Skills: Religion. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Diplomacy (Cha), Endurance (Con), Heal (Wis), History (Int), Insight (Wis), Intimidate (Cha), Religion (Int)',
E'Channel Divinity: Once per encounter you can invoke divine power, filling yourself with the might of your patron deity. With the divine might you invoke you can wield special powers, such as divine mettle and divine strength. Some Paladins learn other uses for this feature; for instance, the divinity feats in Chapter 6 grant characters with access to the Channel Divinity class feature the ability to use additional special powers. Regardless of how many different uses for Channel Divinity you know, you can use only one such ability per encounter. The special ability or power you invoke works just like your other powers. <br/><br/> Divine Challenge: The challenge of a Paladin is filled with divine menace. You can use the divine challenge power to mark an enemy of your choice. <br/><br/> Lay on Hands: Using the lay on hands power, Paladins can grant their comrades additional resilience with a touch of their hands and a short prayer, though they must give of their own strength to do so. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Ranger', 'Martial', 'Striker', 'Strength, Dexterity, Wisdom', 'Cloth, leather, hide', 'Simple melee, military melee, simple ranged, military ranged', '+1 Fortitude, +1 Reflex', 12, 5, 6, 'Trained Skills: Dungeoneering or Nature (your choice). From the class skills list below, choose four more trained skills at 1st level. Class Skills: Acrobatics (Dex), Athletics (Str), Dungeoneering (Wis), Endurance (Con), Heal (Wis), Nature (Wis), Perception (Wis), Stealth (Dex)',
E'Fighting Style: Choose one of the following fighting styles and gain its benefit. Archer Fighting Style: Because of your focus on ranged attacks, you gain Defensive Mobility as a bonus feat. Two-Blade Fighting Style: Because of your focus on two-weapon melee attacks, you can wield a one-handed weapon in your off hand as if it were an off-hand weapon. (Make sure to designate on your character sheet which weapon is main and which is offhand.) In addition, you gain Toughness as a bonus feat. <br/><br/> Hunter’s Quarry: Once per turn as a minor action, you can designate the enemy nearest to you as your quarry. Once per round, you deal extra damage to your quarry. The extra damage is based on your level. If you can make multiple attacks in a round, you decide which attack to apply the extra damage to after all the attacks are rolled. The hunter’s quarry effect remains active until the end of the encounter, until the quarry is defeated, or until you designate a different target as your quarry. You can designate one enemy as your quarry at a time. <br/><br/> Prime Shot: If none of your allies are nearer to your target than you are, you receive a +1 bonus to ranged attack rolls against that target. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Rogue', 'Martial', 'Striker', 'Dexterity, Strenght, Charisma', 'Cloth, leather', 'Dagger, hand crossbow, shuriken, sling, short sword', '+2 Reflex', 12, 5, 6, 'Trained Skills: Stealth and Thievery. From the class skills list below, choose four more trained skills at 1st level. Class Skills: Acrobatics (Dex), Athletics (Str), Bluff (Cha), Dungeoneering (Wis), Insight (Wis), Intimidate (Cha), Perception (Wis), Stealth (Dex), Streetwise (Cha), Thievery (Dex)',
E'First Strike: At the start of an encounter, you have combat advantage against any creatures that have not yet acted in that encounter. <br/><br/> Rogue Tactics: Rogues operate in a variety of ways. Some Rogues use their natural charm and cunning trickery to deceive foes. Others rely on brute strength to overcome their enemies. Choose one of the following options. Artful Dodger: You gain a bonus to AC equal to your Charisma modifier against opportunity attacks. Brutal Scoundrel: You gain a bonus to Sneak Attack damage equal to your Strength modifier. The choice you make also provides bonuses to certain Rogue powers. Individual powers detail the effects (if any) your Rogue Tactics selection has on them. <br/><br/> Rogue Weapon Talent: When you wield a shuriken, your weapon damage die increases by one size. When you wield a dagger, you gain a +1 bonus to attack rolls. <br/><br/> Sneak Attack: Once per round, when you have combat advantage against an enemy and are using a weapon from the light blade, the crossbow, or the sling weapon group, an attack you make against that enemy deals extra damage if the attack hits. You decide whether to apply the extra damage after making the damage roll. As you advance in level, your extra damage increases.');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Warlock', 'Arcane', 'Striker', 'Charisma, Constitution, Intelligence', 'Cloth, leather', 'Simple melee, simple ranged', 'Rods, wands', '+1 Reflex, +1 Will', 12, 5, 6, 'Trained Skills: From the class skills list below, choose four trained skills at 1st level. Class Skills: Arcana (Int), Bluff (Cha), History (Int), Insight (Wis), Intimidate (Cha), Religion (Int), Streetwise (Cha), Thievery (Dex)',
E'Eldritch Blast: All Warlocks know the eldritch blast at-will power. This power can be used as a basic attack. You gain this power as well as another at-will power as determined by your Eldritch Pact. <br/><br/> Eldritch Pact: You have forged a pact with mysterious entities that grant you your arcane powers. Choose one of the following pacts: fey pact, infernal pact, or star pact. The pact you choose determines the following Warlock abilities: At-Will Spells: Your pact determines one of the atwill spells you know. Pact Boon: Each pact includes a pact boon. The pact boon is a granted power you can use to further hex your enemies. The pact you take also provides bonuses to certain Warlock powers. Individual powers detail the effects (if any) your Eldritch Pact selection has on them. <br/><br/> Fey Pact: You have forged a bargain with ancient, amoral powers of the Feywild. Some are primitive earth spirits, grim and menacing; some are capricious wood, sky, or water spirits; and others are incarnations of seasons or natural forces who roam the faerie realm like wild gods. They bestow magic that ranges from feral and savage to wondrous and enchanting. Eyebite: You know the eyebite at-will spell. Misty Step: You have the Misty Step pact boon. You instantly transform into silver mist that streams a short distance and reforms, allowing you to flee or maneuver to set up a deadly attack. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you can immediately teleport 3 squares as a free action. <br/><br/> Infernal Pact: Long ago a forgotten race of devils created a secret path to power and taught it to the tieflings of old to weaken their fealty to Asmodeus. In his wrath, Asmodeus destroyed the scheming devils and struck their very names from the memory of all beings—but you dare to study their perilous secrets anyway. Hellish Rebuke: You know the hellish rebuke at-will spell. Dark One’s Blessing: You have the Dark One’s Blessing pact boon. You instantly gain vitality from a cursed enemy when that enemy falls. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you immediately gain temporary hit points equal to your level. <br/><br/> Star Pact: You have mastered the astrologer’s art, learning the secret names of the stars and gazing into the Far Realm beyond, gaining great power thereby. You can call upon powers that madden or terrify your enemies, manipulate chance and fate, or scour your foes with icy banes and curses drawn from beyond the night sky. Dire Radiance: You know the dire radiance at-will spell. Fate of the Void: You have the Fate of the Void pact boon. Your curse intermingles with the lost vitality of a cursed enemy to reveal a glimpse of the future to you. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you gain a +1 bonus to any single d20 roll you make during your next turn (attack roll, saving throw, skill check, or ability check). If you don’t use this bonus by the end of your turn, it is lost. This bonus is cumulative; if three cursed enemies drop to 0 hit points or fewer before your next turn, you gain a +3 bonus to a d20 roll during your turn. <br/><br/> Prime Shot: If none of your allies are nearer to your target than you are, you receive a +1 bonus to ranged attack rolls against that target. <br/><br/> Shadow Walk: On your turn, if you move at least 3 squares away from where you started your turn, you gain concealment until the end of your next turn. <br/><br/> Warlock’s Curse: Once per turn as a minor action, you can place a Warlock’s Curse on the enemy nearest to you that you can see. A cursed enemy is more vulnerable to your attacks. If you damage a cursed enemy, you deal extra damage. You decide whether to apply the extra damage after making the damage roll. You can deal this extra damage once per round. A Warlock’s Curse remains in effect until the end of the encounter or until the cursed enemy drops to 0 hit points or fewer. You can place a Warlock’s Curse on multiple targets over the course of an encounter; each curse requires the use of a minor action. You can’t place a Warlock’s Curse on a creature that is already affected by your or another character’s Warlock’s Curse.');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Warlord', 'Martial', 'Leader', 'Strength, Intelligence, Charisma', 'Cloth, leather, hide, chainmail; light shield', 'Simple melee, military melee, simple ranged', '+1 Fortitude, +1 Will', 12, 5, 7, 'Trained Skills: From the class skills list below, choose four trained skills at 1st level. Class Skills: Athletics (Str), Diplomacy (Cha), Endurance (Con), Heal (Wis), History (Int), Intimidate (Cha)', 
E'Combat Leader: You and each ally within 10 squares who can see and hear you gain a +2 power bonus to initiative. <br/><br/> Commanding Presence: Choose one of the following two benefits. Inspiring Presence: When an ally who can see you spends an action point to take an extra action, that ally also regains lost hit points equal to one-half your level + your Charisma modifier. Tactical Presence: When an ally you can see spends an action point to make an extra attack, the ally gains a bonus to the attack roll equal to one-half your Intelligence modifier. The choice you make also provides bonuses to certain Warlord powers. Individual powers detail the effects (if any) your Commanding Presence selection has on them. <br/><br/> Inspiring Word: Using the inspiring word power, Warlords can grant their comrades additional resilience with nothing more than a shout of encouragement.');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Wizard', 'Arcane', 'Controller', 'Intelligence, Wisdom, Dexterity', 'Cloth', 'Dagger, quarterstaff', 'Orbs, staffs, wands', '+2 Will', 10, 4, 6, 'Trained Skills: Arcana. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Arcana (Int), Diplomacy (Cha), Dungeoneering (Wis), History (Int), Insight (Wis), Nature (Int), Religion (Int)',
E'Arcane Implement Mastery: You specialize in the use of one kind of implement to gain additional abilities when you wield it. Choose one of the following forms of implement mastery. Orb of Imposition: Once per encounter as a free action, you can use your orb to gain one of the following two effects. You can designate one creature you have cast a Wizard spell upon that has an effect that lasts until the subject succeeds on a saving throw. That creature takes a penalty to its saving throws against that effect equal to your Wisdom modifier. Alternatively, you can choose to extend the duration of an effect created by a Wizard at-will spell (such as cloud of daggers or ray of frost) that would otherwise end at the end of your current turn. The effect instead ends at the end of your next turn. You must wield an orb to use this ability. Control Wizards select this form of mastery because it helps extend the duration of their control effects. <br/> Staff of Defense: A staff of defense grants you a +1 bonus to AC. In addition, once per encounter as an immediate interrupt, you gain a bonus to defense against one attack equal to your Constitution modifier. You can declare the bonus after the Dungeon Master has already told you the damage total. You must wield your staff to benefit from these features. This form of mastery is useful for all Wizards, particularly if you dabble in both control and damage-dealing spells. <br/> Wand of Accuracy: Once per encounter as a free action, you gain a bonus to a single attack roll equal to your Dexterity modifier. You must wield your wand to benefit from this feature. This form of mastery is good for war Wizards because it helps increase their accuracy with damaging powers. <br/><br/> Cantrips: Cantrips are minor spells you gain at 1st level. You can use the ghost sound, light, mage hand, and prestidigitation cantrips as at-will powers. <br/><br/> Ritual Casting: You gain the Ritual Caster feat (page 200) as a bonus feat, allowing you to use magical rituals (see Chapter 10). <br/><br/> Spellbook: You possess a spellbook, a book full of mystic lore in which you store your rituals and your daily and utility spells. Rituals: Your book contains three 1st-level rituals of your choice that you have mastered. At 5th level, and again at 11th, 15th, 21st, and 25th level, you master two more rituals of your choice and add them to your spellbook. Any ritual you add must be your level or lower. Daily and Utility Spells: Your spellbook also holds your daily and utility spells. You begin knowing two daily spells, one of which you can use on any given day. Each time you gain a level that lets you select a daily spell or a utility spell, choose two different daily spells or utility spells of that level to add to your book. After an extended rest, you can prepare a number of daily and utility spells according to what you can cast per day for your level. You can’t prepare the same spell twice. If you replace a spell because of gaining a level or through retraining, the previous spell vanishes from your spellbook and is replaced by the new spell. Capacity: A typical spellbook has 128 pages. Each spell takes up 1 page. A ritual takes up a number of pages equal to its level.');

--
-- Table Dump for Race
--
-- PLAYER HANDBOOK ONE RACES
INSERT INTO race (name, stats, language, skill, traits)
VALUES ('Human', '+2 to one ability score of your choice', 'common and one language of your choice', 'no skill bonuses',
E'Bonus Feat: You gain a bonus feat at 1st level. You must meet the feat''s prerequisites. <br/><br/> Bonus Skill: You gain training in one additional skill from your class skills list. <br/><br/> Human defense Bonus: You gain a +1 racial bonus to Fortitude, Reflex and Will. <br/><br/> Heroic Effort: You have the Heroic Effort power.');
INSERT INTO race (name, stats, language, skill, traits)
VALUES ('Dragonborn', '+2 Strength, +2 Charisma', 'Common, Draconic', '+2 History, +2 Intimidate', 
E'Dragonborn Fury: When you’re bloodied, you gain a +1 racial bonus to attack rolls. <br/><br/> Draconic Heritage: Your healing surge value is equal to one-quarter of your maximum hit points + your Constitution modifier. <br/><br/> Dragon Breath: You can use dragon breath as an encounter power.');
INSERT INTO race (name, stats, speed, vision, language, skill, traits)
VALUES ('Dwarf', '+2 Constitution, +2 Wisdom', 5, 'low-light', 'Common, Dwarven', '+2 Dungeoneering, +2 Endurance',
E'Cast-Iron Stomach: +5 racial bonus to saving throws against poison. <br/><br/> Dwarven Resilience: You can use your second wind as a minor action instead of a standard action. <br/><br/> Dwarven Weapon Proficiency: You gain proficiency with the throwing hammer and the warhammer. <br/><br/> Encumbered Speed: You move at your normal speed even when it would normally be reduced by armor or a heavy load. Other effects that limit speed (such as difficult terrain or magical effects) affect you normally. <br/><br/> Stand Your Ground: When an effect forces you to move—through a pull, a push, or a slide—you can move 1 square less than the effect specifies. This means an effect that normally pulls, pushes, or slides a target 1 square does not force you to move unless you want to. In addition, when an attack would knock you prone, you can immediately make a saving throw to avoid falling prone.');
INSERT INTO race (name, stats, vision, language, skill, traits)
VALUES ('Eladrin', '+2 Dexterity, +2 Intelligence', 'Low-Light', 'Common, Elven', '+2 Arcana, +2 History',
E'Eladrin Education: You gain training in one additional skill selected from the skill list in Chapter 5. Eladrin Weapon Proficiency: You gain proficiency with the longsword. <br/><br/> Eladrin Will: You gain a +1 racial bonus to your Will defense. In addition, you gain a +5 racial bonus to saving throws against charm effects. <br/><br/> Fey Origin: Your ancestors were native to the Feywild, so you are considered a fey creature for the purpose of effects that relate to creature origin. <br/><br/> Trance: Rather than sleep, eladrin enter a meditative state known as trance. You need to spend 4 hours in this state to gain the same benefits other races gain from taking a 6-hour extended rest. While in a trance, you are fully aware of your surroundings and notice approaching enemies and other events as normal. <br/><br/> Fey Step: You can use fey step as an encounter power.');
INSERT INTO race (name, stats, speed, vision, language, skill, traits)
VALUES ('Elf', '+2 Dexterity, +2 Wisdom', 7, 'Low-Light', 'Common, Elven', '+2 Nature, +2 Perception',
E'Elven Weapon Proficiency: You gain proficiency with the longbow and the shortbow. <br/><br/> Fey Origin: Your ancestors were native to the Feywild, so you are considered a fey creature for the purpose of effects that relate to creature origin. Group Awareness: You grant non-elf allies within 5 squares of you a +1 racial bonus to Perception checks. <br/><br/> Wild Step: You ignore difficult terrain when you shift (even if you have a power that allows you to shift multiple squares). <br/><br/> Elven Accuracy: You can use elven accuracy as an encounter power.');
INSERT INTO race (name, stats, vision, language, skill, traits)
VALUES ('Half-Elf', '+2 Constitution, +2 Charisma', 'Low-Light', 'Common, Elven, Choice of another', '+2 Diplomacy, +2 Insight',
E'Dilettante: At 1st level, you choose an at-will power from a class different from yours. You can use that power as an encounter power. <br/><br/> Dual Heritage: You can take feats that have either elf or human as a prerequisite (as well as those specifically for half-elves), as long as you meet any other requirements. <br/><br/> Group Diplomacy: You grant allies within 10 squares of you a +1 racial bonus to Diplomacy checks.');
INSERT INTO race (name, stats, size, language, skill, traits)
VALUES ('Halfling', '+2 Dexterity, +2 Charisma', 'Small', 'Common, Choice of another', '+2 Acrobatics, +2 Thievery',
E'Bold: You gain a +5 racial bonus to saving throws against fear. <br/><br/> Nimble Reaction: You gain a +2 racial bonus to AC against opportunity attacks. <br/><br/> Second Chance: You can use second chance as an encounter power.');
INSERT INTO race (name, stats, vision, language, skill, traits)
VALUES ('Tiefling', '+2 Charisma, +2 Intelligence', 'Low-Light', 'Common, Choice of another', '+2 Bluff, +2 Stealth',
'Bloodhunt: You gain a +1 racial bonus to attack rolls against bloodied foes. <br/><br/> Fire Resistance: You have resist fire 5 + one-half your level. <br/><br/> Infernal Wrath: You can use infernal wrath as an encounter power.');

--
-- Table Dump for Feats
--
-- PLAYER HANDBOOK 1 FEATS
INSERT INTO feats (name, benefit, race) VALUES('Action Surge', 'You gain a +3 bonus to attack rolls you make during any action you gained by spending an action point.', 'Human');
INSERT INTO feats (name, benefit, dex, class) VALUES('Agile Hunter', 'When you score a critical hit with a melee attack against the target of your Hunter’s Quarry, you can shift as a free action, and the enemy takes a –2 penalty on attack rolls against you until the end of your next turn.', 15, 'Ranger');
INSERT INTO feats (name, benefit) VALUES('Alertness', 'You don’t grant enemies combat advantage during surprise rounds. You also gain a +2 feat bonus to Perception checks.');
INSERT INTO feats (name, benefit, god) VALUES('Armor of Bahamut', 'You can invoke the power of your deity to use armor of Bahamut. [Power]', 'Bahamut');
INSERT INTO feats (name, benefit, str, con, armor_proficiency) VALUES('Armor Proficiency (Chainmail)', 'You gain training with chainmail.', 13, 13, 'leather');
INSERT INTO feats (name, benefit, str, con, armor_proficiency) VALUES('Armor Proficiency (Hide)', 'You gain training with hide.', 13, 13, 'leather');
INSERT INTO feats (name, benefit) VALUES('Armor Proficiency (Leather)', 'You gain training with leather.');
INSERT INTO feats (name, benefit, str, con, armor_proficiency) VALUES('Armor Proficiency (Scale)', 'You gain training with scale.', 13, 13, 'chainmail');
INSERT INTO feats (name, benefit, str, con, armor_proficiency) VALUES('Armor Proficiency (Plate)', 'You gain training with plate.', 15, 15, 'scale');
INSERT INTO feats (name, benefit, dex, cha) VALUES('Astral Fire', 'You gain a +1 feat bonus to damage rolls when you use a power that has the fire or radiant keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.', 13, 13);
INSERT INTO feats (name, benefit, god) VALUES('Avandra''s Rescue', 'You can invoke the power of your deity to use Avandra''s Rescue. [Power]', 'Avandra');
INSERT INTO feats (name, benefit, class) VALUES('Backstabber', 'The extra damage dice from your Sneak Attack class feature increase from d6s to d8s.', 'Rogue');
INSERT INTO feats (name, benefit, str, dex) VALUES('Blade Opportunist', 'You gain a +2 bonus to opportunity attack rolls with a heavy blade or a light blade.', 13, 13);
INSERT INTO feats (name, benefit, int, wis) VALUES('Burning Blizzard', 'You gain a +1 feat bonus to damage rolls when you use a power that has the acid or cold keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.', 13, 13);
INSERT INTO feats (name, benefit, dex) VALUES('Combat Reflexes', 'You gain a +1 bonus to opportunity attack rolls.', 13);
INSERT INTO feats (name, benefit, god) VALUES('Corellon''s Grace', 'You can invoke the power of your deity to use Corellon''s grace. [Power]', 'Corellon');
INSERT INTO feats (name, benefit, con, wis) VALUES('Dark Fury', 'You gain a +1 feat bonus to damage rolls when you use a power that has the necrotic or psychic keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.', 13, 13);
INSERT INTO feats (name, benefit) VALUES('Defensive Mobility', 'You gain a +2 bonus to AC against opportunity attacks.');
INSERT INTO feats (name, benefit, special, wis, class) VALUES('Distracting Shield', 'If you hit a foe with an attack granted by your Combat Challenge class feature, the target takes a –2 penalty to attack rolls until the start of your next turn.', 'You must have a shield equipped to benefit from this feat.', 15, 'Fighter');
INSERT INTO feats (name, race, benefit) VALUES('Dodge Giants', 'Dwarf', 'You gain a +1 bonus to AC and Reflex defense against the attacks of Large or larger foes.');
INSERT INTO feats (name, race, benefit) VALUES('Dragonborn Frenzy', 'Dragonborn', 'While you are bloodied, you gain a +2 bonus to damage rolls.');
INSERT INTO feats (name, race, benefit) VALUES('Dragonborn Senses', 'Dragonborn', 'You gain low-light vision. You gain a +1 feat bonus to Perception checks.');
INSERT INTO feats (name, benefit) VALUES('Durable', 'Increase your number of healing surges by two');
INSERT INTO feats (name, race, benefit) VALUES('Dwarven Weapon Training', 'Dwarf', 'You gain proficiency and a +2 feat bonus to damage rolls with axes and hammers.');
INSERT INTO feats (name, race, benefit) VALUES('Eladrin Soldier', 'Eladrin', 'You gain proficiency with all spears and a +2 feat bonus to damage rolls with longswords and all spears.');
INSERT INTO feats (name, race, benefit) VALUES('Elven Precision', 'Elf, elven accuracy racial power', 'When you use the elven accuracy power, you gain a +2 bonus to the new attack roll.');
INSERT INTO feats (name, race, benefit) VALUES('Enlarged Dragon Breath', 'Dragonborn, dragon breath racial power', 'When you use your dragon breath power, you can choose to make it blast 5 instead of blast 3.');
INSERT INTO feats (name, acrobatics, benefit) VALUES('Escape Artist', true, 'You can attempt to escape a grab as a minor action, instead of as a move action. You gain a +2 feat bonus to Acrobatics checks.');
INSERT INTO feats (name, benefit, wis, class) VALUES('Expanded Spellbook', 'Choose one daily Wizard attack spell of every level you know. Add this spell to your spellbook. Each time you gain a new level of daily Wizard attack spells, you learn one extra spell of that level (in other words, add three spells to your spellbook instead of only two). This feat doesn’t change the number of daily attack spells you can prepare each day.', 13, 'Wizard');
INSERT INTO feats (name, benefit, dex) VALUES('Far Shot', 'When you use a projectile weapon such as a bow or a crossbow, increase both the normal range and the long range by 5 squares.', 13);
INSERT INTO feats (name, benefit, str) VALUES('Far Throw', 'When you use a thrown weapon such as a dagger or a javelin, increase both the normal range and the long range by 2 squares.', 13);
INSERT INTO feats (name, benefit, con) VALUES('Fast Runner', 'You gain a +2 bonus to speed when you charge or run.', 13);
INSERT INTO feats (name, benefit, race) VALUES('Ferocious Rebuke', 'When you use the infernal wrath power and hit with an attack, you can push the target 1 square in addition to any damage you deal.', 'Tiefling');
INSERT INTO feats (name, race, benefit) VALUES('Group Insight', 'Half-elf', 'You grant allies within 10 squares of you a +1 racial bonus to Insight checks and initiative checks.');
INSERT INTO feats (name, race, benefit) VALUES('Halfling Agility', 'Halfling', 'When you use your halfling second chance ability, the attacker takes a –2 penalty to the new attack roll.');
INSERT INTO feats (name, benefit, god) VALUES('Harmony of Erathis', 'You can invoke the power of your deity to use harmony of Erathis. [Power]', 'Erathis');
INSERT INTO feats (name, class, benefit) VALUES('Healing Hands', 'Paladin', 'When you use the lay on hands power, the affected ally regains additional hit points equal to your Charisma modifier.');
INSERT INTO feats (name, race, benefit) VALUES('Hellfire Blood', 'Tiefling', 'You gain a +1 feat bonus to attack rolls and damage rolls when you use a power that has the fire or fear keyword.');
INSERT INTO feats (name, race, benefit) VALUES('Human Perseverance', 'Human', 'You gain a +1 feat bonus to saving throws.');
INSERT INTO feats (name, benefit, con, class) VALUES('Improved Dark One''s Blessing', 'Your Dark One’s Blessing now gives you 3 additional temporary hit points.', 15, 'Warlock');
INSERT INTO feats (name, benefit, con, cha, class) VALUES('Improved Fate of the Void', 'Your Fate of the Void grants an additional +1 bonus to the d20 roll.', 13, 13, 'Warlock');
INSERT INTO feats (name, benefit) VALUES('Improved Initiative', 'You gain a +4 feat bonus to initiative checks.');
INSERT INTO feats (name, benefit, int, class) VALUES('Improved Misty Step', 'Misty Step now allows you to teleport an additional 2 squares.', 13, 'Warlock');
INSERT INTO feats (name, class, benefit) VALUES('Inspired Recovery', 'Warlord', 'When an ally who can see you spends an action point to gain an extra standard action, that ally can roll a saving throw as a free action, adding your Charisma modifier to the roll.');
INSERT INTO feats (name, benefit, god) VALUES('Ioun''s Poise', 'You can invoke the power of your deity to use Ioun''s poise. [Power]', 'Ioun');
INSERT INTO feats (name, int, benefit) VALUES('Jack of All Trades', 13, 'You gain a +3 feat bonus to all untrained skill checks.');
INSERT INTO feats (name, benefit, god) VALUES('Kord''s Favor', 'You can invoke the power of your deity to use Kord''s favor. [Power]', 'Kord');
INSERT INTO feats (name, class, benefit) VALUES('Lethal Hunter', 'Ranger', 'The extra damage dice from your Hunter’s Quarry class feature increase from d6s to d8s.');
INSERT INTO feats (name, race, benefit) VALUES('Light Step', 'Elf', 'For the purpose of hourly or daily travel rates, add 1 to your overland speed and the speed of all allies in your traveling group. Add 5 to the DC required to find or follow your tracks. If traveling with allies, you can share this benefit with up to five other characters. You gain a +1 feat bonus to Acrobatics checks and Stealth checks.');
INSERT INTO feats (name, int, benefit) VALUES('Linguist', 13, 'Choose three languages. You can now speak, read, and write those languages fluently. Special: You can take this feat more than once. Each time you select this feat, choose three new languages to learn.');
INSERT INTO feats (name, athletics, benefit) VALUES('Long Jumper', true, 'You can make all long jumps as if you had a running start. You also gain a +1 feat bonus to Athletics checks.');
INSERT INTO feats (name, race, benefit) VALUES('Lost in the Crowd', 'Halfling', 'You gain a +2 bonus to AC when you are adjacent to at least two enemies larger than you.');
INSERT INTO feats (name, benefit, god) VALUES('Melora''s Tide', 'You can invoke the power of your deity to use Melora''s tide. [Power]', 'Melora');
INSERT INTO feats (name, benefit, god) VALUES('Moradin''s Resolve', 'You can invoke the power of your deity to use Moradin’s resolve. [Power]', 'Moradin');
INSERT INTO feats (name, benefit) VALUES('Mounted Combat', 'Benefit: When you ride a creature, you gain access to any special mount abilities it confers to its rider. Not every creature has these abilities. The Dungeon Master’s Guide has more information on mounts and mounted combat. While you are riding a creature, the creature can make any Athletics, Acrobatics, Endurance, or Stealth checks using your base skill check bonus rather than its own if yours is higher.');
INSERT INTO feats (name, dex, benefit) VALUES('Nimble Blade', 15, 'When you attack with a light blade and you have combat advantage, you gain a +1 bonus to attack rolls.');
INSERT INTO feats (name, benefit, god) VALUES('Pelor''s Radiance', 'You can invoke the power of your deity to use Pelor''s radiance. [Power]', 'Pelor');
INSERT INTO feats (name, con, class, benefit, special) VALUES('Potent Challenge', 15, 'Fighter', 'If you hit a foe with an attack granted by your Combat Challenge class feature, add your Constitution modifier to the damage roll.', 'This benefit applies only to attacks made with two-handed weapons.');
INSERT INTO feats (name, str, benefit) VALUES('Power Attack', 15, 'When making a melee attack, you can take a –2 penalty to the attack roll. If the attack hits, you gain a +2 bonus to the damage roll (or a +3 bonus to the damage roll with a two-handed weapon) per tier. The attack penalty remains the same.');
INSERT INTO feats (name, str, benefit) VALUES('Powerful Charge', 13, 'When you charge, you gain a +2 bonus to damage and a +2 bonus to bull rush attempts.');
INSERT INTO feats (name, wis, class, benefit) VALUES('Precise Hunter', 15, 'Ranger', 'When you score a critical hit against the target of your Hunter’s Quarry with a ranged attack, your allies gain a +1 bonus to attack rolls against that target until the start of your next turn.');
INSERT INTO feats (name, cha, class, benefit) VALUES('Press the Advantage', 15, 'Rogue', 'If you score a critical hit while you have combat advantage, you gain combat advantage against the target until the end of your next turn.');
INSERT INTO feats (name, dex, benefit) VALUES('Quick Draw', 13, 'You can draw a weapon (or an object stored in a belt pouch, bandolier, or similar container, such as a potion) as part of the same action used to attack with the weapon or use the object. You also gain a +2 feat bonus to initiative checks.');
INSERT INTO feats (name, con, dex, benefit) VALUES('Raging Storm', 13, 13, 'You gain a +1 feat bonus to damage rolls when you use a power that has the lightning or thunder keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.');
INSERT INTO feats (name, benefit, god) VALUES('Raven Queen''s Blessing', 'You can invoke the power of your deity to use Raven Queen''s blessing. [Power]', 'Raven Queen');
INSERT INTO feats (name, arcana, benefit) VALUES('Ritual Caster', true, 'You can master and perform rituals of your level or lower. See Chapter 10 for information on acquiring, mastering, and performing rituals. Even though some rituals use the Heal skill or the Nature skill, the Arcana skill or the Religion skill is required to understand how to perform rituals.');
INSERT INTO feats (name, religion, benefit) VALUES('Ritual Caster', true, 'You can master and perform rituals of your level or lower. See Chapter 10 for information on acquiring, mastering, and performing rituals. Even though some rituals use the Heal skill or the Nature skill, the Arcana skill or the Religion skill is required to understand how to perform rituals.');
INSERT INTO feats (name, benefit, god) VALUES('Sehanine''s Reversal', 'You can invoke the power of your deity to use Sehanine''s reversal. [Power]', 'Sehanine');
INSERT INTO feats (name, str, benefit, armor_proficiency) VALUES('Shield Proficiency (Heavy)', 15, 'You gain proficiency with heavy shields.', 'shield (light)');
INSERT INTO feats (name, str, benefit) VALUES('Shield Proficiency (Light)', 13, 'You gain proficiency with light shields.');
INSERT INTO feats (name, class, benefit, special) VALUES('Shield Push', 'Fighter', 'If you hit a foe with an attack granted by your Combat Challenge class feature, you push the target 1 square after dealing damage.', 'You must carry a shield to benefit from this feat.');
INSERT INTO feats (name, benefit, special) VALUES('Skill Focus', 'Choose a skill in which you have training. You have a +3 feat bonus to checks with that skill.', 'You can take this feat more than once. Each time you select this feat, choose a different skill.');
INSERT INTO feats (name, benefit, special) VALUES('Skill Training', 'You gain training in one skill. The skill need not be on your class skill list.', 'You can take this feat more than once. Each time you select this feat, choose a skill in which you are not trained.');
INSERT INTO feats (name, athletics, benefit) VALUES('Sure Climber', true, 'A successful Athletics check allows you to climb at your normal speed, rather than half speed. You also gain a +1 feat bonus to Athletics checks.');
INSERT INTO feats (name, str, class, benefit) VALUES('Surprise Knockdown', 15, 'Rogue', 'If you score a critical hit while you have combat advantage, you knock the target prone.');
INSERT INTO feats (name, class, benefit) VALUES('Tactical Assault', 'Warlord', 'When an ally who can see you spends an action point to make an attack, the attack’s damage roll gains a bonus equal to your Intelligence modifier.');
INSERT INTO feats (name, benefit) VALUES('Toughness', 'When you take this feat, you gain additional hit points. You gain an additional 5 hit points at each tier of play (at 1st, 11th, and 21st level).');
INSERT INTO feats (name, dex, feat, benefit) VALUES('Two-Weapon Defense', 13, 'Two-Weapon Fighting', 'While holding a melee weapon in each hand, you gain a +1 shield bonus to AC and Reflex.');
INSERT INTO feats (name, dex, benefit) VALUES('Two-Weapon Fighting', 13, 'While holding a melee weapon in each hand, you gain a +1 bonus to damage rolls with your main weapon.');
INSERT INTO feats (name, benefit, special) VALUES('Weapon Focus', 'Choose a specific weapon group, such as spears or heavy blades. You gain a +1 feat bonus o damage rolls with your chosen weapon group. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.', 'You can take this feat more than once. Each time you select this feat, choose another weapon group.');
INSERT INTO feats (name, benefit, special) VALUES('Weapon Proficiency', 'You gain proficiency in a single weapon of your choice', 'You can take this feat more than once. Each time you select this feat, choose another weapon.');
INSERT INTO feats (name, benefit) VALUES('Wintertouched', 'When attacking a creature that is vulnerable to cold, you gain combat advantage when you use a power that has the cold keyword.');


--PLAYER HANDBOOK ONE POWERS
-- Bare minimum entry is still quite large, below line is a template for beginning power entries
-- INSERT INTO powers (name, origin, level, flavor, encountertype, keywords, actiontype, range) VALUES ();
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, trigger, effect, special) 
VALUES ('Channel Divinity: Armor of Bahamut', 1, 'Feat', 'Bahamut protects you or a friend from devastating harm.', 'Divine', 'Immediate Interrupt', 'Ranged 5', 'An enemy scores a critical hit on you or an ally', 'Turn a critical hit against you or an ally within range into a normal hit', 'You must take the Armor of Bahamut feat to use this power');
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, target, effect, special) 
VALUES ('Channel Divinity: Avandra''s Rescue', 1, 'Feat', 'Avandra smiles upon you and helps you rescue a friend in need.', 'Divine', 'Move Action', 'Melee 1', 'One Ally', 'Shift into the space of an adjecent ally; that ally simultaneously shifts into your space. Your space and your ally''s spaces must be the same size.', 'You must take the Avandra''s Rescue feat to use this power');
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, trigger, effect, special) 
VALUES ('Channel Divinity: Corellon''s Grace', 1, 'Feat', 'Corellon''s grace allows you to move when others take action', 'Divine', 'Immediate Interrupt', 'Ranged 10', 'A creature within range tspends an action point to take an extra action.', 'You take a move action', 'You must take the Corellon''s Grace feat to use this power');
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, target, effect, special) 
VALUES ('Channel Divinity: Harmony of Erathis', 1, 'Feat', 'Erathis brings harmony of purpose to like-minded allies', 'Divine', 'Minor Action', 'Melee 1', 'One Ally', 'If you have at least three allies within range, grant one of those allies a +2 power bonus to the first attack roll he or she makes before the start of your next turn.', 'You must take the Harmony of Erathis feat to use this power');
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, target, effect, special) 
VALUES ('Channel Divinity: Ioun''s Poise', 1, 'Feat', 'Ioun grants strength of will to those she favors', 'Divine', 'Minor Action', 'Ranged 5', 'You or one Ally', 'The target gains a +5 power bonus to will defense until the start of your next turn.', 'You must take the Ioun''s Poise feat to use this power');
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, trigger, effect, special) 
VALUES ('Channel Divinity: Kord''s Favor', 1, 'Feat', 'Kord favors a strong hit in vombat with healing.', 'Divine, Healing', 'Free Action', 'Ranged 5', 'You or an ally scores a critical hit with a melee attack.', 'You or the ally can spend a healing surge', 'You must take the Kord''s Favor feat to use this power');
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, target, effect, special) 
VALUES ('Channel Divinity: Melora''s Tide', 1, 'Feat', 'Melora sends a tide of healing energy to aid you or a bloodied friend.', 'Divine, Healing', 'Minor Action', 'Ranged 5', 'You or one Ally; bloodied target only', 'The target gains regeneration 2, per tier, until the end of the encounter or until he or she is no longer bloodied.', 'You must take the Melora''s Tide feat to use this power');
INSERT INTO powers (name, level, origin, flavor, keywords, actiontype, range, target, effect, special) 
VALUES ('Channel Divinity: Moradin''s Resolve', 1, 'Feat', 'Moradin''s  blessing puts the small on more equal footing with the large', 'Divine', 'Minor Action', 'Personal', 'You or one Ally; bloodied target only', 'The target gains regeneration 2, per tier, until the end of the encounter or until he or she is no longer bloodied.', 'You must take the Melora''s Tide feat to use this power');
