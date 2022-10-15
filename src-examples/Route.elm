port module Route exposing
    ( Route(..)
    , changeMeta
    , fromString
    , onUrlChange
    , pushUrl
    , toLocationHref
    , toTitle
    )

import Shared
import Url
import Url.Parser


type Route
    = Cards
    | CatsFacts
    | Clock
    | Counter
    | Geolocation
    | Home
    | Todos


fromString : Shared.NavigationModality -> String -> Route
fromString navigationMode locationHref =
    let
        urlModifier : Url.Url -> Url.Url
        urlModifier =
            case navigationMode of
                Shared.NavigationByFragment ->
                    \url -> { url | path = Maybe.withDefault "" url.fragment }

                Shared.NavigationByPath ->
                    identity
    in
    locationHref
        |> Url.fromString
        |> Maybe.map urlModifier
        |> Maybe.andThen (Url.Parser.parse urlParser)
        |> Maybe.withDefault Home


urlParser : Url.Parser.Parser (Route -> Route) Route
urlParser =
    Url.Parser.oneOf
        [ urlParserHelper Home
        , urlParserHelper CatsFacts
        , urlParserHelper Counter
        , urlParserHelper Geolocation
        , urlParserHelper Cards
        , urlParserHelper Todos
        , urlParserHelper Clock
        ]


urlParserHelper : Route -> Url.Parser.Parser (Route -> c) c
urlParserHelper route =
    Url.Parser.map route (Url.Parser.s (toString route))


toLocationHref : Shared.NavigationModality -> Route -> String
toLocationHref navigationMode route =
    case navigationMode of
        Shared.NavigationByFragment ->
            "#/" ++ toString route

        Shared.NavigationByPath ->
            "/" ++ toString route


toTitle : Route -> String
toTitle route =
    case route of
        Cards ->
            "Cards"

        CatsFacts ->
            "Cat's Facts"

        Clock ->
            "Clock"

        Counter ->
            "Counter"

        Geolocation ->
            "Geolocation"

        Home ->
            "Home"

        Todos ->
            "Todos"


toString : Route -> String
toString route =
    case route of
        Cards ->
            "cards"

        CatsFacts ->
            "cats_facts"

        Clock ->
            "clock"

        Counter ->
            "counter"

        Geolocation ->
            "geolocation"

        Home ->
            ""

        Todos ->
            "todos"


port onUrlChange : (String -> msg) -> Sub msg


port pushUrl : String -> Cmd msg


port changeMeta : { querySelector : String, fieldName : String, content : String } -> Cmd msg
