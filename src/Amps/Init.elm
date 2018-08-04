module Amps.Init exposing (..)

import Amps.Types exposing (..)
import Selectize
import Dict


initAmps : Dict.Dict String (Maybe Amp)
initAmps =
    [ "a1", "a2", "a3", "a4", "a5", "a6" ]
        |> List.map (\k -> ( k, Nothing ))
        |> Dict.fromList



{- the selectize model for the amp dropdown in the modal -}


initAmpSelectizeModel : String -> Selectize.State Amp
initAmpSelectizeModel uid =
    (Selectize.closed
        uid
        (\amp -> amp.name)
        (availableAmps |> List.map Selectize.entry)
    )


initAmpTypeSelectizeModel : String -> Selectize.State AmpType
initAmpTypeSelectizeModel uid =
    (Selectize.closed
        uid
        (ampTypeToString)
        (ampTypes |> List.map (\( at, _ ) -> Selectize.entry at))
    )


availableAmps : List Amp
availableAmps =
    [ --bioware headware
      Amp Bioware 3 0.5 "BIOWARE EYES 1" "Ignore vision modifiers. Reroll 1 on Perception."
    , Amp Bioware 3 0.5 "CEREBRAL BOOSTER 1" "+1 die to mathematics-based Logic Skills."
    , Amp Bioware 2 0.5 "MNEMONIC ENHANCER" "???"
    , Amp Bioware 3 0.5 "SYNAPTIC BOOSTER 1" "Reaction Enhancement Level 1."

    --bioware bodyware
    , Amp Bioware 3 0.5 "BONE DENSITY AUGMENTATION 1" "Damage Reduction 1."
    , Amp Bioware 2 0.5 "DYNAMIC HAIR/PRINTS/TATTOOS" ""
    , Amp Bioware 3 0.5 "MUSCLE AUGMENTATION 1" "+1 to Close Combat damage."
    , Amp Bioware 3 0.5 "MUSCLE TONER" "Reroll 1 on Close Combat."
    , Amp Bioware 3 0.5 "ORTHOSKIN" "Armor +3."
    , Amp Bioware 3 0.5 "SYNTHACARDIUM" "+1 die to Athletics."
    , Amp Bioware 3 0.5 "TAILORED PHEROMONES 1" "You smell very convincing. Reroll 1 on in-person Charisma Skills."

    --bioware biolimbs
    , Amp Bioware 3 0.5 "BIOWARE ARMS" "Reroll 1 on Agility-based attacks."
    , Amp Bioware 3 0.5 "BIOWARE LEGS" "Reroll 1 on Athletics."
    , Amp Bioware 3 0.5 "BIOWARE TAIL" "Reroll 1 on Acrobatics."
    , Amp BiowareWeapon 2 0.5 "NATURAL CLAWS" "Unarmed may do Stun or Physical."

    --cyberware headware
    , Amp Cyberware 1 1.0 "AUDIO ANALYZER" ""
    , Amp Cyberware 1 1.0 "OLFACTORY BOOSTER" ""
    , Amp Cyberware 1 1.0 "TASTE BOOSTER" ""
    , Amp Cyberware 2 1.0 "CONTROL RIG 1" "Control vehicles by VR (+1 die). Reroll 1 on Pilot and Gunnery."
    , Amp Cyberware 2 1.0 "CYBEREYES" "Ignore vision modifiers. Reroll 1 on Perception."
    , Amp Cyberware 1 1.0 "DATAJACK AND HEADWARE" "Access the matrix by VR (+1 die)."
    , Amp Cyberware 2 1.0 "SMARTLINK" "+1 die when using a Smartlink® Weapon."
    , Amp Cyberware 3 1.0 "CYBEREYES WITH SMARTLINK" "Ignore vision modifiers. Reroll 1 on Perception. +1 die when using a Smartlink® Weapon."

    --cyberware bodyware
    , Amp Cyberware 2 1.0 "BONE LACING 1" "Damage Reduction 1."
    , Amp Cyberware 2 1.0 "DERMAL PLATING" "Armor +3."
    , Amp Cyberware 2 1.0 "REACTION ENHANCERS" "Reaction Enhancement Level 1."
    , Amp Cyberware 2 1.0 "SKILL WIRES 1" "+1 to [SKILL]."
    , Amp Cyberware 2 1.0 "WIRED REFLEXES 1" "Reaction Enhancement Level 1."

    --cyberware cyberlimbs
    , Amp Cyberware 2 1.0 "CYBERARMS 1" "Reroll 1 on Agility-based attacks."
    , Amp Cyberware 2 1.0 "CYBERLEGS 1" "Reroll 1 on Athletics."
    , Amp Cyberware 2 1.0 "CYBERTAIL 1" "Reroll 1 on Acrobatics."
    , Amp Cyberware 2 1.0 "CYBERLIMB ARMOR 1" "Damage Reduction 1."
    , Amp CyberwareWeapon 1 1.0 "CYBERSPURS" "Unarmed may do Stun or Physical."
    , Amp CyberwareWeapon 2 1.0 "RETRACTABLE HAND RAZORS" "Unarmed may do Stun or Physical. Reroll 1 on Unarmed attacks."
    , Amp Cyberware 1 1.0 "CYBERLIMB COMPARTMENT" ""
    , Amp Cyberware 1 1.0 "CYBERLIMB SLIDE" ""
    , Amp Cyberware 1 1.0 "CYBERLIMB HOLSTER" ""

    --adept powers
    , Amp AdeptPower 2 0 "ATTRIBUTE BOOST 1 (choose attribute)" "+1 die to [ATTRIBUTE]. Cooldown 1."
    , Amp AdeptPower 2 0 "CRITICAL STRIKE 1" "+1 to Close Combat damage."
    , Amp AdeptPower 2 0 "DANGER SENSE 1" "Reroll 1 on Agility-based defense."
    , Amp AdeptPower 2 0 "ENHANCED ACCURACY 1" "Reroll 1 on Agility-based attacks."
    , Amp AdeptPower 2 0 "ENHANCED MOVEMENT 1" "Choose one per level: Bounding Step (+1 Move), Light Body, Traceless Walk, or Wall Running."
    , Amp AdeptPower 2 0 "ENHANCED PERCEPTION 1" "Ignore vision modifiers. Reroll 1 on Perception."
    , Amp AdeptPower 2 0 "IMPROVED REFLEXES 1" "Reaction Enhancement Level 1."
    , Amp AdeptPower 1 0 "KILLING HANDS" "Unarmed may do Stun or Physical."
    , Amp AdeptPower 2 0 "MISSILE PARRY 1" "Reroll 1 on Projectile Weapon defense. Catch on net hit."
    , Amp AdeptPower 3 0 "MYSTICAL ARMOR 1" "Damage Reduction 1. Works in Astral Combat."
    , Amp AdeptPower 2 0 "PAIN RESISTANCE 1" "Ignore -1 Wound Modifier."
    , Amp AdeptPower 2 0 "RAPID HEALING" "Heal all Stun and Physical damage between Scenes."
    , Amp AdeptPower 2 0 "SPELL RESISTANCE 1" "Reroll 1 on resisting spells and critter powers."
    , Amp AdeptPower 2 0 "VOICE CONTROL 1" "Reroll 1 on Acting/Performance."

    --combat spells
    , Amp Spell 2 0 "ACID STREAM" "Damage 6P. Defense A+L. +2 Armor damage."
    , Amp Spell 2 0 "CLOUT" "Damage 6P. Defense A+L. Knockdown."
    , Amp Spell 2 0 "FIRE BOLT" "Damage 6P. Defense A+L. Fire effects."
    , Amp Spell 3 0 "LIGHTNING BOLT" "Damage 6P/AA. Defense S+W. Reroll 1."
    , Amp Spell 2 0 "MANA BOLT" "Damage 6P/AA. Defense S+W."
    , Amp Spell 3 0 "POWER BOLT" "Damage 6P/AA. Defense S+W. May target Essence 0 targets."
    , Amp Spell 1 0 "STUN BOLT" "Damage 5S/AA. Defense S+W."

    --detection spells
    , Amp Spell 1 0 "ANALYZE TRUTH" "You are alerted if the subject knowingly tells an untruth. Defense W+W."
    , Amp Spell 1 0 "CLAIRVOYANCE" ""
    , Amp Spell 1 0 "CLAIRAUDIANCE" ""
    , Amp Spell 2 0 "CLAIRVOYANCE AND CLAIRAUDIANCE" ""
    , Amp Spell 2 0 "COMBAT SENSE 1" "Effect. +1 to Agility-based defense."
    , Amp Spell 2 0 "DETECT ENEMY" "Gain 1 Plot Point when Surprise Threat (enemy) is played."
    , Amp Spell 1 0 "DETECT MAGIC" ""

    --health spells
    , Amp Spell 1 0 "ANTIDOTE" ""
    , Amp Spell 2 0 "DECREASE [ATTRIBUTE] 1" "Effect. Target -1 to [choose Attribute]. Close only. Defense S+W."
    , Amp Spell 2 0 "HEAL" "Effect. Target character heals 1 damage per hit. Missing Essence reduces dice."
    , Amp Spell 2 0 "INCREASE [ATTRIBUTE] 1" "Effect. Target +1 to [choose Attribute]. Close only."
    , Amp Spell 2 0 "INCREASE REFLEXES 1" "Effect. Target gains Reaction Enhancement Level 1."
    , Amp Spell 2 0 "RESIST PAIN 1" "Effect. Target ignores up to 2 points of dice pool penalties from condition monitors."
    , Amp Spell 3 0 "RESIST PAIN 2" "Effect. Target ignores up to 4 points of dice pool penalties from condition monitors."

    --illusion spells
    , Amp Spell 2 0 "CHAOTIC MIND 1" "Effect. Target forced to reroll 1 success on all actions. Drain 1."
    , Amp Spell 2 0 "CONFUSION 1" "Effect. Target -1 to all actions. Defense W+W."
    , Amp Spell 2 0 "INVISIBILITY 1" "Effect. Target rerolls 1 on Stealth."
    , Amp Spell 2 0 "PHYSICAL MASK 1" "Effect. Target rerolls 1 on Acting."
    , Amp Spell 1 0 "PHANTASM" ""

    --manipulation spells
    , Amp Spell 2 0 "ARMOR 1" "Effect. Target gains +3 Armor."
    , Amp Spell 2 0 "CONTROL THOUGHTS 1" "Effect. +1 to Intimidation or Negotiation. Defense W+W."
    , Amp Spell 2 0 "STEALTH 1" "Effect. Target +1 to Stealth."
    , Amp Spell 1 0 "LEVITATE" "Slowly levitate things or people. Even yourself. Defense S+W."
    , Amp Spell 1 0 "MAGIC FINGERS" ""
    , Amp Spell 2 0 "PHYSICAL BARRIER 1" "Effect. Translucent wall with 3 Armor."
    , Amp Spell 2 0 "SHADOW 1" "Effect. Increase darkness vision modifier by +1."

    --initiation and other magical amps and foci
    , Amp NoType 3 0 "INITIATION 1" """
    Reroll 1 on Sorcery or Conjuring (choose one). Higher Amp Levels have Metamagics,
    e.g. Quickening (Spell Sustain), Shielding (Spell Damage Reduction), ...
    """
    , Amp NoType 2 0 "ALCHEMY" "Allow another player to spend your Plot Point: They roll your W+Spellcasting release one of your spells."
    , Amp Focus 2 0 "SPIRIT FOCUS" "Sustain one additional spirit."
    , Amp Focus 2 0 "SUSTAINING FOCUS" "Sustain one additional effect spell."
    , Amp Focus 2 0 "WEAPON FOCUS 1" "+1 die to Close Combat or Astral Combat. Works in Astral Combat. Weapon."
    , Amp Focus 2 0 "PROTECTIVE AMULET (SHIELDING FOCUS)" "Reduce damage of an attack by half (round up). Only once per day." --"Once per Scene, reduce damage from one attack by half (round up)."

    --decks
    --, Amp Cyberdeck 3 0 "NOVATECH NAVIGATOR" "Because you need a deck."
    , Amp Cyberdeck 2 0 "CYBERDECK 1" """
    Reroll 1 on Matrix actions. FW +1. Matrix CM 6. Programs 1.
    [Customize: Add Amp Levels to improve Processing, Firewall,
    Durability, and/or Storage.]
    """
    , Amp Cyberdeck 3 0 "NOVATECH NAVIGATOR" "Because you need a deck. Reroll 1 on Matrix actions. FW +2. Matrix CM 6. Programs 1."
    , Amp Cyberdeck 3 0 "RENRAKU TSURUGI" "Because you need a deck. Reroll 1 on Matrix actions. FW +1. Matrix CM 9. Programs 1."

    --attack programs
    , Amp Program 2 0 "BIOFEEDBACK" "Optionally apply your Matrix damage to your target's Stun/Physical CM instead."
    , Amp Program 2 0 "HAMMER 1" "+1 Cybercombat damage."
    , Amp Program 2 0 "MUGGER 1" "+1 die to Matrix Combat."

    --data programs
    , Amp Program 2 0 "FORK" "+1 Attack (same Matrix action only)."
    , Amp Program 2 0 "SIGNAL SCRUB 1" "Reduce Noise modifiers by 2."
    , Amp Program 2 0 "TRACK 1" "+1 die to Matrix tracking."

    --firewall programs
    , Amp Program 2 0 "ARMOR 1" "+3 Matrix Condition Monitor."
    , Amp Program 2 0 "ENCRYPT 1" "+1 to Firewall."
    , Amp Program 2 0 "GUARD 1" "Matrix Damage Reduction 1."

    --stealth programs
    , Amp Program 2 0 "EXPLOIT 1" "+1 die to non-combat Hacking."
    , Amp Program 2 0 "SNEAK 1" "Enemies -1 die to Matrix Tracking."
    , Amp Program 2 0 "STEALTH 1" "Enemies -1 to Matrix Perception."

    --complex forms
    , Amp ComplexForm 2 0 "CLEANER" "Effect. Roll -1 Overwatch."
    , Amp ComplexForm 2 0 "DIFFUSION 1" "Effect. Target Logic (Matrix only) -1."
    , Amp ComplexForm 2 0 "INFUSION 1" "Effect. Target Logic (Matrix only) +1."
    , Amp ComplexForm 3 0 "PULSE STORM 1" "Effect. Target must reroll 1 success on Matrix actions. Cooldown 1."
    , Amp ComplexForm 2 0 "PUPPETEER" "Effect. Control one Narration of one Matrix target. Cooldown 1."
    , Amp ComplexForm 1 0 "RESONANCE SPIKE 1" "Cyber Combat. Damage 5S. Defense L+FW."
    , Amp ComplexForm 2 0 "STATIC BOMB" "Effect. Invisible to Matrix/Drone for 2 Narrations."
    , Amp ComplexForm 2 0 "STITCHES" "Effect. Target sprite heals 1 damage per hit."
    , Amp ComplexForm 2 0 "TATTLETALE" "Effect. Target rolls +1 Overwatch."

    --, Amp ComplexForm 2 0 "DRONE MESH" "Control drones via AR/VR. Reroll 1 die on Vehicle Tests."
    --submersion
    , Amp ComplexForm 3 0 "SUBMERSION 1" """
    Reroll 1 on Hacking or Tasking (choose one). Higher Amp Levels have Echoes,
    e.g. Mind over Machine (control vehicles+drones), Overclocking (Reaction Enhancement), ...
    """

    --drones
    , Amp Drone 3 0 "LARGE DRONE x1" "+1 Attack and Movement (drone only). [A12, D1, M2]."
    , Amp Drone 2 0 "MEDIUM DRONE x1" "+1 Attack and Movement (drone only). [A9, D1, M2]."
    , Amp Drone 1 0 "SMALL DRONE x1" "+1 Attack and Movement, +2 dice on Stealth (drone only). [A6, D0, M3]."
    , Amp Drone 1 0 "MICRO DRONE x2" "+1 Movement, +4 dice on Stealth (drone only). [A3, D0, M3]."

    --gear
    , Amp Gear 1 0 "RIGGER COMMAND CONSOLE (RCC)" "+1 die to all Drone/Vehicle Skill/Attribute tests when jacked into a Drone/Vehicle."

    --NoType
    , Amp NoType 2 0 "TEAM PLAYER" "Give your own Plot Points and Edge to other players."
    , Amp NoType 2 0 "JACK OF ALL TRADES" "Reroll 1 on skills you do not have."
    , Amp NoType 2 0 "I KNOW EVERYBODY" "Get additional [Charisma Rating] contacts."
    , Amp NoType 4 0 "FEAR" "+2 dice to Intimidation. Melee opponents must roll 2 hits (C+W) or run away."
    , Amp NoType 2 0 "CHAMELEON SUIT" "9 Armor. Solo invisibility. Reroll 1 on Stealth."
    ]
