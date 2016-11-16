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

--PLAYER HANDBOOK ONE RACES
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
--END PLAYER HANDBOOK 1 RACES



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
    implement varchar(50) NOT NULL default 'None',
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

--PLAYER HANDBOOK 1 CLASSES
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Cleric', 'Leader', 'Divine', 'Wisdom, Strength, Charisma', 'Cloth, leather, hide, chainmail', 'Simple melee, simple ranged', 'Holy Symbol', '+2 to Will', 12, 5, 7, 'Trained Skills: Religion. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Arcana (Int), Diplomacy (Cha), Heal (Wis), History (Int), Insight (Wis), Religion (Int)', 
E'Channel Divinity: Once per encounter you can invoke divine power, filling yourself with the might of your patron deity. With the divine might you invoke you can wield special powers, such as turn undead and divine fortune. Some clerics learn other uses for this feature; for instance, the divinity feats in Chapter 6 grant characters with access to the Channel Divinity class feature the ability to use additional special powers.Regardless of how many different uses for Channel Divinity you know, you can use only one such ability per encounter. The special ability or power you invoke works just like your other powers. <br/><br/> Healer’s Lore: Your study of healing allows you to make the most of your healing prayers. When you grant healing with one of your cleric powers that has the healing keyword, add your Wisdom modifier to the hit points the recipient regains. <br/><br/> Healing Word: Using the healing word power, clerics can grant their comrades additional resilience with nothing more than a short prayer. <br/><br/> Ritual Casting: You gain the Ritual Caster feat (page 200) as a bonus feat, allowing you to use magical rituals (see Chapter 10). You possess a ritual book, and it contains two rituals you have mastered: the Gentle Repose ritual and one other 1st-level ritual of your choice.');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Fighter', 'Defender', 'Martial', 'Strength, Wisdom, Dexterity, Constitution', 'Cloth, leather, hide, chainmail, scale; light shield, heavy shield', 'Simple melee, military melee, simple ranged, military ranged', '+2 Fortitude', 15, 6, 9, 'Trained Skills: From the class skills list below, choose three trained skills at 1st level. Class Skills: Athletics (Str), Endurance (Con), Heal (Wis), Intimidate (Cha), Streetwise (Cha)',
E'Combat Challenge: In combat, it’s dangerous to ignore a fighter. Every time you attack an enemy, whether the attack hits or misses, you can choose to mark that target. The mark lasts until the end of your next turn. While a target is marked, it takes a –2 penalty to attack rolls for any attack that doesn’t include you as a target. A creature can be subject to only one mark at a time. A new mark supersedes a mark that was already in place. In addition, whenever a marked enemy that is adjacent to you shifts or makes an attack that does not include you, you can make a melee basic attack against that enemy as an immediate interrupt. <br/><br/> Combat Superiority: You gain a bonus to opportunity attacks equal to your Wisdom modifier. An enemy struck by your opportunity attack stops moving, if a move provoked the attack. If it still has actions remaining, it can use them to resume moving. <br/><br/> Fighter Weapon Talent: Choose either one-handed or two-handed weapons. When using a weapon of your chosen style, you gain a +1 bonus to attack rolls. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Paladin', 'Defender', 'Divine', 'Strength, Charisma, Wisom', 'Cloth, leather, hide, chainmail, scale, plate; light shield, heavy shield', 'Simple melee, military melee, simple ranged', 'Holy Symbol', '+1 Fortitude, +1 Reflex, +1 Will', 15, 6, 10, 'Trained Skills: Religion. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Diplomacy (Cha), Endurance (Con), Heal (Wis), History (Int), Insight (Wis), Intimidate (Cha), Religion (Int)',
E'Channel Divinity: Once per encounter you can invoke divine power, filling yourself with the might of your patron deity. With the divine might you invoke you can wield special powers, such as divine mettle and divine strength. Some paladins learn other uses for this feature; for instance, the divinity feats in Chapter 6 grant characters with access to the Channel Divinity class feature the ability to use additional special powers. Regardless of how many different uses for Channel Divinity you know, you can use only one such ability per encounter. The special ability or power you invoke works just like your other powers. <br/><br/> Divine Challenge: The challenge of a paladin is filled with divine menace. You can use the divine challenge power to mark an enemy of your choice. <br/><br/> Lay on Hands: Using the lay on hands power, paladins can grant their comrades additional resilience with a touch of their hands and a short prayer, though they must give of their own strength to do so. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Ranger', 'Martial', 'Striker', 'Strength, Dexterity, Wisdom', 'Cloth, leather, hide', 'Simple melee, military melee, simple ranged, military ranged', '+1 Fortitude, +1 Reflex', 12, 5, 6, 'Trained Skills: Dungeoneering or Nature (your choice). From the class skills list below, choose four more trained skills at 1st level. Class Skills: Acrobatics (Dex), Athletics (Str), Dungeoneering (Wis), Endurance (Con), Heal (Wis), Nature (Wis), Perception (Wis), Stealth (Dex)',
E'Fighting Style: Choose one of the following fighting styles and gain its benefit. Archer Fighting Style: Because of your focus on ranged attacks, you gain Defensive Mobility as a bonus feat. Two-Blade Fighting Style: Because of your focus on two-weapon melee attacks, you can wield a one-handed weapon in your off hand as if it were an off-hand weapon. (Make sure to designate on your character sheet which weapon is main and which is offhand.) In addition, you gain Toughness as a bonus feat. <br/><br/> Hunter’s Quarry: Once per turn as a minor action, you can designate the enemy nearest to you as your quarry. Once per round, you deal extra damage to your quarry. The extra damage is based on your level. If you can make multiple attacks in a round, you decide which attack to apply the extra damage to after all the attacks are rolled. The hunter’s quarry effect remains active until the end of the encounter, until the quarry is defeated, or until you designate a different target as your quarry. You can designate one enemy as your quarry at a time. <br/><br/> Prime Shot: If none of your allies are nearer to your target than you are, you receive a +1 bonus to ranged attack rolls against that target. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Rogue', 'Martial', 'Striker', 'Dexterity, Strenght, Charisma', 'Cloth, leather', 'Dagger, hand crossbow, shuriken, sling, short sword', '+2 Reflex', 12, 5, 6, 'Trained Skills: Stealth and Thievery. From the class skills list below, choose four more trained skills at 1st level. Class Skills: Acrobatics (Dex), Athletics (Str), Bluff (Cha), Dungeoneering (Wis), Insight (Wis), Intimidate (Cha), Perception (Wis), Stealth (Dex), Streetwise (Cha), Thievery (Dex)',
E'First Strike: At the start of an encounter, you have combat advantage against any creatures that have not yet acted in that encounter. <br/><br/> Rogue Tactics: Rogues operate in a variety of ways. Some rogues use their natural charm and cunning trickery to deceive foes. Others rely on brute strength to overcome their enemies. Choose one of the following options. Artful Dodger: You gain a bonus to AC equal to your Charisma modifier against opportunity attacks. Brutal Scoundrel: You gain a bonus to Sneak Attack damage equal to your Strength modifier. The choice you make also provides bonuses to certain rogue powers. Individual powers detail the effects (if any) your Rogue Tactics selection has on them. <br/><br/> Rogue Weapon Talent: When you wield a shuriken, your weapon damage die increases by one size. When you wield a dagger, you gain a +1 bonus to attack rolls. <br/><br/> Sneak Attack: Once per round, when you have combat advantage against an enemy and are using a weapon from the light blade, the crossbow, or the sling weapon group, an attack you make against that enemy deals extra damage if the attack hits. You decide whether to apply the extra damage after making the damage roll. As you advance in level, your extra damage increases.');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Warlock', 'Arcane', 'Striker', 'Charisma, Constitution, Intelligence', 'Cloth, leather', 'Simple melee, simple ranged', 'Rods, wands', '+1 Reflex, +1 Will', 12, 5, 6, 'Trained Skills: From the class skills list below, choose four trained skills at 1st level. Class Skills: Arcana (Int), Bluff (Cha), History (Int), Insight (Wis), Intimidate (Cha), Religion (Int), Streetwise (Cha), Thievery (Dex)',
E'Eldritch Blast: All warlocks know the eldritch blast at-will power. This power can be used as a basic attack. You gain this power as well as another at-will power as determined by your Eldritch Pact. <br/><br/> Eldritch Pact: You have forged a pact with mysterious entities that grant you your arcane powers. Choose one of the following pacts: fey pact, infernal pact, or star pact. The pact you choose determines the following warlock abilities: At-Will Spells: Your pact determines one of the atwill spells you know. Pact Boon: Each pact includes a pact boon. The pact boon is a granted power you can use to further hex your enemies. The pact you take also provides bonuses to certain warlock powers. Individual powers detail the effects (if any) your Eldritch Pact selection has on them. <br/><br/> Fey Pact: You have forged a bargain with ancient, amoral powers of the Feywild. Some are primitive earth spirits, grim and menacing; some are capricious wood, sky, or water spirits; and others are incarnations of seasons or natural forces who roam the faerie realm like wild gods. They bestow magic that ranges from feral and savage to wondrous and enchanting. Eyebite: You know the eyebite at-will spell. Misty Step: You have the Misty Step pact boon. You instantly transform into silver mist that streams a short distance and reforms, allowing you to flee or maneuver to set up a deadly attack. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you can immediately teleport 3 squares as a free action. <br/><br/> Infernal Pact: Long ago a forgotten race of devils created a secret path to power and taught it to the tieflings of old to weaken their fealty to Asmodeus. In his wrath, Asmodeus destroyed the scheming devils and struck their very names from the memory of all beings—but you dare to study their perilous secrets anyway. Hellish Rebuke: You know the hellish rebuke at-will spell. Dark One’s Blessing: You have the Dark One’s Blessing pact boon. You instantly gain vitality from a cursed enemy when that enemy falls. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you immediately gain temporary hit points equal to your level. <br/><br/> Star Pact: You have mastered the astrologer’s art, learning the secret names of the stars and gazing into the Far Realm beyond, gaining great power thereby. You can call upon powers that madden or terrify your enemies, manipulate chance and fate, or scour your foes with icy banes and curses drawn from beyond the night sky. Dire Radiance: You know the dire radiance at-will spell. Fate of the Void: You have the Fate of the Void pact boon. Your curse intermingles with the lost vitality of a cursed enemy to reveal a glimpse of the future to you. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you gain a +1 bonus to any single d20 roll you make during your next turn (attack roll, saving throw, skill check, or ability check). If you don’t use this bonus by the end of your turn, it is lost. This bonus is cumulative; if three cursed enemies drop to 0 hit points or fewer before your next turn, you gain a +3 bonus to a d20 roll during your turn. <br/><br/> Prime Shot: If none of your allies are nearer to your target than you are, you receive a +1 bonus to ranged attack rolls against that target. <br/><br/> Shadow Walk: On your turn, if you move at least 3 squares away from where you started your turn, you gain concealment until the end of your next turn. <br/><br/> Warlock’s Curse: Once per turn as a minor action, you can place a Warlock’s Curse on the enemy nearest to you that you can see. A cursed enemy is more vulnerable to your attacks. If you damage a cursed enemy, you deal extra damage. You decide whether to apply the extra damage after making the damage roll. You can deal this extra damage once per round. A Warlock’s Curse remains in effect until the end of the encounter or until the cursed enemy drops to 0 hit points or fewer. You can place a Warlock’s Curse on multiple targets over the course of an encounter; each curse requires the use of a minor action. You can’t place a Warlock’s Curse on a creature that is already affected by your or another character’s Warlock’s Curse.');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Warlord', 'Martial', 'Leader', 'Strength, Intelligence, Charisma', 'Cloth, leather, hide, chainmail; light shield', 'Simple melee, military melee, simple ranged', '+1 Fortitude, +1 Will', 12, 5, 7, 'Trained Skills: From the class skills list below, choose four trained skills at 1st level. Class Skills: Athletics (Str), Diplomacy (Cha), Endurance (Con), Heal (Wis), History (Int), Intimidate (Cha)', 
E'Combat Leader: You and each ally within 10 squares who can see and hear you gain a +2 power bonus to initiative. <br/><br/> Commanding Presence: Choose one of the following two benefits. Inspiring Presence: When an ally who can see you spends an action point to take an extra action, that ally also regains lost hit points equal to one-half your level + your Charisma modifier. Tactical Presence: When an ally you can see spends an action point to make an extra attack, the ally gains a bonus to the attack roll equal to one-half your Intelligence modifier. The choice you make also provides bonuses to certain warlord powers. Individual powers detail the effects (if any) your Commanding Presence selection has on them. <br/><br/> Inspiring Word: Using the inspiring word power, warlords can grant their comrades additional resilience with nothing more than a shout of encouragement.');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Wizard', 'Arcane', 'Controller', 'Intelligence, Wisdom, Dexterity', 'Cloth', 'Dagger, quarterstaff', 'Orbs, staffs, wands', '+2 Will', 10, 4, 6, 'Trained Skills: Arcana. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Arcana (Int), Diplomacy (Cha), Dungeoneering (Wis), History (Int), Insight (Wis), Nature (Int), Religion (Int)',
E'Arcane Implement Mastery: You specialize in the use of one kind of implement to gain additional abilities when you wield it. Choose one of the following forms of implement mastery. Orb of Imposition: Once per encounter as a free action, you can use your orb to gain one of the following two effects. You can designate one creature you have cast a wizard spell upon that has an effect that lasts until the subject succeeds on a saving throw. That creature takes a penalty to its saving throws against that effect equal to your Wisdom modifier. Alternatively, you can choose to extend the duration of an effect created by a wizard at-will spell (such as cloud of daggers or ray of frost) that would otherwise end at the end of your current turn. The effect instead ends at the end of your next turn. You must wield an orb to use this ability. Control wizards select this form of mastery because it helps extend the duration of their control effects. Staff of Defense: A staff of defense grants you a +1 bonus to AC. In addition, once per encounter as an immediate interrupt, you gain a bonus to defense against one attack equal to your Constitution modifier. You can declare the bonus after the Dungeon Master has already told you the damage total. You must wield your staff to benefit from these features. This form of mastery is useful for all wizards, particularly if you dabble in both control and damage-dealing spells. Wand of Accuracy: Once per encounter as a free action, you gain a bonus to a single attack roll equal to your Dexterity modifier. You must wield your wand to benefit from this feature. This form of mastery is good for war wizards because it helps increase their accuracy with damaging powers. <br/><br/> Cantrips: Cantrips are minor spells you gain at 1st level. You can use the ghost sound, light, mage hand, and prestidigitation cantrips as at-will powers. <br/><br/> Ritual Casting: You gain the Ritual Caster feat (page 200) as a bonus feat, allowing you to use magical rituals (see Chapter 10). <br/><br/> Spellbook: You possess a spellbook, a book full of mystic lore in which you store your rituals and your daily and utility spells. Rituals: Your book contains three 1st-level rituals of your choice that you have mastered. At 5th level, and again at 11th, 15th, 21st, and 25th level, you master two more rituals of your choice and add them to your spellbook. Any ritual you add must be your level or lower. Daily and Utility Spells: Your spellbook also holds your daily and utility spells. You begin knowing two daily spells, one of which you can use on any given day. Each time you gain a level that lets you select a daily spell or a utility spell, choose two different daily spells or utility spells of that level to add to your book. After an extended rest, you can prepare a number of daily and utility spells according to what you can cast per day for your level. You can’t prepare the same spell twice. If you replace a spell because of gaining a level or through retraining, the previous spell vanishes from your spellbook and is replaced by the new spell. Capacity: A typical spellbook has 128 pages. Each spell takes up 1 page. A ritual takes up a number of pages equal to its level.');
--END PLAYER HANDBOOK 1 CLASSES

