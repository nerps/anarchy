module Amps.View exposing (view, ampModalView)

import Amps.Types exposing (Amp, AmpType, getEssenceCost, getPointsText, ampTypeToString, getDescription)
import Dict
import Messages exposing (..)
import Weirdness.Types exposing (Weirdness)
import Html exposing (Html, div, text, button, input, label)
import Html.Attributes exposing (id, type_, for, value, class, form, placeholder, style, name, checked, readonly)
import Html.Events exposing (..)
import Bootstrap.Modal as Modal
import Selectize
import MySelectize exposing (viewConfig)
import Bootstrap.Button as Button
import Qualities.Types exposing (Quality)
import Helpers exposing (strToMaybeInt, strToMaybeFloat)
import Round


view : Dict.Dict String (Maybe Amp) -> Dict.Dict String (Maybe Quality) -> Html Msg
view selectedAmps qualities =
    let
        views =
            selectedAmps
                |> Dict.toList
                |> List.map (\( k, v ) -> ampButtonView k v)

        essenceCostIgnore =
            qualities |> Dict.values |> List.map (Maybe.andThen (\q -> Just q.ignoreEssenceLossOnShadowAmps)) |> List.map (Maybe.withDefault 0) |> List.sum |> toFloat

        essenceLeft =
            min 6.0 (6.0 - essenceCost + essenceCostIgnore)

        essenceCost =
            selectedAmps |> Dict.toList |> List.map (\( _, maybeAmp ) -> getEssenceCost maybeAmp) |> List.sum

        essenceEffects =
            case essenceLeft >= 5.0 of
                True ->
                    "No negative effect"

                False ->
                    case essenceLeft >= 3.0 of
                        True ->
                            "-1 die to magic/healing tests."

                        False ->
                            case essenceLeft >= 1.0 of
                                True ->
                                    "-2 dice to magic/healing tests."

                                False ->
                                    case essenceLeft > 0.0 of
                                        True ->
                                            "-3 dice to magic/healing tests. Cyberzombie."

                                        False ->
                                            "He's dead, Jim."
    in
        div []
            [ div [] [ text ("Essence: " ++ toString essenceLeft) ]
            , div [] [ text essenceEffects ]
            , div [ class "row equal" ] views
            ]


ampButtonView : String -> Maybe Amp -> Html Msg
ampButtonView uid_amp selectedAmp =
    let
        shadowampText =
            case selectedAmp of
                Just actualAmp ->
                    div [ style [ ( "width", "100%" ) ] ]
                        [ div [ style [ ( "font-weight", "bolder" ) ] ] [ text actualAmp.name ]
                        , div [ style [ ( "font-style", "italic" ) ] ] [ (Just actualAmp) |> getDescription |> text ]
                        ]

                Nothing ->
                    div [ style [ ( "font-style", "italic" ), ( "flex", "1 0 auto" ) ] ] [ text "Select a shadowamp" ]

        shadowampCost =
            div [ class "ampPoints" ] [ getPointsText selectedAmp |> text ]
    in
        div
            [ class "col-12 col-xs-12 col-sm-6 col-md-4 col-lg-4" ]
            [ div [ class "ampButton", onClick <| AmpModalMsg uid_amp Modal.visibleState ] [ shadowampCost, shadowampText ] ]


