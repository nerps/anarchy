module Amps.Update exposing (..)

import Dict
import Selectize
import Messages exposing (..)
import Amps.Types exposing (Amp, AmpType)
import Model exposing (Model)


handleAmpMenuMsg :
    Model
    -> String
    -> Selectize.Msg Amp
    -> ( Maybe Msg, Model, Cmd Msg )
handleAmpMenuMsg model uid_amp selectizeMsg =
    let
        oldSelectizeState =
            model.selectizeMenuAmp

        oldSelectizeSelection : Maybe Amp
        oldSelectizeSelection =
            Dict.get uid_amp model.selectedAmps
                |> Maybe.withDefault Nothing

        ( newMenu, menuCmd, maybeMsg ) =
            Selectize.update (SelectAmp uid_amp)
                oldSelectizeSelection
                oldSelectizeState
                (selectizeMsg)

        newModel =
            { model | selectizeMenuAmp = newMenu }

        cmd =
            menuCmd |> Cmd.map (AmpMenuMsg uid_amp)
    in
        ( maybeMsg, newModel, cmd )


handleAmpTypeMenuMsg :
    Model
    -> String
    -> Selectize.Msg AmpType
    -> ( Maybe Msg, Model, Cmd Msg )
handleAmpTypeMenuMsg model uid_amp selectizeMsg =
    let
        oldSelectizeState =
            model.selectizeMenuAmpType

        oldSelectizeSelection : Maybe AmpType
        oldSelectizeSelection =
            Dict.get uid_amp model.selectedAmps
                |> Maybe.withDefault Nothing
                |> Maybe.andThen (\amp -> Just amp.amptype)

        ( newMenu, menuCmd, maybeMsg ) =
            Selectize.update (SelectAmpType uid_amp)
                oldSelectizeSelection
                oldSelectizeState
                (selectizeMsg)

        newModel =
            { model | selectizeMenuAmpType = newMenu }

        cmd =
            menuCmd |> Cmd.map (AmpTypeMenuMsg uid_amp)
    in
        ( maybeMsg, newModel, cmd )
