module Skills.Types exposing (Skill, SkillSpec, SkillType(..))

import Attributes.Types
    exposing
        ( AttributeID(..)
        )


type alias SkillSpec =
    String


type alias Skill =
    { name : String
    , skillTypes : List SkillType
    , attribute : AttributeID
    , specialisations : List SkillSpec
    }


type SkillType
    = AwakenedSkill
    | EmergedSkill
