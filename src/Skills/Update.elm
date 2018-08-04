module Skills.Update exposing (..)

import Dict
import Selectize
import Messages exposing (..)
import Skills.Types exposing (Skill, SkillSpec)
import Skills.Init exposing (defaultSkill, initSkillSelectizeStateIfNecessary, initSkillSpecSelectizeStateIfNecessary)
import Model exposing (Model)
import Helpers exposing (strToMaybeInt)


handleOnSkillPointsInputChanged : Model -> String -> String -> ( Model, Cmd Msg )
handleOnSkillPointsInputChanged model uid_skill strPoints =
    let
        points =
            strPoints
                |> strToMaybeInt
                |> Maybe.withDefault 0

        ( selectedSkill, selectedSpec, _ ) =
            skillFromUniqueID model.selectedSkills uid_skill

        maybeSelectedSpec =
            --use Nothing if no spec was selected
            case selectedSpec == "" of
                True ->
                    Nothing

                False ->
                    Just selectedSpec

        newSelectedSkills =
            Dict.insert uid_skill ( Just selectedSkill, maybeSelectedSpec, points ) model.selectedSkills
    in
        ( { model | selectedSkills = newSelectedSkills }, Cmd.none )


handleSkillMenuMsg :
    Model
    -> String
    -> Selectize.Msg Skill
    -> ( Maybe Msg, Model, Cmd Msg )
handleSkillMenuMsg model uid_skill selectizeMsg =
    let
        oldSelectizeState =
            initSkillSelectizeStateIfNecessary uid_skill model.selectizeMenu

        ( oldSelectizeSelection, _, _ ) =
            Dict.get uid_skill model.selectedSkills
                |> Maybe.withDefault ( Nothing, Nothing, 0 )

        ( newMenu, menuCmd, maybeMsg ) =
            Selectize.update (SelectSkill uid_skill)
                oldSelectizeSelection
                oldSelectizeState
                (selectizeMsg)

        newModel =
            { model | selectizeMenu = Just ( uid_skill, newMenu ), selectizeMenuSkillSpec = Nothing }

        cmd =
            menuCmd |> Cmd.map (SkillMenuMsg uid_skill)
    in
        ( maybeMsg, newModel, cmd )


handleSkillSpecMenuMsg :
    Model
    -> String
    -> Selectize.Msg SkillSpec
    -> ( Maybe Msg, Model, Cmd Msg )
handleSkillSpecMenuMsg model uid_spec selectizeMsg =
    let
        -- drop "__spec"
        uid_skill =
            String.dropRight 6 uid_spec

        ( skill, _, _ ) =
            skillFromUniqueID model.selectedSkills uid_skill

        availableSkillSpecs =
            skill.specialisations

        oldSelectizeState =
            initSkillSpecSelectizeStateIfNecessary uid_skill availableSkillSpecs model.selectizeMenuSkillSpec

        ( _, oldSelectizeSelection, _ ) =
            Dict.get uid_skill model.selectedSkills
                |> Maybe.withDefault ( Nothing, Nothing, 0 )

        ( newMenu, menuCmd, maybeMsg ) =
            Selectize.update (SelectSkillSpec uid_skill)
                oldSelectizeSelection
                oldSelectizeState
                (selectizeMsg)

        newModel =
            { model | selectizeMenuSkillSpec = Just ( uid_spec, newMenu ) }

        cmd =
            menuCmd |> Cmd.map (SkillSpecMenuMsg uid_spec)
    in
        ( maybeMsg, newModel, cmd )


skillFromUniqueID : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> String -> ( Skill, SkillSpec, Int )
skillFromUniqueID selectedSkills uid_skill =
    let
        maybeOfMaybes =
            Dict.get uid_skill selectedSkills
    in
        case maybeOfMaybes of
            Nothing ->
                ( defaultSkill, (""), 0 )

            Just ( maybeSkill, maybeSkillSpec, points ) ->
                ( maybeSkill |> Maybe.withDefault defaultSkill, maybeSkillSpec |> Maybe.withDefault "", points )


handleSelectSkill : Model -> String -> Maybe Skill -> ( Model, Cmd Msg )
handleSelectSkill model uid_skill newSelectionMaybe =
    let
        zeroOrOne =
            case newSelectionMaybe of
                Nothing ->
                    0

                Just _ ->
                    1
    in
        ( { model
            | selectedSkills =
                Dict.insert uid_skill ( newSelectionMaybe, Nothing, zeroOrOne ) model.selectedSkills
          }
        , Cmd.none
        )
