module Qualities.View exposing (..)

import Html exposing (Html, div, text, program, button, label, input, fieldset)
import Html.Attributes exposing (id, type_, for, value, class, form, placeholder, style, name, checked, readonly)
import Html.Events exposing (..)
import Qualities.Types exposing (Quality)
import Weirdness.Types exposing (Weirdness)
import Bootstrap.Modal as Modal
import Dict
import Messages exposing (..)
import Selectize
import MySelectize exposing (viewConfig)
import Bootstrap.Button as Button
import Attributes.Types exposing (..)
import Helpers exposing (strToMaybeInt, strToMaybeFloat)


view : Dict.Dict String (Maybe Quality) -> Html Msg
view selectedQualities =
    let
        views =
            selectedQualities |> Dict.toList |> List.map (\( k, v ) -> buttonView k v)
    in
        div []
            [ div [] [ text "QUALITIES" ]
            , div [ class "row" ]
                views
            ]


buttonView : String -> Maybe Quality -> Html Msg
buttonView uid_quality maybeQuality =
    let
        qualityText =
            case maybeQuality of
                Just quality ->
                    div [ style [ ( "flex", "1 1 auto" ) ] ]
                        [ div [ style [ ( "font-weight", "bolder" ) ] ] [ text quality.title ]
                        , div [ style [ ( "font-style", "italic" ) ] ] [ text quality.text ]
                        ]

                Nothing ->
                    div [ style [ ( "font-style", "italic" ), ( "flex", "1 0 auto" ) ] ] [ text "Select a quality" ]

        isNegativeQuality =
            String.endsWith "n" uid_quality

        dashedBorderStyle =
            case isNegativeQuality of
                True ->
                    [ ( "border-style", "dashed" ) ]

                False ->
                    []
    in
        div
            [ class "col-12 col-xs-12 col-sm-6 col-md-4 col-lg-4" ]
            [ div [ class "ampButton", onClick <| QualityModalMsg uid_quality Modal.visibleState, style dashedBorderStyle ] [ qualityText ] ]


modalView : String -> Modal.State -> Dict.Dict String (Maybe Quality) -> Selectize.State Quality -> Weirdness -> Html Msg
modalView uid_quality state selectedQualities selectizeMenuQuality weirdness =
    let
        header =
            case selectedQuality of
                Nothing ->
                    "Choose a Quality"

                Just _ ->
                    "QUALITY EDITOR"

        selectedQuality =
            Dict.get uid_quality selectedQualities
                |> Maybe.withDefault Nothing

        content =
            qualityChangeView uid_quality selectedQuality weirdness selectizeMenuQuality
    in
        Modal.config (QualityModalMsg uid_quality)
            |> Modal.large
            |> Modal.h3 [] [ text header ]
            |> Modal.body [] [ Html.p [] [ content ] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick <| QualityModalMsg "HIDE MODAL" Modal.hiddenState ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view state


qualityChangeView : String -> Maybe Quality -> Weirdness -> Selectize.State Quality -> Html Msg
qualityChangeView uid_quality selectedQuality weirdness qualitySelectizeState =
    let
        editor =
            case selectedQuality of
                Nothing ->
                    -- no quality selected
                    div [] []

                Just quality ->
                    qualityEditor uid_quality quality qualitySelectizeState
    in
        div [ class "col-12", style [ ( "overflow", "auto" ), ( "height", "50vh" ) ] ]
            [ div [ class "selectize-select" ]
                [ selectViewQuality uid_quality selectedQuality qualitySelectizeState (.title) "Select a Quality"
                ]
            , editor
            ]


qualityEditor : String -> Quality -> Selectize.State Quality -> Html Msg
qualityEditor uid_quality q selStateQuality =
    div []
        [ div []
            [ label [] [ text "Title" ]
            , input [ class "form-control", type_ "text", onInput (\inp -> SelectQuality uid_quality (Just { q | title = inp })), value q.title ] []
            ]
        , div []
            [ label [] [ text "Description" ]
            , input [ class "form-control", type_ "text", onInput (\inp -> SelectQuality uid_quality (Just { q | text = inp })), value q.text ] []
            ]
        , div []
            [ label [] [ text "Modify Attributes" ]
            , attributeChangeView q.modifyAttribute (\attrib -> SelectQuality uid_quality (Just { q | modifyAttribute = attrib }))
            ]
        , div []
            [ label [] [ text "Modify Attribute Caps" ]
            , attributeChangeView q.modifyAttributeMaximum (\attrib -> SelectQuality uid_quality (Just { q | modifyAttributeMaximum = attrib }))
            ]
        , div []
            [ label [] [ text "Ignore Essence Loss from Amps" ]
            , input
                [ class "form-control"
                , type_ "number"
                , onInput
                    (\inp ->
                        case (strToMaybeInt inp) of
                            Nothing ->
                                --no change
                                SelectQuality uid_quality (Just q)

                            Just val ->
                                --set new int value
                                SelectQuality uid_quality (Just { q | ignoreEssenceLossOnShadowAmps = val })
                    )
                , value (q.ignoreEssenceLossOnShadowAmps |> toString)
                ]
                []
            ]
        , div []
            [ label [] [ text "Modify Condition Monitor (Physical)" ]
            , input
                [ class "form-control"
                , type_ "number"
                , onInput
                    (\inp ->
                        case (strToMaybeInt inp) of
                            Nothing ->
                                --no change
                                SelectQuality uid_quality (Just q)

                            Just val ->
                                --set new int value
                                SelectQuality uid_quality (Just { q | modifyConditionMonitorPhysical = val })
                    )
                , value (q.modifyConditionMonitorPhysical |> toString)
                ]
                []
            ]
        , div []
            [ label [] [ text "Modify Condition Monitor (Stun)" ]
            , input
                [ class "form-control"
                , type_ "number"
                , onInput
                    (\inp ->
                        case (strToMaybeInt inp) of
                            Nothing ->
                                --no change
                                SelectQuality uid_quality (Just q)

                            Just val ->
                                --set new int value
                                SelectQuality uid_quality (Just { q | modifyConditionMonitorStun = val })
                    )
                , value (q.modifyConditionMonitorStun |> toString)
                ]
                []
            ]
        ]


attributeChangeView : Attributes -> (Attributes -> Msg) -> Html Msg
attributeChangeView att updateMsg =
    let
        somelist =
            [ Strength, Agility, Willpower, Logic, Charisma, Edge ]
                |> List.map
                    (\aID ->
                        div [ class "form-group row" ]
                            [ label [ class "col-sm-2 col-form-label" ] [ text (attributeIDtoString aID) ]
                            , div [ class "col-sm-10" ]
                                [ input [ class "form-control", type_ "number", value (toString (attributeGetters aID att)) ] []
                                ]
                            ]
                    )
    in
        div []
            somelist


selectViewQuality : String -> Maybe Quality -> Selectize.State Quality -> (Quality -> String) -> String -> Html Msg
selectViewQuality uid_quality selection menuState toString placeholder =
    Selectize.view
        (MySelectize.viewConfig toString
            placeholder
        )
        selection
        menuState
        |> Html.map (\x -> QualityMenuMsg uid_quality x)
