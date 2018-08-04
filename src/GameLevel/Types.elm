module GameLevel.Types exposing (..)


type alias GameLevel =
    { name : String
    , attributePoints : Int
    , skillPoints : Int
    , skillMaximum : Int
    , ampsPoints : Int
    , weaponsPoints : Int
    , itemsPoints : Int
    , contactPoints : Int
    }
