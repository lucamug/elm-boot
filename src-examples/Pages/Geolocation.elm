module Pages.Geolocation exposing (view)

import Element exposing (..)
import Element.Font as Font
import Examples.MainGeolocation
import Shared


view : Examples.MainGeolocation.Model -> Element Examples.MainGeolocation.Msg
view model =
    column (Shared.card ++ [ height fill, width fill, spacing 10 ])
        [ el [ centerX, Font.bold, Font.size 24 ] <| text "Geolocation"
        , paragraph [ Font.center ]
            [ text "Example of sending and receiving data via HTTP using "
            , newTabLink Shared.linkAttrsInline { label = text "elm-http", url = "https://package.elm-lang.org/packages/elm/http/latest/Http" }
            , text "."
            ]
        , el [] <| html <| Examples.MainGeolocation.view model
        ]
