module Qualities.Update exposing (..)

import Dict
import Selectize
import Messages exposing (..)
import Qualities.Types exposing (Quality)
import Model exposing (Model)


handleQualityMenuMsg :
    Model
    -> String
    -> Selectize.Msg Quality
    -> ( Maybe Msg, Model, Cmd Msg )
handleQualityMenuMsg model uid_quality selectizeMsg =
    let
        oldSelectizeState =
            model.selectizeMenuQuality

        oldSelectizeSelection =
            Dict.get uid_quality model.selectedQualities
                |> Maybe.withDefault Nothing

        ( newMenu, menuCmd, maybeMsg ) =
            Selectize.update (SelectQuality uid_quality)
                oldSelectizeSelection
                oldSelectizeState
                (selectizeMsg)

        newModel =
            { model | selectizeMenuQuality = newMenu }

        cmd =
            menuCmd |> Cmd.map (QualityMenuMsg uid_quality)
    in
        ( maybeMsg, newModel, cmd )
