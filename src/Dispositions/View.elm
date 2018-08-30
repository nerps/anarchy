module Dispositions.View exposing (..)

import Dict
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (type_, for, value, class, style)
import Html.Events exposing (..)
import Messages exposing (..)


view : Dict.Dict String String -> Html Msg
view dispositions =
    let
        inputs =
            dispositions
                |> Dict.toList
                |> List.map (\( k, v ) -> div [ class "col-6 dispositionInputContainer" ] [ input [ type_ "text", onInput (OnDispositionInputChanged k), value v, class "dispositionInput" ] [] ])
    in
        div [ class "row dispositions" ] inputs
