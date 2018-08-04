module Metatypes.Url exposing (state2query, builder2messages)

import Metatypes.Types exposing (..)
import Metatypes.Init exposing (..)
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)


state2query : Metatype -> List ( String, String )
state2query metatype =
    ( "m", metatype.name ) |> List.singleton


builder2messages : Builder -> List Msg
builder2messages builder =
    getQuery "m" builder
        |> List.head
        |> Maybe.withDefault "Human"
        |> (\name -> List.filter (\m -> m.name == name) Metatypes.Init.metatypes)
        |> List.head
        |> Maybe.withDefault Metatypes.Init.human
        |> SetMetatype
        |> List.singleton
