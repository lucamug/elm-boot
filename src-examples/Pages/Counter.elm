module Pages.Counter exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Shared


view :
    { counter : Int, msgDecrement : msg, msgIncrement : msg, msgReset : msg }
    -> Element msg
view args =
    column (Shared.card ++ [ height fill, width fill, spacing 10 ])
        [ el [ centerX, Font.bold, Font.size 24 ] <| text "Counter"
        , paragraph [ Font.center ]
            [ text "Example of a simple Counter made with "
            , newTabLink Shared.linkAttrsInline { label = text "elm-ui", url = "https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/" }
            , text "."
            ]
        , viewCounter args
        ]


viewCounter :
    { counter : Int
    , msgDecrement : msg
    , msgIncrement : msg
    , msgReset : msg
    }
    -> Element msg
viewCounter args =
    column (Shared.cardTop ++ [ padding 20, spacing 20, centerX, centerY, width shrink, height shrink ])
        [ row [ spacing 20, width fill ]
            [ Input.button buttonAttrs
                { label = text "Decrement", onPress = Just args.msgDecrement }
            , Input.button buttonAttrs
                { label = text "Increment", onPress = Just args.msgIncrement }
            ]
        , el
            [ Font.center
            , Font.size 34
            , Background.color <| rgb 1 1 1
            , Border.rounded 5
            , padding 20
            , width fill
            ]
            (text <| String.fromInt args.counter)
        , Input.button buttonAttrs
            { label = el [ Font.center, width fill ] <| text "Reset"
            , onPress = Just args.msgReset
            }
        ]


buttonAttrs : List (Attr () msg)
buttonAttrs =
    [ Background.color <| rgb255 17 123 180
    , Font.color <| rgb 1 1 1
    , Font.center
    , Border.rounded 50
    , width fill
    , padding 20
    ]
