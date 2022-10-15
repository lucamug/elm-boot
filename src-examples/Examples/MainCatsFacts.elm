module Examples.MainCatsFacts exposing
    ( Model
    , Msg(..)
    , initModel
    , main
    , update
    , viewElmUi
    )

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Http
import Json.Decode


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type Model
    = Failure
    | Loading
    | NotRequested
    | Success CatFact


type alias CatFact =
    { fact : String }


catFactDecoder : Json.Decode.Decoder CatFact
catFactDecoder =
    Json.Decode.map CatFact
        (Json.Decode.field "fact" Json.Decode.string)


initModel : Model
initModel =
    NotRequested


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel, getRandomQuote )


type Msg
    = MorePlease
    | GotQuote (Result Http.Error CatFact)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        MorePlease ->
            ( Loading, getRandomQuote )

        GotQuote result ->
            case result of
                Ok quote ->
                    ( Success quote, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


button : String -> Element Msg
button label =
    Input.button
        [ Background.color <| rgb 0.9 0.6 0.5
        , padding 10
        , width fill
        , Border.rounded 100
        , Font.center
        ]
        { label = paragraph [] [ text label ], onPress = Just MorePlease }


view : Model -> Html.Html Msg
view model =
    layout [ Background.color <| rgb 0.3 0.3 0.3, padding 60 ] <| viewElmUi model


viewElmUi : Model -> Element Msg
viewElmUi model =
    column
        [ Background.color <| rgb 1 0.7 0.6
        , Border.rounded 10
        , Border.shadow { offset = ( 5, 5 ), size = 0, blur = 20, color = rgba 0 0 0 0.8 }
        , spacing 40
        , width <| px 320
        , padding 40
        , centerX
        , centerY
        , inFront <|
            el
                [ Font.size 50
                , Font.center
                , Background.color <| rgb 1 0.9 0.8
                , padding 20
                , centerX
                , Border.rounded 100
                , moveUp 40
                , moveLeft 140
                ]
            <|
                text "🐾"
        ]
        [ el
            [ Font.size 26
            , Font.bold
            , centerX
            ]
          <|
            text "Cats' Facts"
        , case model of
            Failure ->
                column [ spacing 40 ]
                    [ paragraph [ Font.center ] [ text "I could not load a cat fact for some reason." ]
                    , button "Try Again!"
                    ]

            Loading ->
                el [ centerX ] <| text "Loading..."

            NotRequested ->
                button "More Please!"

            Success quote ->
                column [ spacing 40 ]
                    [ button "More Please!"
                    , paragraph [ Font.center, Font.italic ] [ text quote.fact ]
                    ]
        ]


getRandomQuote : Cmd Msg
getRandomQuote =
    Http.get
        { url = "https://catfact.ninja/fact"
        , expect = Http.expectJson GotQuote catFactDecoder
        }
