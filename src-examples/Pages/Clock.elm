module Pages.Clock exposing (view)

import Element exposing (..)
import Element.Font as Font
import Examples.MainClock
import Shared


view : Examples.MainClock.Model -> Element Examples.MainClock.Msg
view model =
    column (Shared.card ++ [ height fill, width fill, spacing 10 ])
        [ el [ centerX, Font.bold, Font.size 24 ] <| text "Clock"
        , paragraph [ Font.center ]
            [ text "Example of a Clock made with "
            , newTabLink Shared.linkAttrsInline { label = text "elm-time", url = "https://package.elm-lang.org/packages/elm/time/latest/" }
            , text ". Source: "
            , newTabLink Shared.linkAttrsInline { label = text "elm-lang.org/examples/clock", url = "https://elm-lang.org/examples/clock" }
            , text "."
            ]
        , el (Shared.cardTop ++ [ width shrink, centerX, centerY, padding 20 ]) <| html <| Examples.MainClock.view model
        ]
