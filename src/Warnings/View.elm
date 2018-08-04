module Warnings.View exposing (..)

import Html exposing (Html, div, text, program, button, label, input, fieldset)
import Html.Attributes exposing (id, type_, for, value, class, form, placeholder, style, name, checked, readonly)
import Dict
import Messages exposing (..)
import Attributes.Types exposing (..)
import Skills.Types exposing (..)
import Weirdness.Types exposing (..)
import Amps.Types exposing (Amp)
import Helpers exposing (ampPointsSpent)


classNameForPoints : Int -> String
classNameForPoints points =
    case points < 0 of
        True ->
            "negative-value-invalid"

        False ->
            case points > 0 of
                True ->
                    "positive-value-invalid"

                False ->
                    "value-valid"


attributePointsToSpendHtml : Attributes -> Int -> Html Msg
attributePointsToSpendHtml spentPoints availablePoints =
    let
        points =
            attributePointsToSpend spentPoints availablePoints

        classname =
            classNameForPoints points
    in
        div [ class classname ] [ ("Attribute points: " ++ ((availablePoints - points) |> toString) ++ "/" ++ (availablePoints |> toString)) |> text ]


attributePointsToSpend : Attributes -> Int -> Int
attributePointsToSpend spentPoints availablePoints =
    let
        sumOfSpentPoints =
            spentPoints.strength + spentPoints.agility + spentPoints.willpower + spentPoints.logic + spentPoints.charisma
    in
        availablePoints - sumOfSpentPoints


skillDoesNotFitWeirdnessWarning : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> Weirdness -> Html Msg
skillDoesNotFitWeirdnessWarning selectedSkills weirdness =
    let
        isAwakenedSkill : Maybe Skill -> Bool
        isAwakenedSkill maybeSkill =
            case maybeSkill of
                Nothing ->
                    False

                Just skill ->
                    List.any (\skilltype -> skilltype == AwakenedSkill) skill.skillTypes

        hasAwakenedSkill =
            selectedSkills
                |> Dict.toList
                |> List.any (\( _, ( maybeSkill, _, _ ) ) -> (isAwakenedSkill maybeSkill))

        warningAwakened =
            case hasAwakenedSkill && weirdness /= Awakened of
                True ->
                    div [] [ text "Do not use magic skills for non-awakened characters. Check the Awakened box on the top right." ]

                False ->
                    div [] []

        isEmergedSkill : Maybe Skill -> Bool
        isEmergedSkill maybeSkill =
            case maybeSkill of
                Nothing ->
                    False

                Just skill ->
                    List.any (\skilltype -> skilltype == EmergedSkill) skill.skillTypes

        hasEmergedSkill =
            selectedSkills
                |> Dict.toList
                |> List.any (\( _, ( maybeSkill, _, _ ) ) -> (isEmergedSkill maybeSkill))

        warningEmerged =
            case hasEmergedSkill && weirdness /= Emerged of
                True ->
                    div [] [ text "Do not use technomancer skills for non-technomancers. Check the Emerged box on the top right." ]

                False ->
                    div [] []
    in
        div [ class "negative-value-invalid" ] [ warningAwakened, warningEmerged ]


ampPointsToSpendHtml : Dict.Dict String (Maybe Amp) -> Int -> Weirdness -> Html Msg
ampPointsToSpendHtml selectedAmps ampPoints weirdness =
    let
        points : Int
        points =
            ampPointsSpent selectedAmps weirdness

        classname =
            classNameForPoints (ampPoints - points)
    in
        div [ class classname ] [ ("Shadowamp points: " ++ (points |> toString) ++ "/" ++ (ampPoints |> toString) ++ " (unspent points are added to EDGE)") |> text ]


skillPointsValidHtml : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> Html Msg
skillPointsValidHtml selectedSkills =
    let
        anyZeroFunction ( maybeSkill, _, i ) =
            case maybeSkill of
                Nothing ->
                    False

                Just _ ->
                    i == 0

        isZero : Bool
        isZero =
            selectedSkills
                |> Dict.toList
                |> List.map (\( _, v ) -> v)
                |> List.any anyZeroFunction

        ( classname, warning ) =
            case isZero of
                True ->
                    ( "negative-value-invalid", "Please remove Skills with zero Skill Points." )

                False ->
                    ( "value-valid", "" )
    in
        div [ class classname ] [ warning |> text ]


skillSpecsValidHtml : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> Html Msg
skillSpecsValidHtml selectedSkills =
    let
        isInvalidSpecFunction ( _, maybeSpec, i ) =
            case maybeSpec of
                Nothing ->
                    False

                Just _ ->
                    i == 1

        isInvalid : Bool
        isInvalid =
            selectedSkills
                |> Dict.toList
                |> List.map (\( _, v ) -> v)
                |> List.any isInvalidSpecFunction

        ( classname, warning ) =
            case isInvalid of
                True ->
                    ( "negative-value-invalid", "Skills with only one Skill Points cannot have a Specialisation." )

                False ->
                    ( "value-valid", "" )
    in
        div [ class classname ] [ warning |> text ]


skillPointsToSpendHtml : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> Int -> Html Msg
skillPointsToSpendHtml selectedSkills skillPoints =
    let
        points =
            skillPointsSpent selectedSkills

        classname =
            classNameForPoints (skillPoints - points)
    in
        div [ class classname ] [ ("Skill points: " ++ (points |> toString) ++ "/" ++ (skillPoints |> toString)) |> text ]


skillPointsSpent : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> Int
skillPointsSpent selectedSkills =
    let
        toOneOrZero m =
            case m of
                Nothing ->
                    0

                Just a ->
                    1

        skills =
            Dict.values selectedSkills

        sumPoints =
            skills
                |> List.map (\( _, _, p ) -> p)
                |> List.sum

        sumSpecs =
            skills
                |> List.map (\( _, sp, _ ) -> sp)
                |> List.map toOneOrZero
                |> List.sum
    in
        (sumSpecs + sumPoints)
