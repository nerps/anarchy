module App.Update exposing (update)

import Model exposing (..)
import Dict
import Messages exposing (..)
import Skills.Update
import Amps.Update
import Attributes.Update
import Qualities.Update
import Qualities.Init


-- red if above maximum
-- yellow if points left to spend
-- red if too many points were spent
-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnNameInputChanged newName ->
            ( { model | name = String.toUpper newName }, Cmd.none )

        OnDispositionInputChanged uid_disposition newValue ->
            ( { model | dispositions = Dict.insert uid_disposition newValue model.dispositions }, Cmd.none )

        OnCueInputChanged uid_cue newValue ->
            ( { model | cues = Dict.insert uid_cue newValue model.cues }, Cmd.none )

        OnWeirdnessChanged newWeirdness ->
            ( { model | weirdness = newWeirdness }, Cmd.none )

        OnAttributeInputChanged aID newStringVal ->
            let
                newAttribs =
                    Attributes.Update.handleAttributeChange model.attributes model.metatype.attributeModifiers aID newStringVal
            in
                ( { model | attributes = newAttribs }, Cmd.none )

        SetGameLevel newGL ->
            ( { model | gameLevel = newGL }, Cmd.none )

        SetMetatype newMetatype ->
            ( { model | metatype = newMetatype }, Cmd.none )

        SetAttributes newAttributes ->
            --for the url parser
            ( { model | attributes = newAttributes }, Cmd.none )

        AmpMenuMsg uid_amp selectizeMsg ->
            --selectize sends this message from the dropdown in the amp-modal
            let
                ( maybeMsg, newModel, cmd ) =
                    Amps.Update.handleAmpMenuMsg model uid_amp selectizeMsg
            in
                case maybeMsg of
                    Just nextMsg ->
                        update nextMsg newModel
                            |> andDo cmd

                    Nothing ->
                        ( newModel, cmd )

        SelectAmp uid_amp newSelectionMaybe ->
            ( { model
                | selectedAmps =
                    Dict.insert uid_amp (newSelectionMaybe) model.selectedAmps
              }
            , Cmd.none
            )

        AmpTypeMenuMsg uid_amp selectizeMsg ->
            --selectize sends this message from the dropdown in the amp-modal
            let
                ( maybeMsg, newModel, cmd ) =
                    Amps.Update.handleAmpTypeMenuMsg model uid_amp selectizeMsg
            in
                case maybeMsg of
                    Just nextMsg ->
                        update nextMsg newModel
                            |> andDo cmd

                    Nothing ->
                        ( newModel, cmd )

        SelectAmpType uid_amp newSelectionMaybe ->
            let
                maybeAmp =
                    case Dict.get uid_amp model.selectedAmps of
                        Nothing ->
                            Nothing

                        Just maybeAmp ->
                            case maybeAmp of
                                Nothing ->
                                    maybeAmp

                                Just amp ->
                                    case newSelectionMaybe of
                                        Nothing ->
                                            Just amp

                                        Just at ->
                                            Just { amp | amptype = at }
            in
                ( { model
                    | selectedAmps =
                        Dict.insert uid_amp (maybeAmp) model.selectedAmps
                  }
                , Cmd.none
                )

        SkillMenuMsg uid_skill selectizeMsg ->
            let
                ( maybeMsg, newModel, cmd ) =
                    Skills.Update.handleSkillMenuMsg model uid_skill selectizeMsg
            in
                case maybeMsg of
                    Just nextMsg ->
                        update nextMsg newModel
                            |> andDo cmd

                    Nothing ->
                        ( newModel, cmd )

        SelectSkill uid_skill newSelectionMaybe ->
            Skills.Update.handleSelectSkill model uid_skill newSelectionMaybe

        SkillSpecMenuMsg uid_spec selectizeMsg ->
            let
                ( maybeMsg, newModel, cmd ) =
                    Skills.Update.handleSkillSpecMenuMsg model uid_spec selectizeMsg
            in
                case maybeMsg of
                    Just nextMsg ->
                        update nextMsg newModel
                            |> andDo cmd

                    Nothing ->
                        ( newModel, cmd )

        SelectSkillSpec uid_skill newSelectionMaybe ->
            let
                ( oldSkillSelection, _, point ) =
                    Skills.Update.skillFromUniqueID model.selectedSkills uid_skill
            in
                ( { model | selectedSkills = Dict.insert uid_skill ( Just oldSkillSelection, newSelectionMaybe, point ) model.selectedSkills }, Cmd.none )

        OnSkillPointsInputChanged uid_skill strPoints ->
            Skills.Update.handleOnSkillPointsInputChanged model uid_skill strPoints

        SetKnowledgeSkill strKnowledgeSkill ->
            ( { model | knowledgeSkill = strKnowledgeSkill }, Cmd.none )

        AmpModalMsg uid_amp state ->
            ( { model | modalUidAmp = uid_amp, modalStateAmp = state }, Cmd.none )

        QualityModalMsg uid_quality state ->
            ( { model | modalUidQuality = uid_quality, modalStateQuality = state, selectizeMenuQuality = Qualities.Init.initQualitySelectizeModel uid_quality }, Cmd.none )

        QualityMenuMsg uid_quality selectizeMsg ->
            let
                ( maybeMsg, newModel, cmd ) =
                    Qualities.Update.handleQualityMenuMsg model uid_quality selectizeMsg
            in
                case maybeMsg of
                    Just nextMsg ->
                        update nextMsg newModel
                            |> andDo cmd

                    Nothing ->
                        ( newModel, cmd )

        SelectQuality uid_quality newSelectionMaybe ->
            ( { model
                | selectedQualities =
                    Dict.insert uid_quality (newSelectionMaybe) model.selectedQualities
              }
            , Cmd.none
            )


andDo : Cmd msg -> ( model, Cmd msg ) -> ( model, Cmd msg )
andDo cmd ( model, cmds ) =
    ( model
    , Cmd.batch [ cmd, cmds ]
    )