ampModalView : String -> Modal.State -> Dict.Dict String (Maybe Amp) -> Selectize.State Amp -> Selectize.State AmpType -> Weirdness -> Html Msg
ampModalView uid_amp state selectedAmps selStateAmp selStateAmpType weirdness =
    let
        header =
            case selectedAmp of
                Nothing ->
                    "Choose an AMP"

                Just _ ->
                    "AMP EDITOR"

        selectedAmp =
            Dict.get uid_amp selectedAmps
                |> Maybe.withDefault Nothing

        content =
            ampModalContentView uid_amp selectedAmp weirdness selStateAmp selStateAmpType
    in
        Modal.config (AmpModalMsg uid_amp)
            |> Modal.large
            |> Modal.h3 [] [ text header ]
            |> Modal.body [] [ Html.p [] [ content ] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick <| AmpModalMsg "HIDE MODAL" Modal.hiddenState ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view state


ampModalContentView : String -> Maybe Amp -> Weirdness -> Selectize.State Amp -> Selectize.State AmpType -> Html Msg
ampModalContentView uid_amp selectedAmp weirdness selStateAmp selStateAmpType =
    let
        valueName =
            selectedAmp
                |> Maybe.andThen (\a -> Just a.name)
                |> Maybe.withDefault ""

        editorOrFilter =
            case selectedAmp of
                Nothing ->
                    --no amp selected -> show amp-dropdown-filter
                    div []
                        [--label [] [ text "filter" ]
                         --, filterAmpTypeView filteredAmpTypes selStateFilterAmpType (ampTypeToString) "Filter Amp Types"
                        ]

                Just amp ->
                    --selected amp -> show ampEditor
                    ampEditor uid_amp amp selStateAmpType
    in
        div [ class "col-12" ]
            [ div [ class "selectize-select" ]
                [ selectViewAmp uid_amp selectedAmp selStateAmp (.name) "Select an Amp"
                ]
            , div [ style [ ( "font-style", "italic" ) ] ] [ selectedAmp |> getDescription |> text ]
            , editorOrFilter
            ]


ampEditor : String -> Amp -> Selectize.State AmpType -> Html Msg
ampEditor uid_amp amp selStateAmpType =
    let
        pointMsg =
            (\inp ->
                case (strToMaybeInt inp) of
                    Nothing ->
                        SelectAmp uid_amp (Just amp)

                    Just intValue ->
                        SelectAmp uid_amp (Just { amp | points = intValue })
            )

        essenceMsg =
            (\inp ->
                case (strToMaybeFloat inp) of
                    Nothing ->
                        SelectAmp uid_amp (Just amp)

                    Just floatValue ->
                        SelectAmp uid_amp (Just { amp | essenceCost = floatValue })
            )
    in
        div []
            [ div []
                [ label [] [ text "Name" ]
                , input [ class "form-control", type_ "text", onInput (\inp -> SelectAmp uid_amp (Just { amp | name = inp })), value amp.name ] []
                ]
            , div []
                [ label [] [ text "Description" ]
                , input [ class "form-control", type_ "text", onInput (\inp -> SelectAmp uid_amp (Just { amp | description = inp })), value amp.description ] []
                ]
            , div []
                [ label [] [ text "Points" ]
                , input [ class "form-control", type_ "text", onInput pointMsg, value (toString amp.points) ] []
                ]
            , div []
                [ label [] [ text "Essence Cost" ]
                , input [ class "form-control", type_ "text", onInput essenceMsg, value (Round.round 1 amp.essenceCost) ] []
                ]
            , div []
                [ label [] [ text "Type" ]
                , div [ class "selectize-select" ]
                    [ selectViewAmpType uid_amp (Just amp.amptype) selStateAmpType (ampTypeToString) "Select an Amp Type"
                    ]
                ]
            ]


selectViewAmp : String -> Maybe Amp -> Selectize.State Amp -> (Amp -> String) -> String -> Html Msg
selectViewAmp uid_amp selection menuState toString placeholder =
    Selectize.view
        (MySelectize.viewConfig toString
            placeholder
        )
        selection
        menuState
        |> Html.map (\x -> AmpMenuMsg uid_amp x)


selectViewAmpType : String -> Maybe AmpType -> Selectize.State AmpType -> (AmpType -> String) -> String -> Html Msg
selectViewAmpType uid_amp selection menuState toString placeholder =
    Selectize.view
        (MySelectize.viewConfig toString
            placeholder
        )
        selection
        menuState
        |> Html.map (\x -> AmpTypeMenuMsg uid_amp x)
