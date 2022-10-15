module Examples.MainCounter exposing (Model, Msg, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Decrement
    | Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        Decrement ->
            { model | count = model.count - 1 }

        Increment ->
            { model | count = model.count + 1 }


view : Model -> Html Msg
view model =
    div
        [ style "margin" "50px", style "text-align" "center" ]
        [ button [ style "font-size" "18px", Html.Events.onClick Increment ] [ text "Increment" ]
        , p [ style "font-size" "40px" ] [ text <| String.fromInt model.count ]
        , button [ style "font-size" "18px", Html.Events.onClick Decrement ] [ text "Decrement" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }
