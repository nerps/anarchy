module Main exposing (..)

import RouteUrl exposing (RouteUrlProgram)
import Model exposing (Model)
import Messages exposing (Msg)
import App.View exposing (view)
import App.Update exposing (update)
import App.Init exposing (init)
import App.Url exposing (delta2url, location2messages)


-- MAIN


main : RouteUrlProgram Never Model Msg
main =
    RouteUrl.program
        { delta2url = delta2url
        , location2messages = location2messages
        , init = init
        , update = update
        , view = view
        , subscriptions = (\model -> Sub.none)
        }
