module GameLevel.View exposing (view)

import Html exposing (Html, div, label, input, text, fieldset)
import Html.Attributes exposing (type_, for, value, class, style, name, id)
import Html.Events exposing (..)
import Messages exposing (..)
import GameLevel.Types exposing (GameLevel)
import GameLevel.Init exposing (gameLevels)


view : GameLevel -> Html Msg
view currentGameLevel =
    let
        radioList =
            List.map (\gl -> radio gl.name (currentGameLevel == gl) (SetGameLevel gl)) gameLevels

        withLegend =
            Html.legend [] [ text "Game Level" ] :: radioList
    in
        div []
            [ fieldset [ id "gamelevel" ]
                withLegend
            ]


radio : String -> Bool -> Msg -> Html Msg
radio value checked msg =
    label
        [ style [ ( "padding", "0 1em 0 0" ) ]
        ]
        [ input [ type_ "radio", name "gamelevel", Html.Attributes.checked checked, onClick msg ] []
        , text value
        ]
