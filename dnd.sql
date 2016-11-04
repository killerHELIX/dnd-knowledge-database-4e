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
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Fighter', 'Defender', 'Martial', 'Strength, Wisdom, Dexterity, Constitution', 'Cloth, leather, hide, chainmail, scale; light shield, heavy shield', 'Simple melee, military melee, simple ranged, military ranged', '+2 Fortitude', 15, 6, 9, 'Trained Skills: From the class skills list below, choose three trained skills at 1st level. Class Skills: Athletics (Str), Endurance (Con), Heal (Wis), Intimidate (Cha), Streetwise (Cha)',
E'Combat Challenge: In combat, it’s dangerous to ignore a fighter. Every time you attack an enemy, whether the attack hits or misses, you can choose to mark that target. The mark lasts until the end of your next turn. While a target is marked, it takes a –2 penalty to attack rolls for any attack that doesn’t include you as a target. A creature can be subject to only one mark at a time. A new mark supersedes a mark that was already in place. In addition, whenever a marked enemy that is adjacent to you shifts or makes an attack that does not include you, you can make a melee basic attack against that enemy as an immediate interrupt. \n Combat Superiority: You gain a bonus to opportunity attacks equal to your Wisdom modifier. An enemy struck by your opportunity attack stops moving, if a move provoked the attack. If it still has actions remaining, it can use them to resume moving. \n Fighter Weapon Talent: Choose either one-handed or two-handed weapons. When using a weapon of your chosen style, you gain a +1 bonus to attack rolls. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Paladin', 'Defender', 'Divine', 'Strength, Charisma, Wisom', 'Cloth, leather, hide, chainmail, scale, plate; light shield, heavy shield', 'Simple melee, military melee, simple ranged', 'Holy Symbol', '+1 Fortitude, +1 Reflex, +1 Will', 15, 6, 10, 'Trained Skills: Religion. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Diplomacy (Cha), Endurance (Con), Heal (Wis), History (Int), Insight (Wis), Intimidate (Cha), Religion (Int)',
E'Channel Divinity: Once per encounter you can invoke divine power, filling yourself with the might of your patron deity. With the divine might you invoke you can wield special powers, such as divine mettle and divine strength. Some paladins learn other uses for this feature; for instance, the divinity feats in Chapter 6 grant characters with access to the Channel Divinity class feature the ability to use additional special powers. Regardless of how many different uses for Channel Divinity you know, you can use only one such ability per encounter. The special ability or power you invoke works just like your other powers. \n Divine Challenge: The challenge of a paladin is filled with divine menace. You can use the divine challenge power to mark an enemy of your choice. \n Lay on Hands: Using the lay on hands power, paladins can grant their comrades additional resilience with a touch of their hands and a short prayer, though they must give of their own strength to do so. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Ranger', 'Martial', 'Striker', 'Strength, Dexterity, Wisdom', 'Cloth, leather, hide', 'Simple melee, military melee, simple ranged, military ranged', '+1 Fortitude, +1 Reflex', 12, 5, 6, 'Trained Skills: Dungeoneering or Nature (your choice). From the class skills list below, choose four more trained skills at 1st level. Class Skills: Acrobatics (Dex), Athletics (Str), Dungeoneering (Wis), Endurance (Con), Heal (Wis), Nature (Wis), Perception (Wis), Stealth (Dex)',
E'Fighting Style: Choose one of the following fighting styles and gain its benefit. Archer Fighting Style: Because of your focus on ranged attacks, you gain Defensive Mobility as a bonus feat. Two-Blade Fighting Style: Because of your focus on two-weapon melee attacks, you can wield a one-handed weapon in your off hand as if it were an off-hand weapon. (Make sure to designate on your character sheet which weapon is main and which is offhand.) In addition, you gain Toughness as a bonus feat. \n Hunter’s Quarry: Once per turn as a minor action, you can designate the enemy nearest to you as your quarry. Once per round, you deal extra damage to your quarry. The extra damage is based on your level. If you can make multiple attacks in a round, you decide which attack to apply the extra damage to after all the attacks are rolled. The hunter’s quarry effect remains active until the end of the encounter, until the quarry is defeated, or until you designate a different target as your quarry. You can designate one enemy as your quarry at a time. \n Prime Shot: If none of your allies are nearer to your target than you are, you receive a +1 bonus to ranged attack rolls against that target. ');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Rogue', 'Martial', 'Striker', 'Dexterity, Strenght, Charisma', 'Cloth, leather', 'Dagger, hand crossbow, shuriken, sling, short sword', '+2 Reflex', 12, 5, 6, 'Trained Skills: Stealth and Thievery. From the class skills list below, choose four more trained skills at 1st level. Class Skills: Acrobatics (Dex), Athletics (Str), Bluff (Cha), Dungeoneering (Wis), Insight (Wis), Intimidate (Cha), Perception (Wis), Stealth (Dex), Streetwise (Cha), Thievery (Dex)',
E'First Strike: At the start of an encounter, you have combat advantage against any creatures that have not yet acted in that encounter. \n Rogue Tactics: Rogues operate in a variety of ways. Some rogues use their natural charm and cunning trickery to deceive foes. Others rely on brute strength to overcome their enemies. Choose one of the following options. Artful Dodger: You gain a bonus to AC equal to your Charisma modifier against opportunity attacks. Brutal Scoundrel: You gain a bonus to Sneak Attack damage equal to your Strength modifier. The choice you make also provides bonuses to certain rogue powers. Individual powers detail the effects (if any) your Rogue Tactics selection has on them. \n Rogue Weapon Talent: When you wield a shuriken, your weapon damage die increases by one size. When you wield a dagger, you gain a +1 bonus to attack rolls. \n Sneak Attack: Once per round, when you have combat advantage against an enemy and are using a weapon from the light blade, the crossbow, or the sling weapon group, an attack you make against that enemy deals extra damage if the attack hits. You decide whether to apply the extra damage after making the damage roll. As you advance in level, your extra damage increases.');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Warlock', 'Arcane', 'Striker', 'Charisma, Constitution, Intelligence', 'Cloth, leather', 'Simple melee, simple ranged', 'Rods, wands', '+1 Reflex, +1 Will', 12, 5, 6, 'Trained Skills: From the class skills list below, choose four trained skills at 1st level. Class Skills: Arcana (Int), Bluff (Cha), History (Int), Insight (Wis), Intimidate (Cha), Religion (Int), Streetwise (Cha), Thievery (Dex)',
E'Eldritch Blast: All warlocks know the eldritch blast at-will power. This power can be used as a basic attack. You gain this power as well as another at-will power as determined by your Eldritch Pact. \n Eldritch Pact: You have forged a pact with mysterious entities that grant you your arcane powers. Choose one of the following pacts: fey pact, infernal pact, or star pact. The pact you choose determines the following warlock abilities: At-Will Spells: Your pact determines one of the atwill spells you know. Pact Boon: Each pact includes a pact boon. The pact boon is a granted power you can use to further hex your enemies. The pact you take also provides bonuses to certain warlock powers. Individual powers detail the effects (if any) your Eldritch Pact selection has on them. \n Fey Pact: You have forged a bargain with ancient, amoral powers of the Feywild. Some are primitive earth spirits, grim and menacing; some are capricious wood, sky, or water spirits; and others are incarnations of seasons or natural forces who roam the faerie realm like wild gods. They bestow magic that ranges from feral and savage to wondrous and enchanting. Eyebite: You know the eyebite at-will spell. Misty Step: You have the Misty Step pact boon. You instantly transform into silver mist that streams a short distance and reforms, allowing you to flee or maneuver to set up a deadly attack. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you can immediately teleport 3 squares as a free action. \n Infernal Pact: Long ago a forgotten race of devils created a secret path to power and taught it to the tieflings of old to weaken their fealty to Asmodeus. In his wrath, Asmodeus destroyed the scheming devils and struck their very names from the memory of all beings—but you dare to study their perilous secrets anyway. Hellish Rebuke: You know the hellish rebuke at-will spell. Dark One’s Blessing: You have the Dark One’s Blessing pact boon. You instantly gain vitality from a cursed enemy when that enemy falls. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you immediately gain temporary hit points equal to your level. \n Star Pact: You have mastered the astrologer’s art, learning the secret names of the stars and gazing into the Far Realm beyond, gaining great power thereby. You can call upon powers that madden or terrify your enemies, manipulate chance and fate, or scour your foes with icy banes and curses drawn from beyond the night sky. Dire Radiance: You know the dire radiance at-will spell. Fate of the Void: You have the Fate of the Void pact boon. Your curse intermingles with the lost vitality of a cursed enemy to reveal a glimpse of the future to you. When an enemy under your Warlock’s Curse is reduced to 0 hit points or fewer, you gain a +1 bonus to any single d20 roll you make during your next turn (attack roll, saving throw, skill check, or ability check). If you don’t use this bonus by the end of your turn, it is lost. This bonus is cumulative; if three cursed enemies drop to 0 hit points or fewer before your next turn, you gain a +3 bonus to a d20 roll during your turn. \n Prime Shot: If none of your allies are nearer to your target than you are, you receive a +1 bonus to ranged attack rolls against that target. \n Shadow Walk: On your turn, if you move at least 3 squares away from where you started your turn, you gain concealment until the end of your next turn. \n Warlock’s Curse: Once per turn as a minor action, you can place a Warlock’s Curse on the enemy nearest to you that you can see. A cursed enemy is more vulnerable to your attacks. If you damage a cursed enemy, you deal extra damage. You decide whether to apply the extra damage after making the damage roll. You can deal this extra damage once per round. A Warlock’s Curse remains in effect until the end of the encounter or until the cursed enemy drops to 0 hit points or fewer. You can place a Warlock’s Curse on multiple targets over the course of an encounter; each curse requires the use of a minor action. You can’t place a Warlock’s Curse on a creature that is already affected by your or another character’s Warlock’s Curse.');
INSERT INTO class (name, role, source, keystat, armor, weapon, defense, starthp, levelhp, surge, skills, features)
VALUES ('Warlord', 'Martial', 'Leader', 'Strength, Intelligence, Charisma', 'Cloth, leather, hide, chainmail; light shield', 'Simple melee, military melee, simple ranged', '+1 Fortitude, +1 Will', 12, 5, 7, 'Trained Skills: From the class skills list below, choose four trained skills at 1st level. Class Skills: Athletics (Str), Diplomacy (Cha), Endurance (Con), Heal (Wis), History (Int), Intimidate (Cha)', 
E'Combat Leader: You and each ally within 10 squares who can see and hear you gain a +2 power bonus to initiative. \n Commanding Presence: Choose one of the following two benefits. Inspiring Presence: When an ally who can see you spends an action point to take an extra action, that ally also regains lost hit points equal to one-half your level + your Charisma modifier. Tactical Presence: When an ally you can see spends an action point to make an extra attack, the ally gains a bonus to the attack roll equal to one-half your Intelligence modifier. The choice you make also provides bonuses to certain warlord powers. Individual powers detail the effects (if any) your Commanding Presence selection has on them. \n Inspiring Word: Using the inspiring word power, warlords can grant their comrades additional resilience with nothing more than a shout of encouragement.');
INSERT INTO class (name, role, source, keystat, armor, weapon, implement, defense, starthp, levelhp, surge, skills, features)
VALUES ('Wizard', 'Arcane', 'Controller', 'Intelligence, Wisdom, Dexterity', 'Cloth', 'Dagger, quarterstaff', 'Orbs, staffs, wands', '+2 Will', 10, 4, 6, 'Trained Skills: Arcana. From the class skills list below, choose three more trained skills at 1st level. Class Skills: Arcana (Int), Diplomacy (Cha), Dungeoneering (Wis), History (Int), Insight (Wis), Nature (Int), Religion (Int)',
E'Arcane Implement Mastery: You specialize in the use of one kind of implement to gain additional abilities when you wield it. Choose one of the following forms of implement mastery. Orb of Imposition: Once per encounter as a free action, you can use your orb to gain one of the following two effects. You can designate one creature you have cast a wizard spell upon that has an effect that lasts until the subject succeeds on a saving throw. That creature takes a penalty to its saving throws against that effect equal to your Wisdom modifier. Alternatively, you can choose to extend the duration of an effect created by a wizard at-will spell (such as cloud of daggers or ray of frost) that would otherwise end at the end of your current turn. The effect instead ends at the end of your next turn. You must wield an orb to use this ability. Control wizards select this form of mastery because it helps extend the duration of their control effects. Staff of Defense: A staff of defense grants you a +1 bonus to AC. In addition, once per encounter as an immediate interrupt, you gain a bonus to defense against one attack equal to your Constitution modifier. You can declare the bonus after the Dungeon Master has already told you the damage total. You must wield your staff to benefit from these features. This form of mastery is useful for all wizards, particularly if you dabble in both control and damage-dealing spells. Wand of Accuracy: Once per encounter as a free action, you gain a bonus to a single attack roll equal to your Dexterity modifier. You must wield your wand to benefit from this feature. This form of mastery is good for war wizards because it helps increase their accuracy with damaging powers. \n Cantrips: Cantrips are minor spells you gain at 1st level. You can use the ghost sound, light, mage hand, and prestidigitation cantrips as at-will powers. \n Ritual Casting: You gain the Ritual Caster feat (page 200) as a bonus feat, allowing you to use magical rituals (see Chapter 10). \n Spellbook: You possess a spellbook, a book full of mystic lore in which you store your rituals and your daily and utility spells. Rituals: Your book contains three 1st-level rituals of your choice that you have mastered. At 5th level, and again at 11th, 15th, 21st, and 25th level, you master two more rituals of your choice and add them to your spellbook. Any ritual you add must be your level or lower. Daily and Utility Spells: Your spellbook also holds your daily and utility spells. You begin knowing two daily spells, one of which you can use on any given day. Each time you gain a level that lets you select a daily spell or a utility spell, choose two different daily spells or utility spells of that level to add to your book. After an extended rest, you can prepare a number of daily and utility spells according to what you can cast per day for your level. You can’t prepare the same spell twice. If you replace a spell because of gaining a level or through retraining, the previous spell vanishes from your spellbook and is replaced by the new spell. Capacity: A typical spellbook has 128 pages. Each spell takes up 1 page. A ritual takes up a number of pages equal to its level.');


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