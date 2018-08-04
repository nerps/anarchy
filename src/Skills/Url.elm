module Skills.Url exposing (state2query, builder2messages)

import Skills.Types exposing (..)
import Skills.Init exposing (..)
import Dict
import RouteUrl.Builder exposing (Builder, getQuery)
import Messages exposing (..)


state2query : Dict.Dict String ( Maybe Skill, Maybe SkillSpec, Int ) -> List ( String, String )
state2query selectedSkills =
    Dict.toList selectedSkills
        |> List.map (\( k, v ) -> ( k, skill2query v ))


skill2query : ( Maybe Skill, Maybe SkillSpec, Int ) -> String
skill2query ( maybeSkill, maybeSkillSpec, points ) =
    let
        strSkill =
            Maybe.withDefault defaultSkill maybeSkill
                |> .name

        strSkillSpec =
            Maybe.withDefault "" maybeSkillSpec
    in
        strSkill ++ "." ++ strSkillSpec ++ "." ++ toString points


builder2messages : Builder -> List Msg
builder2messages builder =
    -- builder has queries like sk1=skillname1.skillspec1.42
    initSelectedSkills
        |> Dict.keys
        |> List.map (parse2Messages builder)
        |> List.concat


parse2Messages : Builder -> String -> List Msg
parse2Messages builder id =
    let
        strQueryParameter =
            getQuery id builder
                |> List.head
                |> Maybe.withDefault ".."
    in
        case String.split "." strQueryParameter of
            strSkill :: strSkillSpec :: strPoints :: _ ->
                let
                    maybeSkill =
                        availableSkills
                            |> List.filter (\sk -> sk.name == strSkill)
                            |> List.head

                    specAndPointsMessages =
                        case maybeSkill of
                            Just skill ->
                                let
                                    maybeSkillSpec =
                                        skill.specialisations
                                            |> List.filter (\sks -> sks == strSkillSpec)
                                            |> List.head
                                in
                                    [ SelectSkillSpec id maybeSkillSpec, OnSkillPointsInputChanged id strPoints ]

                            Nothing ->
                                []
                in
                    List.concat [ [ SelectSkill id maybeSkill ], specAndPointsMessages ]

            _ ->
                []
