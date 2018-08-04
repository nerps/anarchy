module Metatypes.Types exposing (..)

import Attributes.Types exposing (Attributes)


type alias Metatype =
    { name : String
    , attributeModifiers : Attributes
    , attributeMaxima : Attributes
    , skillPointsModifier : Int
    , armorModifier : Int
    }
