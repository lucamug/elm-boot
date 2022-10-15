module Examples.MainCards exposing
    ( Card
    , Model
    , Msg
    , initModel
    , main
    , update
    , view
    )

-- Press a button to draw a random card.
--
-- Dependencies:
--   elm install elm/random
--

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Random



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = \() -> ( initModel, Cmd.none )
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { card : Card
    }


initModel : Model
initModel =
    { card = Three }


type Card
    = Ace
    | Eight
    | Five
    | Four
    | Jack
    | King
    | Nine
    | Queen
    | Seven
    | Six
    | Ten
    | Three
    | Two



-- UPDATE


type Msg
    = Draw
    | NewCard Card


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Draw ->
            ( model
            , Random.generate NewCard cardGenerator
            )

        NewCard newCard ->
            ( { card = newCard }
            , Cmd.none
            )


cardGenerator : Random.Generator Card
cardGenerator =
    Random.uniform Ace
        [ Two
        , Three
        , Four
        , Five
        , Six
        , Seven
        , Eight
        , Nine
        , Ten
        , Jack
        , Queen
        , King
        ]



-- SUBSCRIPTIONS
-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "margin" "20px"
        , style "text-align" "center"
        ]
        [ button
            [ Html.Events.onClick Draw
            , style "font-size" "16px"
            , style "margin-bottom" "20px"
            ]
            [ text "Draw" ]
        , div [ Html.Events.onClick Draw ]
            [ button
                [ style "font-size" "20em"
                , style "border" "0"
                , style "background-color" "rgba(0,0,0,0)"
                ]
                [ text (viewCard model.card) ]
            ]
        ]


viewCard : Card -> String
viewCard card =
    case card of
        Ace ->
            "🂡"

        Eight ->
            "🂨"

        Five ->
            "🂥"

        Four ->
            "🂤"

        Jack ->
            "🂫"

        King ->
            "🂮"

        Nine ->
            "🂩"

        Queen ->
            "🂭"

        Seven ->
            "🂧"

        Six ->
            "🂦"

        Ten ->
            "🂪"

        Three ->
            "🂣"

        Two ->
            "🂢"
