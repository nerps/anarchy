module Armor.View exposing (view)

import Metatypes.Types exposing (..)
import Skills.Types exposing (Skill, SkillSpec)
import Dict
import List
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Debug

view : Metatype -> Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> Int -> Html Msg
view metatype selectedSkills skillPoints =
    let
        iMetatypeArmor =
            metatype.armorModifier

        iSkillPointsSpent =
            Dict.toList selectedSkills
                |> List.map
                    (\( _, ( _, maybeSpec, points ) ) ->
                        ((maybeSpec
                            |> Maybe.andThen (\m -> Just 1)
                            |> Maybe.withDefault 0
                         )
                            + points
                        )
                    )
                |> List.sum

        iSkillPointsLeftOver =
            skillPoints - iSkillPointsSpent

        ( iSkillArmor, strSkillArmor ) =
            case iSkillPointsLeftOver > 0 of
                True ->
                    ( 3, "One Skill Point left over, increased Armor by 3." )

                False ->
                    case iSkillPointsLeftOver < 0 of
                        True ->
                            ( -3, "Decreased Armor by 3 for an extra Skill Point." )

                        False ->
                            ( 0, "" )

        _ =
            Debug.log "strSkillArmor" strSkillArmor
        iArmor =
            iMetatypeArmor + 9 + iSkillArmor
    in
        div [ class "armor" ] [ text <| toString iArmor ]
        
