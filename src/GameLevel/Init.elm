module GameLevel.Init exposing (..)

import GameLevel.Types exposing (GameLevel)


initGameLevel : GameLevel
initGameLevel =
    GameLevel "Street Runner" 16 12 5 10 2 4 2


gameLevels : List GameLevel
gameLevels =
    [ GameLevel "Gang level" 12 10 5 6 1 3 1
    , initGameLevel
    , GameLevel "Prime Runner" 20 14 6 14 3 5 3
    ]
