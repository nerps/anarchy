module Attributes.View exposing (..)

import Html exposing (Html, div, text, program, button, label, input, fieldset)
import Html.Attributes exposing (id, type_, for, value, class, form, placeholder, style, name, checked, readonly)
import Html.Events exposing (..)
import Messages exposing (..)
import Attributes.Types exposing (..)
import Dict
import Qualities.Types exposing (Quality)
import Helpers exposing (ampPointsSpent)
import Amps.Types exposing (Amp)
import Weirdness.Types exposing (Weirdness)
import Attributes.Init exposing (attributeMinima)


attributeInputs :
    Attributes
    -> Attributes
    -> Dict.Dict String (Maybe Quality)
    -> Attributes
    -> Dict.Dict String (Maybe Amp)
    -> Int
    -> Weirdness
    -> List (Html Msg)
attributeInputs metatypeAttributeMaxima metatypeAttributeModifiers qualities attributes selectedAmps maxAmpPoints weirdness =
    let
        attributeSpinners =
            [ Strength, Agility, Willpower, Logic, Charisma ]
                |> List.map (attributeSpinner attributeMinima metatypeAttributeMaxima metatypeAttributeModifiers qualities attributes)

        pointsSpent =
            ampPointsSpent selectedAmps weirdness
    in
        List.concat
            [ attributeSpinners
            , [ edgeText attributes metatypeAttributeModifiers pointsSpent maxAmpPoints qualities ]
            ]


attributeSpinner : Attributes -> Attributes -> Attributes -> Dict.Dict String (Maybe Quality) -> Attributes -> AttributeID -> Html Msg
attributeSpinner attributeMinima attributeMaxima attributeModifiers qualities attributes aID =
    let
        attributeValue =
            attributeGetters aID attributes

        attributeModifier =
            attributeGetters aID attributeModifiers

        attributeDisplayed =
            attributeValue + attributeModifier + attributeModifierFromQuality

        attributeMinimum =
            (attributeGetters aID attributeMinima) + attributeModifier + attributeModifierFromQuality

        attributeMaximum =
            (attributeGetters aID attributeMaxima) + attributeMaximumModifierFromQuality

        attributeMaximumModifierFromQuality =
            qualities
                -- get modifyAttributeMaximum from current qualities
                |> Dict.values
                |> List.map (Maybe.andThen (\q -> Just q.modifyAttributeMaximum))
                |> List.map (Maybe.andThen (\attr -> Just (attributeGetters aID attr)))
                |> List.map (Maybe.withDefault 0)
                |> List.sum

        attributeModifierFromQuality =
            qualities
                -- get modifyAttributeMaximum from current qualities
                |> Dict.values
                |> List.map (Maybe.andThen (\q -> Just q.modifyAttribute))
                |> List.map (Maybe.andThen (\attr -> Just (attributeGetters aID attr)))
                |> List.map (Maybe.withDefault 0)
                |> List.sum

        classInput =
            case attributeDisplayed > attributeMaximum of
                True ->
                    "attributeinput attributeinputInvalid"

                False ->
                    "attributeinput"
    in
        div [ class classInput ]
            [ -- text (aID |> attributeIDtoString)
              input
                [ type_ "number"
                , onInput (OnAttributeInputChanged aID)
                , value (attributeDisplayed |> toString)
                , Html.Attributes.min (attributeMinimum |> toString)
                , Html.Attributes.max (attributeMaximum |> toString)
                , Html.Attributes.title (attributeIDtoString aID)
                ]
                []
            ]


edgeText : Attributes -> Attributes -> Int -> Int -> Dict.Dict String (Maybe Quality) -> Html Msg
edgeText attributes attributeModifiers pointsSpent maxAmpPoints qualities =
    let
        getEdge =
            attributeGetters Edge

        value =
            min 6 ((getEdge attributes) + (getEdge attributeModifiers) + maxAmpPoints - pointsSpent + edgeModifierFromQuality)

        edgeModifierFromQuality =
            qualities
                -- get modifyAttributeMaximum from current qualities
                |> Dict.values
                |> List.map (Maybe.andThen (\q -> Just q.modifyAttribute))
                |> List.map (Maybe.andThen (\attr -> Just (getEdge attr)))
                |> List.map (Maybe.withDefault 0)
                |> List.sum
    in
        div [ class "attributeinput" ] [ text (toString value) ]
