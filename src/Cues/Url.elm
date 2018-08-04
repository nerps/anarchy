module Cues.Url exposing (state2query, builder2messages)

import Dict
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)
import Cues.Init exposing (initCues)


state2query : Dict.Dict String String -> List ( String, String )
state2query dispostions =
    Dict.toList dispostions


builder2messages : Builder -> List Msg
builder2messages builder =
    let
        parse2Message : Builder -> String -> Msg
        parse2Message builder id =
            getQuery id builder |> List.head |> Maybe.withDefault "" |> OnCueInputChanged id
    in
        initCues
            |> Dict.keys
            |> List.map (parse2Message builder)
