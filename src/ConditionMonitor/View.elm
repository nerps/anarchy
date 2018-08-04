module ConditionMonitor.View exposing (conditionMonitorPhysical, conditionMonitorStun)

import Attributes.Types exposing (..)
import Html exposing (Html, div, text, label, input)
import Messages exposing (Msg)
import Dict
import List
import Qualities.Types exposing (Quality)


conditionMonitorPhysical : Attributes -> Attributes -> Dict.Dict String (Maybe Quality) -> Html Msg
conditionMonitorPhysical attributes attributeModifiers qualities =
    let
        getStrength =
            attributeGetters Strength

        strength =
            (attributes |> getStrength) + (attributeModifiers |> getStrength)

        value =
            -- add 1 b/c integer division rounds down
            8 + (1 + strength) // 2 + conditionModifier

        conditionModifier : Int
        conditionModifier =
            Dict.toList qualities
                |> List.map (\( _, maybeQuality ) -> maybeQuality)
                |> List.map (Maybe.andThen (\mq -> Just mq.modifyConditionMonitorPhysical))
                |> List.map (Maybe.withDefault 0)
                |> List.sum
    in
        text (toString value)


conditionMonitorStun : Attributes -> Attributes -> Dict.Dict String (Maybe Quality) -> Html Msg
conditionMonitorStun attributes attributeModifiers qualities =
    let
        getWillpower =
            attributeGetters Willpower

        willpower =
            (attributes |> getWillpower) + (attributeModifiers |> getWillpower)

        value =
            -- add 1 b/c integer division rounds down
            8 + (1 + willpower) // 2 + conditionModifier

        conditionModifier : Int
        conditionModifier =
            Dict.toList qualities
                |> List.map (\( _, maybeQuality ) -> maybeQuality)
                |> List.map (Maybe.andThen (\mq -> Just mq.modifyConditionMonitorStun))
                |> List.map (Maybe.withDefault 0)
                |> List.sum
    in
        text (toString value)
