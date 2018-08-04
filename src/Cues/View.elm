module Cues.View exposing (..)

import Dict
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (type_, for, value, class, style)
import Html.Events exposing (..)
import Messages exposing (..)


view : Dict.Dict String String -> Html Msg
view cues =
    let
        inputs =
            cues
                |> Dict.toList
                |> List.map (\( k, v ) -> div [ class "col-6 dispositionInputContainer" ] [ input [ type_ "text", onInput (OnCueInputChanged k), value v, class "dispositionInput" ] [] ])
    in
        div []
            [ div [ style [ ( "text-align", "center" ) ] ] [ text "Cues" ]
            , div [ class "row" ] inputs
            ]
