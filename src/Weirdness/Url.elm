module Weirdness.Url exposing (state2query, builder2messages)

import Weirdness.Types exposing (..)
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)


state2query : Weirdness -> List ( String, String )
state2query weirdness =
    let
        str =
            case weirdness of
                Mundane ->
                    "M"

                Awakened ->
                    "A"

                Emerged ->
                    "E"
    in
        ( "w", str ) |> List.singleton


builder2messages : Builder -> List Msg
builder2messages builder =
    let
        str =
            getQuery "w" builder
                |> List.head
                |> Maybe.withDefault "M"
    in
        case str of
            "M" ->
                [ OnWeirdnessChanged Mundane ]

            "A" ->
                [ OnWeirdnessChanged Awakened ]

            "E" ->
                [ OnWeirdnessChanged Emerged ]

            _ ->
                []
