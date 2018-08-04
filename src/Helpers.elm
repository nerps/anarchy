module Helpers exposing (..)

import Weirdness.Types exposing (..)
import Amps.Types exposing (Amp, getPoints)
import Dict
import List


strToMaybeInt : String -> Maybe Int
strToMaybeInt value =
    String.toInt value |> Result.toMaybe


strToMaybeFloat : String -> Maybe Float
strToMaybeFloat value =
    String.toFloat value |> Result.toMaybe


ampPointsSpent : Dict.Dict String (Maybe Amp) -> Weirdness -> Int
ampPointsSpent selectedAmps weirdness =
    -- sums up points spent on Amps and Weirdness (0 or 2)
    let
        pointsSpentOnWeirdness =
            case weirdness of
                Mundane ->
                    0

                _ ->
                    2
    in
        pointsSpentOnWeirdness + (selectedAmps |> Dict.toList |> List.map (\( k, v ) -> getPoints v) |> List.sum)
