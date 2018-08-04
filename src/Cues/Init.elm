module Cues.Init exposing (..)

import Dict


initCues : Dict.Dict String String
initCues =
    [ "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10" ]
        |> List.map (\k -> ( k, "" ))
        |> Dict.fromList
