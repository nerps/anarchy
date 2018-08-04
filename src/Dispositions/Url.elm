module Dispositions.Url exposing (state2query, builder2messages)

import Dict
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)
import Dispositions.Init exposing (initDispositions)


state2query : Dict.Dict String String -> List ( String, String )
state2query dispostions =
    Dict.toList dispostions


builder2messages : Builder -> List Msg
builder2messages builder =
    let
        parse2Message : Builder -> String -> Msg
        parse2Message builder id =
            getQuery id builder |> List.head |> Maybe.withDefault "" |> OnDispositionInputChanged id
    in
        initDispositions
            |> Dict.keys
            |> List.map (parse2Message builder)
