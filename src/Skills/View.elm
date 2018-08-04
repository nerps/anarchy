module Skills.View exposing (..)

import Html exposing (Html, div, text, program, button, label, input, fieldset)
import Html.Attributes exposing (id, type_, for, value, class, form, placeholder, style, name, checked, readonly)
import Html.Events exposing (..)
import Messages exposing (..)
import Skills.Types exposing (..)
import Skills.Init exposing (availableSkills, initSkillSelectizeStateIfNecessary, initSkillSpecSelectizeStateIfNecessary)
import Attributes.Types exposing (..)
import Selectize
import MySelectize exposing (viewConfig)


skillPointsSpinner : String -> Int -> Int -> Html Msg
skillPointsSpinner uid_skill skillMaximum points =
    input
        [ type_ "number"
        , onInput (OnSkillPointsInputChanged uid_skill)
        , value (points |> toString)
        , Html.Attributes.min (0 |> toString)
        , Html.Attributes.max (skillMaximum |> toString)
        ]
        []


selectViewSkill : String -> Maybe Skill -> Selectize.State Skill -> (Skill -> String) -> String -> Html Msg
selectViewSkill uid_skill selection menuState toString placeholder =
    Selectize.view
        (MySelectize.viewConfig toString
            placeholder
        )
        selection
        menuState
        |> Html.map (\x -> SkillMenuMsg uid_skill x)


selectViewSkillSpec : String -> Maybe SkillSpec -> Selectize.State SkillSpec -> (SkillSpec -> String) -> String -> Html Msg
selectViewSkillSpec uid_skill selection menuState toString placeholder =
    Selectize.view
        (MySelectize.viewConfig toString
            placeholder
        )
        selection
        menuState
        |> Html.map (\x -> SkillSpecMenuMsg (uid_skill ++ "__spec") x)


knowledgeSkillView : String -> Html Msg
knowledgeSkillView strKnowledgeSkill =
    div [ class "col-4" ]
        [ div [ class "skill-select" ]
            [ input [ class "form-control", type_ "text", onInput SetKnowledgeSkill, value strKnowledgeSkill ] []
            ]
        , div [ class "skill-points" ] []
        , div [ class "skill-attribute" ] [ text "(K)" ]
        ]


skillSelectView : Maybe ( String, Selectize.State Skill ) -> Maybe ( String, Selectize.State SkillSpec ) -> Int -> ( String, ( Maybe Skill, Maybe SkillSpec, Int ) ) -> Html Msg
skillSelectView skillSelectizeStateMaybe skillSpecSelectizeStateMaybe skillMaximum ( uid_skill, ( skillMaybe, skillSpecMaybe, points ) ) =
    let
        mySkillSelectizeState =
            initSkillSelectizeStateIfNecessary uid_skill skillSelectizeStateMaybe
    in
        case skillMaybe of
            Nothing ->
                div [ class "col-4" ]
                    [ div [ class "skill-select" ]
                        [ selectViewSkill uid_skill skillMaybe mySkillSelectizeState (.name) "Select a skill"
                        ]
                    , div [ class "skill-points" ] []
                    , div [ class "skill-attribute" ] []
                    ]

            Just skill ->
                let
                    mySkillSpecSelectizeState =
                        initSkillSpecSelectizeStateIfNecessary uid_skill skill.specialisations skillSpecSelectizeStateMaybe
                in
                    {- case isKnowledgeSkill of
                       True ->
                           --for a knowledge skill, just type in something
                           div [ class "col-4" ]
                               [ div [  ]
                                   [  input [ class "form-control", type_ "text", onInput (\inp -> SelectSkill "s6" (Just (Skill ))), value q.title ] []
                                   ]
                               , div [ class "skill-points" ] []
                               , div [ class "skill-attribute" ] [ text "(K)" ]
                               ]
                    -}
                    --normal skill
                    case List.length skill.specialisations == 0 of
                        True ->
                            --no specialisations
                            div [ class "col-4" ]
                                [ div [ class "skill-select" ]
                                    [ selectViewSkill uid_skill skillMaybe mySkillSelectizeState (.name) "invalid"
                                    ]
                                , div [ class "skill-points" ] [ skillPointsSpinner uid_skill skillMaximum points ]
                                , div [ class "skill-attribute" ] [ skillPlusAttributeText skillMaybe ]
                                ]

                        False ->
                            --normal skill with possible specialisation
                            div [ class "col-4" ]
                                [ div [ class "skill-select" ]
                                    [ selectViewSkill uid_skill skillMaybe mySkillSelectizeState (.name) "invalid"
                                    , selectViewSkillSpec uid_skill skillSpecMaybe mySkillSpecSelectizeState identity "Select a spec"
                                    ]
                                , div [ class "skill-points" ] [ skillPointsSpinner uid_skill skillMaximum points ]
                                , div [ class "skill-attribute" ] [ skillPlusAttributeText skillMaybe ]
                                ]


skillPlusAttributeText : Maybe Skill -> Html Msg
skillPlusAttributeText maybeSkill =
    case maybeSkill of
        Just skill ->
            div [] [ text ("+" ++ (attributeIDtoString skill.attribute)) ]

        Nothing ->
            div [] [ text "*+Attrib*" ]
