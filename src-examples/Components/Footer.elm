module Components.Footer exposing (view)

import Element exposing (..)
import Element.Font as Font


view : Element msg
view =
    paragraph
        [ Font.center
        , Font.size 14
        , width fill
        , padding 10
        , Font.color <| rgba 0 0 0 0.5
        ]
        [ text "Carefully crafted with Elm and "
        , el [ Font.color <| rgba 0.8 0.0 0.0 0.5, Font.size 16 ] <| text "♥"
        ]