--
-- Table Structure for Feats
--

DROP TABLE IF EXISTS feats;
CREATE TABLE feats (
    ID serial NOT NULL,
    tier varchar(20) NOT NULL default 'Heroic',
    name varchar(50) NOT NULL default '',
    prereq text,
    benefit text NOT NULL default '',
    special text,
    PRIMARY KEY (ID)
);

--
-- Table Dump for Feats
--

--PLAYER HANDBOOK 1 FEATS
INSERT INTO feats (name, prereq, benefit) VALUES('Action Surge', 'Human', 'You gain a +3 bonus to attack rolls you make during any action you gained by spending an action point.');
INSERT INTO feats (name, prereq, benefit) VALUES('Agile Hunter', 'Dex 15, ranger, Hunter’s Quarry class feature', 'When you score a critical hit with a melee attack against the target of your Hunter’s Quarry, you can shift as a free action, and the enemy takes a –2 penalty on attack rolls against you until the end of your next turn.');
INSERT INTO feats (name, benefit) VALUES('Alertness', 'You don’t grant enemies combat advantage during surprise rounds. You also gain a +2 feat bonus to Perception checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Armor of Bahamut', 'Channel Divinity class feature, must worship Bahamut', 'You can invoke the power of your deity to use armor of Bahamut. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Armor Proficiency (Chainmail)', 'Str 13, Con 13, training with leather or hide armor', 'You gain training with chainmail.');
INSERT INTO feats (name, prereq, benefit) VALUES('Armor Proficiency (Chainmail)', 'Str 13, Con 13, training with leather armor', 'You gain training with hide.');
INSERT INTO feats (name, benefit) VALUES('Armor Proficiency (Chainmail)', 'You gain training with leather.');
INSERT INTO feats (name, prereq, benefit) VALUES('Armor Proficiency (Chainmail)', 'Str 13, Con 13, training with scale armor', 'You gain training with plate.');
INSERT INTO feats (name, prereq, benefit) VALUES('Armor Proficiency (Chainmail)', 'Str 15, Con 15, training with chainmail armor', 'You gain training with scale.');
INSERT INTO feats (name, prereq, benefit) VALUES('Astral Fire', 'Dex 13, Cha 13', 'You gain a +1 feat bonus to damage rolls when you use a power that has the fire or radiant keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.');
INSERT INTO feats (name, prereq, benefit) VALUES('Avandra''s Rescue', 'Channel Divinity class feature, must worship Avandra', 'You can invoke the power of your deity to use Avandra''s Rescue. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Backstabber', 'Rogue, Sneak Attack class feature', 'The extra damage dice from your Sneak Attack class feature increase from d6s to d8s.');
INSERT INTO feats (name, prereq, benefit) VALUES('Blade Opportunist', 'Str 13, Dex13', 'You gain a +2 bonus to opportunity attack rolls with a heavy blade or a light blade.');
INSERT INTO feats (name, prereq, benefit) VALUES('Burning Blizzard', 'Int 13, Wis 13', 'You gain a +1 feat bonus to damage rolls when you use a power that has the acid or cold keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.');
INSERT INTO feats (name, prereq, benefit) VALUES('Combat Reflexes', 'Dex 13', 'You gain a +1 bonus to opportunity attack rolls.');
INSERT INTO feats (name, prereq, benefit) VALUES('Corellon''s Grace', 'Channel Divinity class feature, must worship Corellon', 'You can invoke the power of your deity to use Corellon''s grace. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Dark Fury', 'Con 13, Wis 13', 'You gain a +1 feat bonus to damage rolls when you use a power that has the necrotic or psychic keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.');
INSERT INTO feats (name, benefit) VALUES('Defensive Mobility', 'You gain a +2 bonus to AC against opportunity attacks.');
INSERT INTO feats (name, prereq, benefit, special) VALUES('Distracting Shield', 'Wis 15, fighter, Combat Challenge class feature', 'If you hit a foe with an attack granted by your Combat Challenge class feature, the target takes a –2 penalty to attack rolls until the start of your next turn.', 'You must have a shield equipped to benefit from this feat.');
INSERT INTO feats (name, prereq, benefit) VALUES('Dodge Giants', 'Dwarf', 'You gain a +1 bonus to AC and Reflex defense against the attacks of Large or larger foes.');
INSERT INTO feats (name, prereq, benefit) VALUES('Dragonborn Frenzy', 'Dragonborn', 'While you are bloodied, you gain a +2 bonus to damage rolls.');
INSERT INTO feats (name, prereq, benefit) VALUES('Dragonborn Senses', 'Dragonborn', 'You gain low-light vision. You gain a +1 feat bonus to Perception checks.');
INSERT INTO feats (name, benefit) VALUES('Durable', 'Increase your number of healing surges by two');
INSERT INTO feats (name, prereq, benefit) VALUES('Dwarven Weapon Training', 'Dwarf', 'You gain proficiency and a +2 feat bonus to damage rolls with axes and hammers.');
INSERT INTO feats (name, prereq, benefit) VALUES('Eladrin Soldier', 'Eladrin', 'You gain proficiency with all spears and a +2 feat bonus to damage rolls with longswords and all spears.');
INSERT INTO feats (name, prereq, benefit) VALUES('Elven Precision', 'Elf, elven accuracy racial power', 'When you use the elven accuracy power, you gain a +2 bonus to the new attack roll.');
INSERT INTO feats (name, prereq, benefit) VALUES('Enlarged Dragon Breath', 'Dragonborn, dragon breath racial power', 'When you use your dragon breath power, you can choose to make it blast 5 instead of blast 3.');
INSERT INTO feats (name, prereq, benefit) VALUES('Escape Artist', 'Trained in Acrobatics', 'You can attempt to escape a grab as a minor action, instead of as a move action. You gain a +2 feat bonus to Acrobatics checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Expanded Spellbook', 'Wis 13, wizard', 'Choose one daily wizard attack spell of every level you know. Add this spell to your spellbook. Each time you gain a new level of daily wizard attack spells, you learn one extra spell of that level (in other words, add three spells to your spellbook instead of only two). This feat doesn’t change the number of daily attack spells you can prepare each day.');
INSERT INTO feats (name, prereq, benefit) VALUES('Far Shot', 'Dex 13', 'When you use a projectile weapon such as a bow or a crossbow, increase both the normal range and the long range by 5 squares.');
INSERT INTO feats (name, prereq, benefit) VALUES('Far Throw', 'Str 13', 'When you use a thrown weapon such as a dagger or a javelin, increase both the normal range and the long range by 2 squares.');
INSERT INTO feats (name, prereq, benefit) VALUES('Fast Runner', 'Con 13', 'You gain a +2 bonus to speed when you charge or run.');
INSERT INTO feats (name, prereq, benefit) VALUES('Ferocious Rebuke', 'Tiefling, infernal wrath racial power', 'When you use the infernal wrath power and hit with an attack, you can push the target 1 square in addition to any damage you deal.');
INSERT INTO feats (name, prereq, benefit) VALUES('Group Insight', 'Half-elf', 'You grant allies within 10 squares of you a +1 racial bonus to Insight checks and initiative checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Halfling Agility', 'Halfling, second chance racial power', 'When you use your halfling second chance ability, the attacker takes a –2 penalty to the new attack roll.');
INSERT INTO feats (name, prereq, benefit) VALUES('Harmony of Erathis', 'Channel Divinity class feature, must worship Erathis', 'You can invoke the power of your deity to use harmony of Erathis. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Healing Hands', 'Paladin, lay on hands power', 'When you use the lay on hands power, the affected ally regains additional hit points equal to your Charisma modifier.');
INSERT INTO feats (name, prereq, benefit) VALUES('Hellfire Blood', 'Tiefling', 'You gain a +1 feat bonus to attack rolls and damage rolls when you use a power that has the fire or fear keyword.');
INSERT INTO feats (name, prereq, benefit) VALUES('Human Perseverance', 'Human', 'You gain a +1 feat bonus to saving throws.');
INSERT INTO feats (name, prereq, benefit) VALUES('Improved Dark One''s Blessing', 'Con 15, warlock, infernal pact', 'Your Dark One’s Blessing now gives you 3 additional temporary hit points.');
INSERT INTO feats (name, prereq, benefit) VALUES('Improved Fate of the Void', 'Con 13 or Cha 13, warlock, star pact', 'Your Fate of the Void grants an additional +1 bonus to the d20 roll.');
INSERT INTO feats (name, benefit) VALUES('Improved Initiative', 'You gain a +4 feat bonus to initiative checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Improved Misty Step', 'Int 13, warlock, fey pact', 'Misty Step now allows you to teleport an additional 2 squares.');
INSERT INTO feats (name, prereq, benefit) VALUES('Inspired Recovery', 'Warlord, Inspiring Presence class feature', 'When an ally who can see you spends an action point to gain an extra standard action, that ally can roll a saving throw as a free action, adding your Charisma modifier to the roll.');
INSERT INTO feats (name, prereq, benefit) VALUES('Ioun''s Poise', 'Channel Divinity class feature, must worship Ioun', 'ou can invoke the power of your deity to use Ioun''s poise. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Jack of All Trades', 'Int 13', 'You gain a +3 feat bonus to all untrained skill checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Kord''s Favor', 'Channel Divinity class feature, must worship Kord', 'You can invoke the power of your deity to use Kord''s favor. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Lethal Hunter', 'Ranger, Hunter’s Quarry class feature', 'The extra damage dice from your Hunter’s Quarry class feature increase from d6s to d8s.');
INSERT INTO feats (name, prereq, benefit) VALUES('Light Step', 'Elf', 'For the purpose of hourly or daily travel rates, add 1 to your overland speed and the speed of all allies in your traveling group. Add 5 to the DC required to find or follow your tracks. If traveling with allies, you can share this benefit with up to five other characters. You gain a +1 feat bonus to Acrobatics checks and Stealth checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Linguist', 'Int 13', 'Choose three languages. You can now speak, read, and write those languages fluently. Special: You can take this feat more than once. Each time you select this feat, choose three new languages to learn.');
INSERT INTO feats (name, prereq, benefit) VALUES('Long Jumper', 'Trained in Athletics', 'You can make all long jumps as if you had a running start. You also gain a +1 feat bonus to Athletics checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Lost in the Crowd', 'Halfling', 'You gain a +2 bonus to AC when you are adjacent to at least two enemies larger than you.');
INSERT INTO feats (name, prereq, benefit) VALUES('Melora''s Tide', 'Channel Divinity class feature, must worship Melora', 'You can invoke the power of your deity to use Melora''s tide. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Moradin''s Resolve', 'Channel Divinity class feature, must worship Moradin', 'You can invoke the power of your deity to use Moradin’s resolve. [Power]');
INSERT INTO feats (name, benefit) VALUES('Mounted Combat', 'Benefit: When you ride a creature, you gain access to any special mount abilities it confers to its rider. Not every creature has these abilities. The Dungeon Master’s Guide has more information on mounts and mounted combat. While you are riding a creature, the creature can make any Athletics, Acrobatics, Endurance, or Stealth checks using your base skill check bonus rather than its own if yours is higher.');
INSERT INTO feats (name, prereq, benefit) VALUES('Nimble Blade', 'Dex 15', 'When you attack with a light blade and you have combat advantage, you gain a +1 bonus to attack rolls.');
INSERT INTO feats (name, prereq, benefit) VALUES('Pelor''s Radiance', 'Channel Divinity class feature, must worship Pelor', 'You can invoke the power of your deity to use Pelor''s radiance. [Power]');
INSERT INTO feats (name, prereq, benefit, special) VALUES('Potent Challenge', 'Con 15, fighter, Combat Challenge class feature', 'If you hit a foe with an attack granted by your Combat Challenge class feature, add your Constitution modifier to the damage roll.', 'This benefit applies only to attacks made with two-handed weapons.');
INSERT INTO feats (name, prereq, benefit) VALUES('Power Attack', 'Str 15', 'When making a melee attack, you can take a –2 penalty to the attack roll. If the attack hits, you gain a +2 bonus to the damage roll (or a +3 bonus to the damage roll with a two-handed weapon) per tier. The attack penalty remains the same.');
INSERT INTO feats (name, prereq, benefit) VALUES('Powerful Charge', 'Str 13', 'When you charge, you gain a +2 bonus to damage and a +2 bonus to bull rush attempts.');
INSERT INTO feats (name, prereq, benefit) VALUES('Precise Hunter', 'Wis 15, ranger, Hunter’s Quarry class feature', 'When you score a critical hit against the target of your Hunter’s Quarry with a ranged attack, your allies gain a +1 bonus to attack rolls against that target until the start of your next turn.');
INSERT INTO feats (name, prereq, benefit) VALUES('Press the Advantage', 'Cha 15, Rogue', 'If you score a critical hit while you have combat advantage, you gain combat advantage against the target until the end of your next turn.');
INSERT INTO feats (name, prereq, benefit) VALUES('Quick Draw', 'Dex 13', 'You can draw a weapon (or an object stored in a belt pouch, bandolier, or similar container, such as a potion) as part of the same action used to attack with the weapon or use the object. You also gain a +2 feat bonus to initiative checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Raging Storm', 'Con 13, Dex 13', 'You gain a +1 feat bonus to damage rolls when you use a power that has the lightning or thunder keyword. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.');
INSERT INTO feats (name, prereq, benefit) VALUES('Raven Queen''s Blessing', 'Channel Divinity class feature, must worship the Raven Queen', 'You can invoke the power of your deity to use Raven Queen''s blessing. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Ritual Caster', 'Trained in Arcana or Religion', 'You can master and perform rituals of your level or lower. See Chapter 10 for information on acquiring, mastering, and performing rituals. Even though some rituals use the Heal skill or the Nature skill, the Arcana skill or the Religion skill is required to understand how to perform rituals.');
INSERT INTO feats (name, prereq, benefit) VALUES('Sehanine''s Reversal', 'Channel Divinity class feature, must worship Sehanine', 'You can invoke the power of your deity to use Sehanine''s reversal. [Power]');
INSERT INTO feats (name, prereq, benefit) VALUES('Shield Proficiency (Heavy)', 'Str 15, Shield Proficiency (Light)', 'You gain proficiency with heavy shields.');
INSERT INTO feats (name, prereq, benefit) VALUES('Shield Proficiency (Light)', 'Str 13', 'You gain proficiency with light shields.');
INSERT INTO feats (name, prereq, benefit, special) VALUES('Shield Push', 'Fighter, Combat Challenge class feature', 'If you hit a foe with an attack granted by your Combat Challenge class feature, you push the target 1 square after dealing damage.', 'You must carry a shield to benefit from this feat.');
INSERT INTO feats (name, prereq, benefit, special) VALUES('Skill Focus', 'Training in chose skill', 'Choose a skill in which you have training. You have a +3 feat bonus to checks with that skill.', 'You can take this feat more than once. Each time you select this feat, choose a different skill.');
INSERT INTO feats (name, prereq, benefit) VALUES('Skill Training', 'You gain training in one skill. The skill need not be on your class skill list.', 'You can take this feat more than once. Each time you select this feat, choose a skill in which you are not trained.');
INSERT INTO feats (name, prereq, benefit) VALUES('Sure Climber', 'Trained in Athletics', 'A successful Athletics check allows you to climb at your normal speed, rather than half speed. You also gain a +1 feat bonus to Athletics checks.');
INSERT INTO feats (name, prereq, benefit) VALUES('Surprise Knockdown', 'Str 15, rogue', 'If you score a critical hit while you have combat advantage, you knock the target prone.');
INSERT INTO feats (name, prereq, benefit) VALUES('Tactical Assault', 'Warlord, Tactical Presence class feature', 'When an ally who can see you spends an action point to make an attack, the attack’s damage roll gains a bonus equal to your Intelligence modifier.');
INSERT INTO feats (name, benefit) VALUES('Toughness', 'When you take this feat, you gain additional hit points. You gain an additional 5 hit points at each tier of play (at 1st, 11th, and 21st level).');
INSERT INTO feats (name, prereq, benefit) VALUES('Two-Weapon Defense', 'Dex 13, Two-Weapon Fighting', 'While holding a melee weapon in each hand, you gain a +1 shield bonus to AC and Reflex.');
INSERT INTO feats (name, prereq, benefit) VALUES('Two-Weapon Fighting', 'Dex 13', 'While holding a melee weapon in each hand, you gain a +1 bonus to damage rolls with your main weapon.');
INSERT INTO feats (name, benefit, special) VALUES('Weapon Focus', 'Choose a specific weapon group, such as spears or heavy blades. You gain a +1 feat bonus o damage rolls with your chosen weapon group. At 11th level, this bonus increases to +2. At 21st level, it increases to +3.', 'You can take this feat more than once. Each time you select this feat, choose another weapon group.');
INSERT INTO feats (name, benefit, special) VALUES('Weapon Proficiency', 'You gain proficiency in a single weapon of your choice', 'You can take this feat more than once. Each time you select this feat, choose another weapon.');
INSERT INTO feats (name, benefit) VALUES('Wintertouched', 'When attacking a creature that is vulnerable to cold, you gain combat advantage when you use a power that has the cold keyword.');
--END PLAYER HANDBOOK 1 FEATS

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
    target text, attack text, trigger text,
    hit text, effect text, miss text,
    special text, sustain text,
    PRIMARY KEY (ID)
);

