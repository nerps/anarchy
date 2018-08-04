module Dispositions.Init exposing (..)

import Dict


initDispositions : Dict.Dict String String
initDispositions =
    [ "d1", "d2", "d3", "d4" ]
        |> List.map (\k -> ( k, "" ))
        |> Dict.fromList
