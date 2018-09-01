module App.View exposing (view)

import Model exposing (..)
import Html exposing (Html, div, text, label, input)
import Html.Attributes exposing (id, type_, for, value, class, form, style, name)
import Html.Events exposing (..)
import Attributes.View
import Dict
import Amps.View
import Messages exposing (..)
import Warnings.View
import Dispositions.View
import Cues.View
import Weirdness.View
import Skills.View
import Qualities.View
import Metatypes.View
import GameLevel.View
import ConditionMonitor.View
import Armor.View


view : Model -> Html Msg
view model =
    div [ class "container-fluid" ]
        [ --Html.node "link" [ Html.Attributes.rel "stylesheet", Html.Attributes.href "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css", Html.Attributes.attribute "integrity" "sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm", Html.Attributes.attribute "crossorigin" "anonymous" ] []
          Amps.View.ampModalView model.modalUidAmp
            model.modalStateAmp
            model.selectedAmps
            model.selectizeMenuAmp
            model.selectizeMenuAmpType
            model.weirdness
        , Qualities.View.modalView
            model.modalUidQuality
            model.modalStateQuality
            model.selectedQualities
            model.selectizeMenuQuality
            model.weirdness
        
        , div [ class "row", class "nextToConfig" ] [ div [ class "col" ] [ nameInput model.name ], div [ class "col" ] [ Weirdness.View.weirdnessInput model.weirdness ] ]
        , div [ class "row", class "attributeRow", class "attributes" ]
            (Attributes.View.attributeInputs
                model.metatype.attributeMaxima
                model.metatype.attributeModifiers
                model.selectedQualities
                model.attributes
                model.selectedAmps
                model.gameLevel.ampsPoints
                model.weirdness
            )
        , Dispositions.View.view model.dispositions
        , div [ class "skills" ]
            (List.concat
                [ model.selectedSkills
                    |> Dict.toList
                    |> List.map
                        (Skills.View.skillSelectView model.selectizeMenu model.selectizeMenuSkillSpec model.gameLevel.skillMaximum)
                , [ Skills.View.knowledgeSkillView model.knowledgeSkill ]
                ]
            )
        , Amps.View.view model.selectedAmps model.selectedQualities
        , Cues.View.view model.cues
        , Qualities.View.view model.selectedQualities
        , Armor.View.view model.metatype model.selectedSkills (model.gameLevel.skillPoints + model.metatype.skillPointsModifier)
        , ConditionMonitor.View.conditionMonitorPhysical model.attributes model.metatype.attributeModifiers model.selectedQualities
        , ConditionMonitor.View.conditionMonitorStun model.attributes model.metatype.attributeModifiers model.selectedQualities
        , div [   ] [ text "GEAR/CONTACTS" ]
        , div [ class "config no-print" ]
            [ GameLevel.View.view model.gameLevel
            , Metatypes.View.metatypeChooser model.metatype
            , Warnings.View.attributePointsToSpendHtml model.attributes model.gameLevel.attributePoints
            , Warnings.View.skillPointsToSpendHtml model.selectedSkills (model.gameLevel.skillPoints + model.metatype.skillPointsModifier)
            , Warnings.View.ampPointsToSpendHtml model.selectedAmps model.gameLevel.ampsPoints model.weirdness
            , Warnings.View.skillDoesNotFitWeirdnessWarning model.selectedSkills model.weirdness
            , Warnings.View.skillPointsValidHtml model.selectedSkills
            , Warnings.View.skillSpecsValidHtml model.selectedSkills
            ]
        ]


nameInput : String -> Html Msg
nameInput name =
    input
        [ type_ "text"
        , onInput OnNameInputChanged
        , value name
        , class "nameinput"
        ]
        []
