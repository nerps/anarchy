module Metatypes.Init exposing (..)

import Metatypes.Types exposing (..)
import Attributes.Types exposing (Attributes)


human : Metatype
human =
    Metatype "Human" (Attributes 1 1 1 1 1 1) (Attributes 6 6 6 6 6 6) 1 0


metatypes : List Metatype
metatypes =
    [ human
    , Metatype "Elf" (Attributes 1 2 1 1 2 0) (Attributes 6 7 6 6 8 6) 0 0
    , Metatype "Dwarf" (Attributes 2 1 2 1 1 0) (Attributes 8 6 7 6 6 6) 0 0
    , Metatype "Ork" (Attributes 3 1 1 1 1 0) (Attributes 8 6 6 5 5 6) 0 0
    , Metatype "Troll" (Attributes 3 1 1 1 1 0) (Attributes 10 5 6 5 4 6) -1 3
    ]
