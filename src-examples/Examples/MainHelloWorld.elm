module Examples.MainHelloWorld exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    h1 [ style "text-align" "center" ] [ text "Hello, World! 👋" ]
