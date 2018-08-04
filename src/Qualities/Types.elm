module Qualities.Types exposing (..)

import Attributes.Types exposing (Attributes)


type alias Quality =
    { title : String
    , text : String
    , modifyAttribute : Attributes
    , modifyAttributeMaximum : Attributes
    , ignoreEssenceLossOnShadowAmps : Int
    , modifyConditionMonitorPhysical : Int
    , modifyConditionMonitorStun : Int
    }
