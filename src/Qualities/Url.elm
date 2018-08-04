module Qualities.Url exposing (state2query, builder2messages)

import Dict
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)
import Qualities.Init exposing (initQualities)
import Qualities.Types exposing (Quality)
import Attributes.Types exposing (Attributes)
import Helpers exposing (strToMaybeInt)


state2query : Dict.Dict String (Maybe Quality) -> List ( String, String )
state2query qualities =
    let
        qualityToString : ( String, Maybe Quality ) -> ( String, String )
        qualityToString ( q, maybeQuality ) =
            case maybeQuality of
                Nothing ->
                    -- no quality to encode
                    ( q, "" )

                Just qy ->
                    -- encode quality as a string
                    ( q
                    , qy.title
                        ++ ";"
                        ++ qy.text
                        ++ ";"
                        ++ attributesToString qy.modifyAttribute
                        ++ ";"
                        ++ attributesToString qy.modifyAttributeMaximum
                        ++ ";"
                        ++ toString qy.ignoreEssenceLossOnShadowAmps
                        ++ ";"
                        ++ toString qy.modifyConditionMonitorPhysical
                        ++ ";"
                        ++ toString qy.modifyConditionMonitorStun
                    )
    in
        Dict.toList qualities
            |> List.map qualityToString


builder2messages : Builder -> List Msg
builder2messages builder =
    initQualities
        |> Dict.keys
        |> List.map (parse2Messages builder)
        |> List.concat


attributesToString : Attributes -> String
attributesToString at =
    toString at.strength ++ "." ++ toString at.agility ++ "." ++ toString at.willpower ++ "." ++ toString at.logic ++ "." ++ toString at.charisma ++ "." ++ toString at.edge


stringToAttributes : String -> Attributes
stringToAttributes str =
    String.split "." str
        |> List.map (\s -> Result.withDefault 0 (String.toInt s))
        |> \list ->
            case list of
                s :: a :: w :: l :: c :: e :: [] ->
                    (Attributes s a w l c e)

                _ ->
                    Attributes 0 0 0 0 0 0


parse2Messages : Builder -> String -> List Msg
parse2Messages builder uid_quality =
    let
        strQueryParameter : String
        strQueryParameter =
            getQuery uid_quality builder
                |> List.head
                |> Maybe.withDefault ""
    in
        case String.split ";" strQueryParameter of
            strTitle :: strText :: strMA :: strMACap :: strEC :: strMCMPhysical :: strMCMStun :: _ ->
                [ SelectQuality uid_quality
                    (Just
                        (Quality
                            strTitle
                            strText
                            (stringToAttributes strMA)
                            (stringToAttributes strMACap)
                            (strToMaybeInt strEC |> Maybe.withDefault 0)
                            (strToMaybeInt strMCMPhysical |> Maybe.withDefault 0)
                            (strToMaybeInt strMCMStun |> Maybe.withDefault 0)
                        )
                    )
                ]

            _ ->
                []
