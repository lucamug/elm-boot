-- Run the command `cmd/start` in
-- the Console or in the Shell to
-- start the development server.
--
-- Then edit this file and see
-- the chnages in the Webview.
--
-- More info in the README.md


module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    h1
        [ style "text-align" "center"
        , style "padding" "50px"
        ]
        [ text "Welcome! 👋" ]
