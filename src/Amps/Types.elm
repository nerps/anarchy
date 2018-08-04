module Amps.Types exposing (..)

import List


type AmpType
    = Cyberware
    | CyberwareWeapon
    | Bioware
    | BiowareWeapon
    | Program
    | Cyberdeck
    | ComplexForm
    | Spell
    | Focus
    | AdeptPower
    | Drone
    | Gear
    | NoType


ampTypes : List ( AmpType, String )
ampTypes =
    [ ( Cyberware, "Cyberware" )
    , ( CyberwareWeapon, "Cyberware Weapon" )
    , ( Bioware, "Bioware" )
    , ( BiowareWeapon, "Bioware Weapon" )
    , ( Program, "Program" )
    , ( Cyberdeck, "Cyberdeck" )
    , ( ComplexForm, "Complex Form" )
    , ( Spell, "Spell" )
    , ( Focus, "Focus" )
    , ( AdeptPower, "Adept Power" )
    , ( Drone, "Drone" )
    , ( Gear, "Gear" )
    , ( NoType, "Miscellaneous" )
    ]


ampTypeToString : AmpType -> String
ampTypeToString amptype =
    let
        maybePair =
            List.filter (\( val, _ ) -> val == amptype) ampTypes
                |> List.head
    in
        case maybePair of
            Just ( _, str ) ->
                str

            Nothing ->
                "Error - No Amptype!"


stringToAmpType : String -> AmpType
stringToAmpType strAmpType =
    let
        maybePair =
            List.filter (\( _, val ) -> val == strAmpType) ampTypes
                |> List.head
    in
        case maybePair of
            Just ( amptype, _ ) ->
                amptype

            Nothing ->
                NoType


type alias Amp =
    { amptype : AmpType
    , points : Int
    , essenceCost : Float
    , name : String
    , description : String
    }


getDescription : Maybe Amp -> String
getDescription maybeAmp =
    let
        strWithType =
            case maybeAmp of
                Nothing ->
                    ""

                Just amp ->
                    case amp.amptype of
                        NoType ->
                            amp.description

                        a ->
                            (ampTypeToString a) ++ ". " ++ amp.description
    in
        case maybeAmp of
            Nothing ->
                ""

            Just amp ->
                case amp.essenceCost == 0.0 of
                    True ->
                        strWithType

                    False ->
                        strWithType ++ " –" ++ (toString amp.essenceCost) ++ " Essence."


getEssenceCost : Maybe Amp -> Float
getEssenceCost maybeAmp =
    case maybeAmp of
        Nothing ->
            0.0

        Just amp ->
            amp.essenceCost


getPointsText : Maybe Amp -> String
getPointsText maybeAmp =
    case maybeAmp of
        Nothing ->
            ""

        Just amp ->
            amp.points |> toString


getPoints : Maybe Amp -> Int
getPoints maybeAmp =
    case maybeAmp of
        Nothing ->
            0

        Just amp ->
            amp.points
