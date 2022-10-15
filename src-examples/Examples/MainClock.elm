module Examples.MainClock exposing
    ( Model
    , Msg
    , init
    , main
    , subscriptions
    , update
    , view
    )

-- Show an analog clock for your time zone.
--
-- Dependencies:
--   elm install elm/svg
--   elm install elm/time
--
-- For a simpler version, check out:
--   https://elm-lang.org/examples/time
--

import Browser
import Html exposing (Html)
import Svg
import Svg.Attributes
import Task
import Time



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { time : Time.Posix
    , zone : Time.Zone
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { time = Time.millisToPosix 0
      , zone = Time.utc
      }
    , Cmd.batch
        [ Task.perform AdjustTimeZone Time.here
        , Task.perform Tick Time.now
        ]
    )



-- UPDATE


type Msg
    = AdjustTimeZone Time.Zone
    | Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )

        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        hour : Float
        hour =
            toFloat (Time.toHour model.zone model.time)

        minute : Float
        minute =
            toFloat (Time.toMinute model.zone model.time)

        second : Float
        second =
            toFloat (Time.toSecond model.zone model.time)
    in
    Svg.svg
        [ Svg.Attributes.viewBox "80 80 240 240"
        , Svg.Attributes.width "240"
        , Svg.Attributes.height "240"
        ]
        [ Svg.circle
            [ Svg.Attributes.cx "200"
            , Svg.Attributes.cy "200"
            , Svg.Attributes.r "120"
            , Svg.Attributes.fill "#1293D8"
            ]
            []
        , viewHand 6 60 (hour / 12)
        , viewHand 6 90 (minute / 60)
        , viewHand 3 90 (second / 60)
        ]


viewHand : Int -> Float -> Float -> Svg.Svg msg
viewHand width length turns =
    let
        t : Float
        t =
            2 * pi * (turns - 0.25)

        x : Float
        x =
            200 + length * cos t

        y : Float
        y =
            200 + length * sin t
    in
    Svg.line
        [ Svg.Attributes.x1 "200"
        , Svg.Attributes.y1 "200"
        , Svg.Attributes.x2 (String.fromFloat x)
        , Svg.Attributes.y2 (String.fromFloat y)
        , Svg.Attributes.stroke "white"
        , Svg.Attributes.strokeWidth (String.fromInt width)
        , Svg.Attributes.strokeLinecap "round"
        ]
        []
