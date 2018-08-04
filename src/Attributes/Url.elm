module Attributes.Url exposing (state2query, builder2messages)

import Attributes.Types exposing (..)
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)


state2query : Attributes -> List ( String, String )
state2query at =
    ( "at"
    , toString at.strength ++ "." ++ toString at.agility ++ "." ++ toString at.willpower ++ "." ++ toString at.logic ++ "." ++ toString at.charisma
    )
        |> List.singleton


builder2messages : Builder -> List Msg
builder2messages builder =
    let
        attributeList2message : List Int -> List Msg
        attributeList2message v =
            case v of
                s :: a :: w :: l :: c :: [] ->
                    [ SetAttributes (Attributes s a w l c 0) ]

                _ ->
                    []
    in
        getQuery "at" builder
            |> List.head
            |> Maybe.withDefault "0.0.0.0.0"
            |> String.split "."
            |> List.map (\s -> Result.withDefault 0 (String.toInt s))
            |> attributeList2message
