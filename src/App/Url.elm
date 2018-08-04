module App.Url exposing (delta2url, location2messages)

import RouteUrl exposing (RouteUrlProgram)
import RouteUrl.Builder exposing (Builder, builder, query, replaceQuery, getQuery)
import Navigation exposing (Location)
import Model exposing (Model)
import Messages exposing (..)
import Skills.Url
import Dispositions.Url
import Cues.Url
import Metatypes.Url
import Attributes.Url
import Weirdness.Url
import Amps.Url
import Qualities.Url


delta2url : Model -> Model -> Maybe RouteUrl.UrlChange
delta2url previous current =
    Maybe.map RouteUrl.Builder.toUrlChange <|
        delta2builder previous current



-- let's try to build an url /?m=Human&at=(1,2,3,1,1)&sk1=(Firearms,,2)&sk2=(Conjuring,Fire Spirits,5)& ...


delta2builder : Model -> Model -> Maybe Builder
delta2builder previous current =
    -- I don't need previous model
    let
        name =
            ( "n", current.name ) |> List.singleton

        metatype =
            -- m
            Metatypes.Url.state2query current.metatype

        attributes =
            -- at
            Attributes.Url.state2query current.attributes

        weirdness =
            -- w
            Weirdness.Url.state2query current.weirdness

        skills =
            -- from s1 to s5
            Skills.Url.state2query current.selectedSkills

        knowledgeSkill =
            -- k
            ( "k", current.knowledgeSkill ) |> List.singleton

        dispositions =
            -- from d1 to d4
            Dispositions.Url.state2query current.dispositions

        cues =
            -- from c1 to c10
            Cues.Url.state2query current.cues

        amps =
            -- from a1 to a6
            Amps.Url.state2query current.selectedAmps

        qualities =
            -- q1p, q2p, q3n
            Qualities.Url.state2query current.selectedQualities
    in
        builder
            |> replaceQuery
                (List.concat
                    [ name, metatype, attributes, weirdness, skills, knowledgeSkill, dispositions, cues, amps, qualities ]
                )
            |> Just


location2messages : Location -> List Msg
location2messages location =
    builder2messages (RouteUrl.Builder.fromUrl location.href)


builder2messages : Builder -> List Msg
builder2messages builder =
    let
        n =
            getQuery "n" builder
                |> List.head
                |> Maybe.withDefault ""
                |> OnNameInputChanged
                |> List.singleton

        m =
            Metatypes.Url.builder2messages builder

        at =
            Attributes.Url.builder2messages builder

        w =
            Weirdness.Url.builder2messages builder

        s =
            Skills.Url.builder2messages builder

        k =
            getQuery "k" builder
                |> List.head
                |> Maybe.withDefault ""
                |> SetKnowledgeSkill
                |> List.singleton

        d =
            Dispositions.Url.builder2messages builder

        c =
            Cues.Url.builder2messages builder

        a =
            Amps.Url.builder2messages builder

        q =
            Qualities.Url.builder2messages builder
    in
        List.concat [ n, m, at, w, s, k, d, c, a, q ]
