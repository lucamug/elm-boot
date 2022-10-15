module Pages.Todos exposing (view)

import Element exposing (..)
import Element.Font as Font
import Examples.MainTodos
import Shared


view : Examples.MainTodos.Model -> Element Examples.MainTodos.Msg
view model =
    column (Shared.card ++ [ height fill, width fill, spacing 10 ])
        [ el [ centerX, Font.bold, Font.size 24 ] <| text "Todo"
        , paragraph [ Font.center ]
            [ text "Example of a small Application built using CSS and with persistent data saved to the Local Storage"
            , text ". Source: "
            , newTabLink Shared.linkAttrsInline { label = text "github.com/evancz/elm-todomvc", url = "https://github.com/evancz/elm-todomvc" }
            , text "."
            ]
        , el (Shared.cardTop ++ [ width shrink, centerX, centerY ]) <| html <| Examples.MainTodos.view model
        ]
