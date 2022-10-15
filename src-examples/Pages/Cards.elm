module Pages.Cards exposing (view)

import Element exposing (..)
import Element.Font as Font
import Examples.MainCards
import Shared


view : Examples.MainCards.Model -> Element Examples.MainCards.Msg
view model =
    column (Shared.card ++ [ height fill, width fill, spacing 10 ])
        [ el [ centerX, Font.bold, Font.size 24 ] <| text "Cards"
        , paragraph [ Font.center ]
            [ text "Example of a Random Cards generator made with "
            , newTabLink Shared.linkAttrsInline { label = text "elm-random", url = "https://package.elm-lang.org/packages/elm/random/latest/" }
            , text ". Source: "
            , newTabLink Shared.linkAttrsInline { label = text "elm-lang.org/examples/cards", url = "https://elm-lang.org/examples/cards" }
            , text "."
            ]
        , el (Shared.cardTop ++ [ width shrink, centerX, centerY, padding 0 ]) <| html <| Examples.MainCards.view model
        ]
