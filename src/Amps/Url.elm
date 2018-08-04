module Amps.Url exposing (state2query, builder2messages)

import Dict
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)
import Amps.Init exposing (initAmps)
import Amps.Types exposing (Amp, ampTypeToString, stringToAmpType)
import Helpers exposing (strToMaybeFloat, strToMaybeInt)


state2query : Dict.Dict String (Maybe Amp) -> List ( String, String )
state2query amps =
    let
        list : List ( String, Maybe Amp )
        list =
            Dict.toList amps

        -- replace ";"
        replaceInvalidChar a =
            String.split ";" a |> String.join ""

        ampToString : ( String, Maybe Amp ) -> ( String, String )
        ampToString ( a, maybeAmp ) =
            case maybeAmp of
                Nothing ->
                    ( a, "" )

                Just amp ->
                    ( a
                    , (replaceInvalidChar amp.name)
                        ++ ";"
                        ++ (replaceInvalidChar amp.description)
                        ++ ";"
                        ++ (toString amp.essenceCost)
                        ++ ";"
                        ++ (toString amp.points)
                        ++ ";"
                        ++ (ampTypeToString amp.amptype)
                    )
    in
        List.map ampToString list


builder2messages : Builder -> List Msg
builder2messages builder =
    initAmps
        |> Dict.keys
        |> List.map (parse2Messages builder)
        |> List.concat


parse2Messages : Builder -> String -> List Msg
parse2Messages builder uid_amp =
    let
        strQueryParameter =
            getQuery uid_amp builder
                |> List.head
                |> Maybe.withDefault ""
    in
        case String.split ";" strQueryParameter of
            strName :: strDescription :: strEssenceCost :: strPoints :: strAmpType :: _ ->
                let
                    fEssenceCost =
                        strToMaybeFloat strEssenceCost

                    iPoints =
                        strToMaybeInt strPoints

                    ampType =
                        stringToAmpType strAmpType
                in
                    case fEssenceCost of
                        Nothing ->
                            []

                        Just essenceCost ->
                            case iPoints of
                                Nothing ->
                                    []

                                Just points ->
                                    [ SelectAmp uid_amp (Just (Amp ampType points essenceCost strName strDescription)) ]

            _ ->
                []
