module Attributes.Types
    exposing
        ( AttributeID(..)
        , attributeSetters
        , attributeGetters
        , attributeIDtoString
        , Attributes
        )


type alias Attributes =
    { strength : Int
    , agility : Int
    , willpower : Int
    , logic : Int
    , charisma : Int
    , edge : Int
    }


type AttributeID
    = Strength
    | Agility
    | Willpower
    | Logic
    | Charisma
    | Edge


attributeSetters : AttributeID -> Attributes -> Int -> Attributes
attributeSetters aID attributes value =
    case aID of
        Strength ->
            { attributes | strength = value }

        Agility ->
            { attributes | agility = value }

        Willpower ->
            { attributes | willpower = value }

        Logic ->
            { attributes | logic = value }

        Charisma ->
            { attributes | charisma = value }

        Edge ->
            { attributes | edge = value }


attributeIDtoString : AttributeID -> String
attributeIDtoString aID =
    case aID of
        Strength ->
            "S"

        Agility ->
            "A"

        Willpower ->
            "W"

        Logic ->
            "L"

        Charisma ->
            "C"

        Edge ->
            "Edge"


attributeGetters : AttributeID -> (Attributes -> Int)
attributeGetters aID =
    case aID of
        Strength ->
            .strength

        Agility ->
            .agility

        Willpower ->
            .willpower

        Logic ->
            .logic

        Charisma ->
            .charisma

        Edge ->
            .edge
