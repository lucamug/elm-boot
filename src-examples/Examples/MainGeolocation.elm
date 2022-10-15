-- Press a button to send a GET request for random quotes.
--
-- Read how it works:
--   https://guide.elm-lang.org/effects/json.html
--


module Examples.MainGeolocation exposing
    ( HttpStatus
    , Location
    , Model
    , Msg(..)
    , init
    , main
    , update
    , view
    )

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Http
import Json.Decode
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }


type alias Model =
    { httpStatus : HttpStatus
    , query : String
    }


type HttpStatus
    = Failure
    | Loading
    | Success (List Location)


type alias Location =
    { displayName : String
    , lat : String
    , lon : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        query : String
        query =
            "Tokyo"
    in
    ( { httpStatus = Loading, query = query }
    , getLocation query
    )


type Msg
    = EditQuery String
    | GetLocation
    | GotLocation (Result Http.Error (List Location))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditQuery query ->
            ( { model | query = query }, Cmd.none )

        GetLocation ->
            ( { model | httpStatus = Loading }, getLocation model.query )

        GotLocation result ->
            case result of
                Err _ ->
                    ( { model | httpStatus = Failure }, Cmd.none )

                Ok quote ->
                    ( { model | httpStatus = Success quote }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ style "padding" "30px" ]
        ([ h2 [] [ text "Search Location" ]
         , p [ style "font-size" "13px" ]
            [ text "Powered by "
            , a [ href "https://nominatim.org/", target "_blank" ] [ text "Nominatim" ]
            , text "."
            ]
         , p []
            [ input
                [ value model.query
                , Html.Events.onInput EditQuery
                , onEnter GetLocation
                , style "font-size" "16px"
                , style "padding" "6px"
                ]
                []
            , button
                [ Html.Events.onClick GetLocation
                , style "font-size" "16px"
                , style "padding" "6px"
                , style "margin-left" "6px"
                ]
                [ text "Search" ]
            ]
         ]
            ++ (case model.httpStatus of
                    Failure ->
                        [ div [] [ text "Error!" ] ]

                    Loading ->
                        [ div [] [ text "Loading!" ] ]

                    Success [] ->
                        [ div [] [ text "No results found!" ] ]

                    Success (location :: _) ->
                        [ li [] [ text <| "Name: " ++ location.displayName ]
                        , li [] [ text <| "Latitude: " ++ location.lat ]
                        , li [] [ text <| "Longitude: " ++ location.lon ]
                        , li []
                            [ a
                                [ href <| "https://www.openstreetmap.org/#map=13/" ++ location.lat ++ "/" ++ location.lon
                                , target "_blank"
                                ]
                                [ text "See in OpenStreet.org" ]
                            ]
                        , p
                            [ style "display" "flex"
                            , style "flex-wrap" "wrap"
                            ]
                            [ mapTile location 0
                            , mapTile location 4
                            , mapTile location 10
                            ]
                        ]
               )
        )


getLocation : String -> Cmd Msg
getLocation query =
    Http.get
        { expect = Http.expectJson GotLocation locationDecoder
        , url = "https://nominatim.openstreetmap.org/search.php?format=jsonv2&city=" ++ Url.percentEncode query
        }


locationDecoder : Json.Decode.Decoder (List Location)
locationDecoder =
    Json.Decode.list
        (Json.Decode.map3 Location
            (Json.Decode.field "display_name" Json.Decode.string)
            (Json.Decode.field "lat" Json.Decode.string)
            (Json.Decode.field "lon" Json.Decode.string)
        )


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter : Int -> Json.Decode.Decoder Msg
        isEnter code =
            if code == 13 then
                Json.Decode.succeed msg

            else
                Json.Decode.fail "not ENTER"
    in
    Html.Events.on "keydown" (Json.Decode.andThen isEnter Html.Events.keyCode)


mapTile : Location -> Float -> Html msg
mapTile location zoomScale =
    let
        latitude : Float
        latitude =
            Maybe.withDefault 0 <| String.toFloat location.lat

        longitude : Float
        longitude =
            Maybe.withDefault 0 <| String.toFloat location.lon

        x : Int
        x =
            long2tile longitude zoomScale

        y : Int
        y =
            lat2tile latitude zoomScale

        tileAddress : String
        tileAddress =
            "https://tile.openstreetmap.org/"
                ++ String.fromFloat zoomScale
                ++ "/"
                ++ String.fromInt x
                ++ "/"
                ++ String.fromInt y
                ++ ".png"
    in
    div
        [ style "position" "relative"
        , style "margin" "2px"
        ]
        [ img [ src tileAddress, style "border" "1px solid black" ] []
        , div
            [ style "display" "block"
            , style "position" "absolute"
            , style "width" "30px"
            , style "height" "30px"
            , style "border" "2px solid rgba(200,0,0,0.5)"
            , style "border-radius" "30px"
            , style "left" (String.fromFloat ((long2tfac longitude zoomScale * -256) - 15) ++ "px")
            , style "top" (String.fromFloat ((lat2tfac latitude zoomScale * -256) - 15) ++ "px")
            ]
            [ text "" ]
        ]



--
-- Latitude/Longitude stuff
-- From https://stackoverflow.com/questions/54588308/longitude-latitude-to-osm-pixel-in-256x256-tile
--


lo2t : Float -> Float -> Float
lo2t lon zoom =
    (lon + 180) / 360 * (2 ^ zoom)


la2t : Float -> Float -> Float
la2t lat zoom =
    (1 - logBase e (tan (lat * pi / 180) + 1 / cos (lat * pi / 180)) / pi) / 2 * (2 ^ zoom)


long2tile : Float -> Float -> Int
long2tile lon zoom =
    floor (lo2t lon zoom)


lat2tile : Float -> Float -> Int
lat2tile lat zoom =
    floor (la2t lat zoom)


long2tfac : Float -> Float -> Float
long2tfac lon zoom =
    toFloat (long2tile lon zoom) - lo2t lon zoom


lat2tfac : Float -> Float -> Float
lat2tfac lat zoom =
    toFloat (lat2tile lat zoom) - la2t lat zoom
