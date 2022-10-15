module Examples.MainCounterElmUi exposing (Model, Msg, main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Decrement
    | Increment
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Decrement ->
            { model | count = model.count - 1 }

        Increment ->
            { model | count = model.count + 1 }

        Reset ->
            { model | count = 0 }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }


buttonAttrs : List (Attr () msg)
buttonAttrs =
    [ Background.color <| rgb255 17 123 180
    , Font.color <| rgb 1 1 1
    , Font.center
    , Border.rounded 50
    , width fill
    , padding 20
    ]


view : Model -> Html.Html Msg
view model =
    layout [ Background.color <| rgb 0.9 0.9 0.9 ] <|
        column
            [ padding 20
            , spacing 20
            , centerX
            , centerY
            ]
            [ row [ spacing 20, width fill ]
                [ Input.button buttonAttrs
                    { label = text "Decrement", onPress = Just Decrement }
                , Input.button buttonAttrs
                    { label = text "Increment", onPress = Just Increment }
                ]
            , el
                [ Font.center
                , Font.size 34
                , Background.color <| rgb 1 1 1
                , Border.rounded 5
                , padding 20
                , width fill
                ]
                (text <| String.fromInt model.count)
            , Input.button buttonAttrs
                { label = el [ Font.center, width fill ] <| text "Reset"
                , onPress = Just Reset
                }
            ]
