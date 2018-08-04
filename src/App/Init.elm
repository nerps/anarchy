module App.Init exposing (init)

import Model exposing (..)
import Attributes.Init exposing (attributeMinima)
import Skills.Init exposing (initSelectedSkills)
import Messages exposing (..)
import Bootstrap.Modal as Modal
import Amps.Init exposing (initAmps, initAmpSelectizeModel, initAmpTypeSelectizeModel)
import Qualities.Init exposing (initQualities, initQualitySelectizeModel)
import Metatypes.Init exposing (human)
import Dispositions.Init exposing (initDispositions)
import Cues.Init exposing (initCues)
import Weirdness.Types exposing (..)
import GameLevel.Init exposing (initGameLevel)


init : ( Model, Cmd Msg )
init =
    ( { metatype = human
      , weirdness = Mundane
      , name = ""
      , attributes = attributeMinima --starts with minima
      , gameLevel = initGameLevel
      , skills = []
      , selectedSkills = initSelectedSkills
      , knowledgeSkill = ""
      , selectizeMenu = Nothing
      , selectizeMenuSkillSpec = Nothing
      , modalUidAmp = "NO AMP MODAL"
      , modalStateAmp = Modal.hiddenState
      , selectedAmps = initAmps
      , selectizeMenuAmp = initAmpSelectizeModel "nothing"
      , selectizeMenuAmpType = initAmpTypeSelectizeModel "nothing"
      , dispositions = initDispositions
      , cues = initCues
      , modalUidQuality = "NO QUALITY MODAL"
      , modalStateQuality = Modal.hiddenState
      , selectedQualities = initQualities
      , selectizeMenuQuality = initQualitySelectizeModel "nothing"
      }
    , Cmd.none
    )
