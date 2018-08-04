module Skills.Init exposing (..)

import Skills.Types exposing (..)
import Attributes.Types
    exposing
        ( AttributeID(..)
        )
import Selectize
import Dict


defaultSkill : Skill
defaultSkill =
    Skill "" [] Agility []


availableSkills : List Skill
availableSkills =
    --Agility
    [ Skill "Athletics" [] Agility [ "Running", "Jumping", "Swimming", "Acrobatics" ]
    , Skill "Close Combat" [] Agility [ "Clubs", "Blades", "Unarmed Melee Combat", "Martial Arts", "Cyber Weapons", "Jiu-Jitsu" ]
    , Skill "Projectile Weapons" [] Agility [ "Bows", "Crossbows", "Throwing Weapons" ]
    , Skill "Firearms" [] Agility [ "Pistols", "Shotguns", "Submachine Guns", "Rifles", "Tasers" ]
    , Skill "Heavy Weapons" [] Agility [ "Machine Guns", "Assault Cannons", "Missile Launchers", "Grenade Launchers" ]
    , Skill "Vehicle Weapons" [] Agility [ "Vehicle-mounted Weapons", "Drone-mounted Weapons", "Pintle Mounts" ]
    , Skill "Stealth" [] Agility [ "Sneaking", "Palming", "Pickpocketing" ]
    , Skill "Pilot (Ground)" [] Agility [ "Cars", "Trucks", "Bikes", "Tanks", "Wheeled Drones", "Tracked Drones", "Walker Drones" ]
    , Skill "Pilot (Other)" [] Agility [ "Boats", "Planes", "VTOLs", "Helicopters", "U-Boats", "Rotor Drones" ]
    , Skill "Escape Artist" [] Agility [ "Escaping Bindings", "Contortionism", "Shaking a Tail" ]

    --Willpower
    , Skill "Conjuring" [ AwakenedSkill ] Willpower [ "Fire Spirits", "Water Spirits", "Air Spirits", "Earth Spirits", "Beast Spirits", "Guidance Spirits", "Guardian Spirits", "Task Spirits", "Plant Spirits", "Spirits of Man" ]
    , Skill "Sorcery" [ AwakenedSkill ] Willpower [ "Spellcasting", "Ritual Spellcasting", "Enchanting", "Counterspelling" ]
    , Skill "Astral Combat" [ AwakenedSkill ] Willpower []
    , Skill "Survival" [] Willpower [ "Wilderness", "Urban Areas", "Navigation", "Fasting" ]

    --Logic
    , Skill "Biotech" [] Logic [ "First Aid", "Medicine" ]
    , Skill "Hacking" [] Logic [ "Computer Hacking", "Cybercombat" ]
    , Skill "Electronics" [] Logic [ "Cyberdeck Repair" ]
    , Skill "Engineering" [] Logic [ "Auto Repair", "Aircraft Repair", "Boat Repair", "Drone Repair" ]
    , Skill "Tasking" [ EmergedSkill ] Logic [ "Compiling Sprites", "Threading Complex Forms" ]
    , Skill "Tracking" [] Logic [ "Physical Tracking", "Matrix Tracking", "Shadowing" ]

    --Charisma
    , Skill "Con" [] Charisma [ "Con Artistry", "Acting", "Performance", "Etiquette" ]
    , Skill "Intimidation" [] Charisma [ "Influence", "Interrogation", "Torture" ]
    , Skill "Negotiation" [] Charisma [ "Bargaining", "Contracts", "Diplomacy" ]
    , Skill "Disguise" [] Charisma [ "Camouflage", "Cosmetics", "Costuming", "Digital Alteration" ]
    ]
        {- enforce uniqueness of availableSkills.name -} |> List.map (\sk -> ( sk.name, sk ))
        |> Dict.fromList
        |> Dict.toList
        |> List.map (\( k, sk ) -> sk)


initSelectedSkills : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int )
initSelectedSkills =
    [ "s1", "s2", "s3", "s4", "s5" ]
        |> List.map (\k -> ( k, ( Nothing, Nothing, 0 ) ))
        |> Dict.fromList



--I need these inits to pick the correct Selectize.State from the dictionary


initSkillSelectizeStateIfNecessary : String -> Maybe ( String, Selectize.State Skill ) -> Selectize.State Skill
initSkillSelectizeStateIfNecessary uid_skill skillSelectizeStateMaybe =
    let
        ( uid, state ) =
            Maybe.withDefault ( uid_skill, initSkillSelectizeModel uid_skill ) skillSelectizeStateMaybe

        correctState =
            uid_skill == uid
    in
        case correctState of
            True ->
                state

            False ->
                initSkillSelectizeModel uid_skill


initSkillSpecSelectizeStateIfNecessary : String -> List SkillSpec -> Maybe ( String, Selectize.State SkillSpec ) -> Selectize.State SkillSpec
initSkillSpecSelectizeStateIfNecessary uid_skill availableSkillSpecs skillSelectizeStateMaybe =
    let
        uid_spec =
            uid_skill ++ "__spec"

        ( uid, state ) =
            Maybe.withDefault ( uid_skill, initSkillSpecSelectizeModel uid_spec availableSkillSpecs ) skillSelectizeStateMaybe

        correctState =
            uid_spec == uid
    in
        case correctState of
            True ->
                state

            False ->
                initSkillSpecSelectizeModel uid_spec availableSkillSpecs


initSkillSelectizeModel : String -> Selectize.State Skill
initSkillSelectizeModel uid =
    (Selectize.closed
        uid
        (\skill -> skill.name)
        (availableSkills |> List.map Selectize.entry)
    )


initSkillSpecSelectizeModel : String -> List SkillSpec -> Selectize.State SkillSpec
initSkillSpecSelectizeModel uid availableSkillSpecs =
    (Selectize.closed
        uid
        (\skillspec -> skillspec)
        (availableSkillSpecs |> List.map Selectize.entry)
    )
