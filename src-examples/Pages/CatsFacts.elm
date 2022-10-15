module Pages.CatsFacts exposing (view)

import Element exposing (..)
import Element.Font as Font
import Examples.MainCatsFacts
import Shared


view : Examples.MainCatsFacts.Model -> Element Examples.MainCatsFacts.Msg
view model =
    column (Shared.card ++ [ height fill, width fill, spacing 10 ])
        [ el [ centerX, Font.bold, Font.size 24 ] <| text "Cats' Facts"
        , paragraph [ Font.center ]
            [ text "Example of sending and receiving data via HTTP using "
            , newTabLink Shared.linkAttrsInline { label = text "elm-http", url = "https://package.elm-lang.org/packages/elm/http/latest/Http" }
            , text "."
            ]
        , el [ centerX, centerY ] <| Examples.MainCatsFacts.viewElmUi model
        ]
