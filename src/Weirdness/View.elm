module Weirdness.View exposing (..)

import Html exposing (Html, div, input, text, label)
import Html.Attributes exposing (type_, for, value, class, style, readonly, checked)
import Html.Events exposing (..)
import Messages exposing (..)
import Weirdness.Types exposing (..)


weirdnessInput : Weirdness -> Html Msg
weirdnessInput weirdness =
    let
        toggleWeirdness w checked =
            case checked of
                True ->
                    Mundane

                False ->
                    w
    in
        div [ class "col" ]
            [ label []
                [ input
                    [ type_ "checkbox"
                    , readonly True
                    , checked (weirdness == Emerged)
                    , onClick (OnWeirdnessChanged (toggleWeirdness Emerged (weirdness == Emerged)))
                    ]
                    []
                , text "Emerged"
                ]
            , label []
                [ input
                    [ type_ "checkbox"
                    , readonly True
                    , checked (weirdness == Awakened)
                    , onClick (OnWeirdnessChanged (toggleWeirdness Awakened (weirdness == Awakened)))
                    ]
                    []
                , text "Awakened"
                ]
            ]