--
-- Table Dump for Powers
--


--PLAYER HANDBOOK ONE POWERS
-- Bare minimum entry is still quite large, below line is a template for beginning power entries
-- INSERT INTO powers (name, origin, level, flavor, encountertype, keywords, actiontype, range) VALUES ();
INSERT INTO powers (name, origin, flavor, keywords, actiontype, range, trigger, effect, special) 
VALUES ('Channel Divinity: Armor of Bahamut', 'Feat', 'Bahamut protects you or a friend from devastating harm.', 'Divine', 'Immediate Interrupt', 'Ranged 5', 'An enemy scores a critical hit on you or an ally', 'Turn a critical hit against you or an ally within range into a normal hit', 'You must take the Armor of Bahamut feat to use this power');
INSERT INTO powers (name, origin, flavor, keywords, actiontype, range, effect, special) 
VALUES ('Channel Divinity: Avandra''s Rescue','Feat', 'Avandra smiles upon you and helps you rescue a friend in need.', 'Divine', 'Move Action', 'Melee 1', 'One Ally', 'Shift into the space of an adjecent ally; that ally simultaneously shifts into your space. Your space and your ally''s spaces must be the same size.', 'You must take the Avandra''s Rescue feat to use this power');
INSERT INTO powers (name, origin, flavor, keywords, actiontype, range, trigger, effect, special) 
VALUES ('Channel Divinity: Corellon''s Grace', )




--END PLAER HANDBOOK ONE POWERS

DROP ROLE IF EXISTS dnduser;
CREATE USER dnduser;
--Enter "dnd" without quotes when prompted 
\password dnduser
GRANT SELECT, INSERT ON class, feats, powers, race to dnduser;
GRANT ALL ON class_id_seq, feats_id_seq, powers_id_seq, race_id_seq to dnduser;