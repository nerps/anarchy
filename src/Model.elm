module Model exposing (..)

import GameLevel.Types exposing (GameLevel)
import Weirdness.Types exposing (..)
import Attributes.Types exposing (Attributes)
import Skills.Types exposing (..)
import Selectize
import Dict
import Amps.Types exposing (..)
import Bootstrap.Modal as Modal
import Qualities.Types exposing (Quality)
import Metatypes.Types exposing (Metatype)


type alias Model =
    { metatype : Metatype -- influences some attribute points and limits
    , weirdness : Weirdness -- Mundane, Awakened, or Emerged
    , name : String
    , attributes : Attributes
    , gameLevel : GameLevel
    , skills : List Skill
    , selectedSkills : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int )
    , knowledgeSkill : String
    , selectizeMenu : Maybe ( String, Selectize.State Skill )
    , selectizeMenuSkillSpec : Maybe ( String, Selectize.State SkillSpec )
    , modalUidAmp : String -- identifies the amp slot the modal edits
    , modalStateAmp : Modal.State
    , selectedAmps : Dict.Dict String (Maybe Amp)
    , selectizeMenuAmp : Selectize.State Amp -- selectize state for amp selection in amp-modal
    , selectizeMenuAmpType : Selectize.State AmpType -- selectize state for amp type selection in amp-modal
    , dispositions : Dict.Dict String String
    , cues : Dict.Dict String String
    , modalUidQuality : String -- identifies the quality slot the modal edits
    , modalStateQuality : Modal.State
    , selectedQualities : Dict.Dict String (Maybe Quality)
    , selectizeMenuQuality : Selectize.State Quality
    }
