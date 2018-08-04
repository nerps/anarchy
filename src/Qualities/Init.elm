module Qualities.Init exposing (..)

import Qualities.Types exposing (Quality)
import Attributes.Types exposing (Attributes)
import Selectize
import Dict


initQualities : Dict.Dict String (Maybe Quality)
initQualities =
    --two positive qualities (ends in p), one negative quality (ends in n)
    [ "q1p", "q2p", "q3n" ] |> List.map (\k -> ( k, Nothing )) |> Dict.fromList


initQualitySelectizeModel : String -> Selectize.State Quality
initQualitySelectizeModel uid =
    let
        options =
            case String.endsWith "p" uid of
                True ->
                    availableQualitiesPositive |> List.map Selectize.entry

                False ->
                    availableQualitiesNegative |> List.map Selectize.entry
    in
        (Selectize.closed
            uid
            (\quality -> quality.title)
            options
        )


at : Attributes
at =
    Attributes 0 0 0 0 0 0


availableQualitiesPositive : List Quality
availableQualitiesPositive =
    [ Quality "ACE PILOT" "+2 dice to Pilot (Other)." at at 0 0 0
    , Quality "AMBIDEXTROUS" "+2 dice when weilding two melee weapons or two non-melee weapons." at at 0 0 0
    , Quality "ANALYTICAL MIND" "" at at 0 0 0
    , Quality "ANIMAL EMPATHY" "+2 dice on any test involving influence or control of an animal." at at 0 0 0
    , Quality "APTITUDE" "" at at 0 0 0
    , Quality "ASTRAL CHAMELEON" "" at at 0 0 0
    , Quality "BETTER FEARED THAN LOVED" "You have the Pee Pee Tape. Add The Donald (blackmailed person) to your contacts." at at 0 0 0
    , Quality "BIOCOMPATABILITY" "Ignore 1 point of Amp Essence cost." at at 1 0 0 -- modify essence calculation
    , Quality "BLACK MARKET PIPELINE (Specify)" "Add a reliable fence for (Specify! e.g. Narcotics, Firearms, BTLs, ...) to your contacts." at at 0 0 0
    , Quality "BLANDNESS" "" at at 0 0 0
    , Quality "BRAND LOYALTY" "+2 dice with products from [BRAND]. Reroll 1 success when using a competing product." at at 0 0 0
    , Quality "BRUISER" "+2 dice on Intimidation. May link Intimidation to Strength instead of Charisma." at at 0 0 0
    , Quality "CATLIKE" "+2 dice on Stealth." at at 0 0 0
    , Quality "CODESLINGER" "+2 dice on Hacking." at at 0 0 0
    , Quality "COLLEGE EDUCATION" "Gain 2 additional knowledge skills." at at 0 0 0 -- duplicates FORMAL EDUCATION
    , Quality "COMBAT PILOT" "+2 dice on Vehicle Weapons." at at 0 0 0
    , Quality "EXCEPTIONAL ATTRIBUTE (STRENGTH)" "+1 Strength Maximum." at (Attributes 1 0 0 0 0 0) 0 0 0 --increases cap
    , Quality "EXCEPTIONAL ATTRIBUTE (AGILITY)" "+1 Agility Maximum." at (Attributes 0 1 0 0 0 0) 0 0 0 --increases cap
    , Quality "EXCEPTIONAL ATTRIBUTE (WILLPOWER)" "+1 Willpower Maximum." at (Attributes 0 0 1 0 0 0) 0 0 0 --increases cap
    , Quality "EXCEPTIONAL ATTRIBUTE (LOGIC)" "+1 Logic Maximum." at (Attributes 0 0 0 1 0 0) 0 0 0 --increases cap
    , Quality "EXCEPTIONAL ATTRIBUTE (CHARISMA)" "+1 Charisma Maximum." at (Attributes 0 0 0 0 1 0) 0 0 0 --increases cap
    , Quality "FORMAL EDUCATION" "Gain 2 additional knowledge skills." at at 0 0 0 -- duplicates COLLEGE EDUCATION
    , Quality "FAME" "+2 dice on Charisma Tests if recognized." at at 0 0 0
    , Quality "GEARHEAD" "+2 dice on difficult maneuvers." at at 0 0 0
    , Quality "GO BIG OR GO HOME" "-2 dice on Cybercombat, but reroll all misses once." at at 0 0 0
    , Quality "GUTS" "Reroll 2 dice when resisting Fear or Intimidation." at at 0 0 0
    , Quality "HAWKEYE" "+2 dice on Perception Tests." at at 0 0 0
    , Quality "HIGH PAIN TOLERANCE" "Ignore up to two points of dice pool penalties from condition monitors." at at 0 0 0
    , Quality "HOME GROUND (Select Home Ground)" "Gain a Plot Point when entering or waking up in [chose Home Ground, e.g. Stuffer Shack, Redmond Barrens]." at at 0 0 0
    , Quality "INDOMITABLE (Select Combat Skill)" "Reroll 2 when attacking with (choose Combat Skill)." at at 0 0 0
    , Quality "JURYRIGGER" "Get a free Glitch die that can not Glitch on Repair." at at 0 0 0
    , Quality "LEADER OF THE PACK" "Add 1 group/organization/gang to your contacts." at at 0 0 0
    , Quality "LUCKY" "+1 Edge value." (Attributes 0 0 0 0 0 1) at 0 0 0 --increases edge value
    , Quality "MAGIC RESISTANCE" "+4 dice when defending with Willpower against Magic." at at 0 0 0
    , Quality "MENTOR SPIRIT (BEAR/STRENGTH/PROTECTION)" "+1 damage on Melee Combat. FIRST AID does not cost a Plot Point." at at 0 0 0
    , Quality "MENTOR SPIRIT (BERSERKER)" "+1 damage on Melee Combat and Combat Spells." at at 0 0 0
    , Quality "MENTOR SPIRIT (CAT/MYSTERY/STEALTH)" "+1 die on Athletics and Stealth. Reroll 1 on Effect Spells." at at 0 0 0
    , Quality "MENTOR SPIRIT (CHAOS)" "+1 die on Con Artistry. SHAKE IT UP does not cost a Plot Point." at at 0 0 0
    , Quality "MENTOR SPIRIT (COYOTE)" "+1 die on Con. Reroll 1 on Effect Spells." at at 0 0 0
    , Quality "MENTOR SPIRIT (DOG)" "+1 die on Survival. TAKE THE HIT does not cost a Plot Point." at at 0 0 0
    , Quality "MENTOR SPIRIT (DRAGONSLAYER)" "+1 die on Combat Spells. Reroll 1 on Combat Spells." at at 0 0 0
    , Quality "MENTOR SPIRIT (EAGLE)" "+1 die on Perception Tests. Reroll 1 on Conjuring." at at 0 0 0
    , Quality "MENTOR SPIRIT (FIRE BRINGER)" "+1 die on Engineering. Reroll 1 on Effect Spells." at at 0 0 0
    , Quality "MENTOR SPIRIT (MOUNTAIN)" "+2 dice on Survival." at at 0 0 0
    , Quality "MENTOR SPIRIT (ORACLE)" "+1 die on Perception Tests. FLASHBACK does not cost a Plot Point." at at 0 0 0
    , Quality "MENTOR SPIRIT (PEACEMAKER)" "+2 dice on Negotiation." at at 0 0 0
    , Quality "MENTOR SPIRIT (RAT)" "+1 die on Escape Artist and Stealth. Reroll 1 on Effect Spells." at at 0 0 0
    , Quality "MENTOR SPIRIT (RAVEN)" "Get an additional Knowledge Skill. LIVE DANGEROUSLY does not cost a Plot Point." at at 0 0 0
    , Quality "MENTOR SPIRIT (SEA)" "+2 dice on Swimming. +2 dice on Pickpocketing." at at 0 0 0
    , Quality "MENTOR SPIRIT (SEDUCER)" "+1 die on Con. Reroll 1 on Acting and Performance." at at 0 0 0
    , Quality "MENTOR SPIRIT (SHARK)" "+1 damage on Unarmed Melee Combat. Reroll 1 on Melee Combat and Combat Spells." at at 0 0 0
    , Quality "MENTOR SPIRIT (SNAKE/KNOWLEDGE/CURIOSITY)" "Get an additional Knowledge Skill. +1 die on Perception Tests." at at 0 0 0
    , Quality "MENTOR SPIRIT (THUNDERBIRD/ANGER/WAR)" "Reroll 1 on Intimidation. +1 damage on Combat Spells (or Melee Combat -- choose one!)." at at 0 0 0
    , Quality "MENTOR SPIRIT (WISE WARRIOR/DUTY/WISDOM)" "+2 dice on Diplomacy. Reroll 1 on Combat Spells (or Melee Combat -- choose one!)." at at 0 0 0
    , Quality "MENTOR SPIRIT (WOLF/HUNTING/FELLOWSHIP)" "+1 die on Tracking Tests. Reroll 1 on Combat Spells." at at 0 0 0
    , Quality "NATURAL ATHLETE" "+2 dice on Athletics." at at 0 0 0
    , Quality "NATURAL HARDENING" "Reduce Matrix damage taken by 2. Technomancer only." at at 0 0 0
    , Quality "NATRUAL IMMUNITY" "High resistance against pathogens, toxins, etc." at at 0 0 0
    , Quality "NOW YOU SEE ME" "+2 dice on Escape Artist." at at 0 0 0
    , Quality "PHOTOGRAPHIC MEMORY" "" at at 0 0 0
    , Quality "QUICK HEALER" "+2 dice to any test to heal this character." at at 0 0 0
    , Quality "SILVER TONGUE" "Reroll 2 on Charisma Tests." at at 0 0 0
    , Quality "SPIRIT AFFINITY (Specify Spirit Type)" "+2 dice with (Chosen Spirit Type)." at at 0 0 0
    , Quality "SPIRIT WHISPERER" "Reroll 2 on Conjuring." at at 0 0 0
    , Quality "STREET RACER" "+2 dice on Pilot (Ground) Tests." at at 0 0 0
    , Quality "TOUGH AS NAILS (PHYSICAL)" "+1 to Physical Condition Monitor" at at 0 1 0 -- modify condition monitor
    , Quality "TOUGH AS NAILS (STUN)" "+1 to Stun Condition Monitor" at at 0 0 1 -- modify condition monitor
    , Quality "TOUGHNESS" "Reduce damage taken by 1." at at 0 0 0
    , Quality "WELL TO DO" "The GM cuts you slack on spending ¥." at at 0 0 0
    ]


