module Metatypes.View exposing (metatypeChooser)

import Html exposing (Html, div, text, label, input, fieldset)
import Html.Attributes exposing (id, type_, for, value, class, style, name)
import Html.Events exposing (..)
import Messages exposing (..)
import Metatypes.Types exposing (Metatype)
import Metatypes.Init exposing (metatypes)


metatypeChooser : Metatype -> Html Msg
metatypeChooser currentMetatype =
    let
        radioList =
            List.map (\mt -> radio mt.name (currentMetatype == mt) (SetMetatype mt)) metatypes

        withLegend =
            Html.legend [] [ text "Metatype" ] :: radioList
    in
        div []
            [ fieldset [ id "metatypes" ]
                withLegend
            ]


radio : String -> Bool -> Msg -> Html Msg
radio value checked msg =
    label
        [ style [ ( "padding", "0 1em 0 0" ) ]
        ]
        [ input [ type_ "radio", name "metatypes", Html.Attributes.checked checked, onClick msg ] []
        , text value
        ]
