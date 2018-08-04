module Attributes.Update exposing (..)

import Helpers exposing (strToMaybeInt)
import Attributes.Types exposing (..)


handleAttributeChange : Attributes -> Attributes -> AttributeID -> String -> Attributes
handleAttributeChange currentAttributes attributeModifiers aID strNewVal =
    let
        maybeNewVal =
            strToMaybeInt strNewVal

        attribModifier =
            attributeGetters aID attributeModifiers

        attributeSetter =
            attributeSetters aID currentAttributes
    in
        case maybeNewVal of
            Just intNewVal ->
                attributeSetter (intNewVal - attribModifier)

            Nothing ->
                currentAttributes