availableQualitiesNegative : List Quality
availableQualitiesNegative =
    [ Quality "ADDICTION (Specify)" "specify" at at 0 0 0
    , Quality "ALLERGY (Specify)" "specify" at at 0 0 0
    , Quality "ASTRAL BEACON" "specify" at at 0 0 0
    , Quality "BAD LUCK" "When you roll a Glitch Die you do not get an Exploit." at at 0 0 0
    , Quality "BAD REP" "" at at 0 0 0
    , Quality "CODE OF HONOR" "" at at 0 0 0
    , Quality "CODEBLOCK" "-2 dice on Hacking." at at 0 0 0
    , Quality "COMBAT JUNKIE" "" at at 0 0 0
    , Quality "COMBAT PARALYSIS" "Act last on the first round of a combat (unless you start the fight)." at at 0 0 0
    , Quality "DEPENDENTS" "" at at 0 0 0
    , Quality "DISTINCTIVE STYLE (Specify)" "" at at 0 0 0
    , Quality "DISTASTE FOR VIOLENCE" "" at at 0 0 0
    , Quality "ELF POSER" "" at at 0 0 0
    , Quality "GEEZER" "-2 dice when dealing with younger people, as GM sees fit." at at 0 0 0
    , Quality "GREMLINS" "" at at 0 0 0
    , Quality "ILLITERATE" "" at at 0 0 0
    , Quality "INCOMPETENT" "You always fail at [SKILL]. Specify! Ask your GM for approval." at at 0 0 0
    , Quality "LIFELONG THIEF" "At GM discretion, you must spend a Plot Point to avoid prioritizing petty (or grand) larceny over other concerns" at at 0 0 0
    , Quality "LOSS OF CONFIDENCE" "" at at 0 0 0
    , Quality "LOW PAIN TOLERANCE" "Increase penalties due to damage by 1." at at 0 0 0
    , Quality "KID" "-2 dice when dealing with adults, as GM sees fit." at at 0 0 0
    , Quality "ORK POSER" "" at at 0 0 0
    , Quality "PARANOIA" "Reroll 2 successes on social tests." at at 0 0 0
    , Quality "PHOBIA (Specify)" "-2 to all dice rolls when in the presence of (Phobia Source -- Please confirm this with your GM)." at at 0 0 0
    , Quality "PREJUDICED" "" at at 0 0 0
    , Quality "SCORCHED" "" at at 0 0 0
    , Quality "SENSITIVE SYSTEM" "" at at 0 0 0
    , Quality "SIMSENSE VERTIGO" "" at at 0 0 0
    , Quality "SINNER, NATIONAL" "" at at 0 0 0
    , Quality "SINNER, CRIMINAL" "" at at 0 0 0
    , Quality "SINNER, CORPORATE" "" at at 0 0 0
    , Quality "SOCIAL STRESS" "" at at 0 0 0
    , Quality "SPIRIT BANE" "" at at 0 0 0
    , Quality "STRAPPED FOR CASH" "GM is extra stingy on money issues with you." at at 0 0 0
    , Quality "STUBBORN LOYALTY" "" at at 0 0 0
    , Quality "THRILL SEEKER" "" at at 0 0 0
    , Quality "UNCOUTH" "Reroll 2 successes on social tests." at at 0 0 0
    , Quality "UNSTEADY HANDS" "-2 dice for most Agility tests." at at 0 0 0
    ]
