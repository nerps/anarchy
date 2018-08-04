module Messages exposing (..)

import Weirdness.Types exposing (..)
import Attributes.Types exposing (AttributeID, Attributes)
import Selectize
import Skills.Types exposing (Skill, SkillSpec)
import Bootstrap.Modal as Modal
import Amps.Types exposing (Amp, AmpType)
import Qualities.Types exposing (Quality)
import Metatypes.Types exposing (Metatype)
import GameLevel.Types exposing (GameLevel)


-- MESSAGES


type Msg
    = OnNameInputChanged String
    | OnDispositionInputChanged String String
    | OnCueInputChanged String String
    | OnWeirdnessChanged Weirdness
    | OnAttributeInputChanged AttributeID String
    | SetGameLevel GameLevel
    | SetMetatype Metatype
    | SetAttributes Attributes
    | SkillMenuMsg String (Selectize.Msg Skill)
    | SkillSpecMenuMsg String (Selectize.Msg SkillSpec)
    | OnSkillPointsInputChanged String String
    | SelectSkill String (Maybe Skill)
    | SelectSkillSpec String (Maybe SkillSpec)
    | SetKnowledgeSkill String
    | AmpModalMsg String Modal.State
    | AmpMenuMsg String (Selectize.Msg Amp)
    | SelectAmp String (Maybe Amp)
    | AmpTypeMenuMsg String (Selectize.Msg AmpType)
    | SelectAmpType String (Maybe AmpType)
    | QualityModalMsg String Modal.State
    | QualityMenuMsg String (Selectize.Msg Quality)
    | SelectQuality String (Maybe Quality)
