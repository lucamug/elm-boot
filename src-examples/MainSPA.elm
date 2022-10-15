module MainSPA exposing
    ( Flags
    , Model
    , Msg
    , main
    )

import Browser
import Browser.Events
import Components.Footer
import Components.Header
import Components.SideMenu
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Examples.MainCards
import Examples.MainCatsFacts
import Examples.MainClock
import Examples.MainGeolocation
import Examples.MainTodos
import Html
import Html.Attributes
import Html.Events
import Pages.Cards
import Pages.CatsFacts
import Pages.Clock
import Pages.Counter
import Pages.Geolocation
import Pages.Home
import Pages.Todos
import Route
import Shared


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Flags =
    { env : Shared.Env
    , innerWidth : Int
    , locationHref : String
    , startingState : Maybe Examples.MainTodos.Model
    , navigationModality : Maybe String
    }


type alias Model =
    { counter : Int
    , env : Shared.Env
    , isSideMenuOpen : Bool
    , isSmallScreen : Bool
    , pageCardsModel : Examples.MainCards.Model
    , pageCatsFactsModel : Examples.MainCatsFacts.Model
    , pageClockModel : Examples.MainClock.Model
    , pageGeolocationModel : Examples.MainGeolocation.Model
    , pageTodoModel : Examples.MainTodos.Model
    , route : Route.Route
    , navigationModality : Shared.NavigationModality
    }


isSmallScreen : number -> Bool
isSmallScreen width =
    width < 740


init : Flags -> ( Model, Cmd Msg )
init flags =
    -- On small devices, the menu is closed at start. Otherwise
    -- it is open.
    let
        navigationModelityInit : Shared.NavigationModality
        navigationModelityInit =
            if flags.navigationModality == Just "NavigationByFragment" then
                Shared.NavigationByFragment

            else
                Shared.NavigationByPath

        ( geolocationModel, geolocationCmd ) =
            Examples.MainGeolocation.init ()

        ( clockModel, clockCmd ) =
            Examples.MainClock.init ()
    in
    ( { counter = 0
      , env = flags.env
      , isSideMenuOpen = not <| isSmallScreen flags.innerWidth
      , isSmallScreen = isSmallScreen flags.innerWidth
      , pageCardsModel = Examples.MainCards.initModel
      , pageCatsFactsModel = Examples.MainCatsFacts.initModel
      , pageClockModel = clockModel
      , pageGeolocationModel = geolocationModel
      , pageTodoModel = Examples.MainTodos.initModel { startingState = flags.startingState }
      , route = Route.fromString navigationModelityInit flags.locationHref
      , navigationModality = navigationModelityInit
      }
    , Cmd.batch
        [ Cmd.map MsgPageGeolocation geolocationCmd
        , Cmd.map MsgPageClock clockCmd
        ]
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Route.onUrlChange MsgUrlChanged
        , Browser.Events.onResize (\w _ -> MsgGotNewWidth w)
        , case model.route of
            Route.Clock ->
                Sub.map MsgPageClock (Examples.MainClock.subscriptions model.pageClockModel)

            _ ->
                Sub.none
        ]


type Msg
    = MsgCounterDecrement
    | MsgCounterIncrement
    | MsgCounterReset
    | MsgGotNewWidth Int
    | MsgOnPressHamburger
    | MsgPageCards Examples.MainCards.Msg
    | MsgPageCatsFacts Examples.MainCatsFacts.Msg
    | MsgPageClock Examples.MainClock.Msg
    | MsgPageGeolocation Examples.MainGeolocation.Msg
    | MsgPageTodos Examples.MainTodos.Msg
    | MsgPushUrl String
    | MsgUrlChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgCounterDecrement ->
            ( { model | counter = model.counter - 1 }, Cmd.none )

        MsgCounterIncrement ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        MsgCounterReset ->
            ( { model | counter = 0 }, Cmd.none )

        MsgGotNewWidth width ->
            ( { model
                | isSideMenuOpen =
                    if isSmallScreen width then
                        False

                    else
                        model.isSideMenuOpen
                , isSmallScreen = isSmallScreen width
              }
            , Cmd.none
            )

        MsgOnPressHamburger ->
            ( { model | isSideMenuOpen = not model.isSideMenuOpen }, Cmd.none )

        MsgPageCards subMsg ->
            let
                ( subModel, cmd ) =
                    Examples.MainCards.update subMsg model.pageCardsModel
            in
            ( { model | pageCardsModel = subModel }, Cmd.map MsgPageCards cmd )

        MsgPageCatsFacts subMsg ->
            let
                ( subModel, cmd ) =
                    Examples.MainCatsFacts.update subMsg model.pageCatsFactsModel
            in
            ( { model | pageCatsFactsModel = subModel }, Cmd.map MsgPageCatsFacts cmd )

        MsgPageClock subMsg ->
            let
                ( subModel, cmd ) =
                    Examples.MainClock.update subMsg model.pageClockModel
            in
            ( { model | pageClockModel = subModel }, Cmd.map MsgPageClock cmd )

        MsgPageGeolocation subMsg ->
            let
                ( subModel, cmd ) =
                    Examples.MainGeolocation.update subMsg model.pageGeolocationModel
            in
            ( { model | pageGeolocationModel = subModel }, Cmd.map MsgPageGeolocation cmd )

        MsgPageTodos subMsg ->
            let
                ( subModel, cmd ) =
                    Examples.MainTodos.update subMsg model.pageTodoModel
            in
            ( { model | pageTodoModel = subModel }, Cmd.map MsgPageTodos cmd )

        MsgPushUrl locationHref ->
            ( model, Route.pushUrl locationHref )

        MsgUrlChanged locationHref ->
            let
                route : Route.Route
                route =
                    Route.fromString model.navigationModality locationHref
            in
            ( { model
                | isSideMenuOpen =
                    if model.isSmallScreen then
                        False

                    else
                        model.isSideMenuOpen
                , route = route
              }
            , Route.changeMeta
                { content = Route.toTitle (Route.fromString model.navigationModality locationHref)
                , fieldName = "innerHTML"
                , querySelector = "title"
                }
            )


pixelsHeader : number
pixelsHeader =
    46


view : Model -> Html.Html Msg
view model =
    let
        widthSideMenu : Int
        widthSideMenu =
            if model.isSideMenuOpen then
                200

            else if model.isSmallScreen then
                0

            else
                100

        paddingLeftBody : Int
        paddingLeftBody =
            if model.isSmallScreen then
                0

            else if model.isSideMenuOpen then
                200

            else
                100
    in
    -- Main structure containing header, side menu, body (page), and footer.
    layoutWith
        { options = [ focusStyle { backgroundColor = Nothing, borderColor = Nothing, shadow = Nothing } ] }
        [ Font.family []
        , Background.color Shared.color.backgroundTop
        , inFront <|
            Components.Header.view model
                { msgOnPress = MsgOnPressHamburger
                , msgPushUrl = MsgPushUrl
                }
        , if model.isSmallScreen && model.isSideMenuOpen then
            -- On small devices the menu is overlayed to the content (does
            -- not take own space) and a gray area is added on the right to
            -- cover the content underneath. If the gray area is clicked,
            -- the menu get closed.
            inFront <|
                el
                    [ width fill
                    , htmlAttribute <| Html.Attributes.style "height" <| "calc(100vh - " ++ String.fromInt pixelsHeader ++ "px)"
                    , moveDown pixelsHeader
                    , Background.color Shared.color.opaqueCover
                    , htmlAttribute <| Html.Events.onClick MsgOnPressHamburger
                    ]
                    (text "")

          else
            inFront none
        , inFront <|
            column
                [ width <| px widthSideMenu
                , htmlAttribute <| Html.Attributes.style "height" <| "calc(100vh - " ++ String.fromInt pixelsHeader ++ "px)"
                , moveDown pixelsHeader
                , scrollbars
                , Background.color Shared.color.backgroundTop
                ]
                (viewSideMenu model)
        ]
        (column
            [ paddingEach { bottom = 0, left = paddingLeftBody, right = 0, top = pixelsHeader }
            , Background.color Shared.color.backgroundBelow
            , width fill
            , height fill
            ]
            (viewBody model)
        )


viewSideMenu : Model -> List (Element Msg)
viewSideMenu model =
    if model.isSmallScreen && not model.isSideMenuOpen then
        -- Hiding the menu completely on small devices
        []

    else
        [ el
            -- ([ scrollbars
            -- , htmlAttribute <| Html.Attributes.style "height" <| "calc(100vh - " ++ String.fromInt pixelsHeader ++ "px)"
            ([ width fill
             ]
                ++ (if False then
                        -- On small devices the menu is overlayed to the content (does
                        -- not take own space) and a gray area is added on the right to
                        -- cover the content underneath. If the gray area is clicked,
                        -- the menu get closed.
                        [ htmlAttribute <| Html.Attributes.style "position" "fixed"
                        , htmlAttribute <| Html.Attributes.style "z-index" "1"
                        , htmlAttribute <| Html.Attributes.style "top" "63px"
                        , behindContent <|
                            el
                                [ Background.color Shared.color.opaqueCover
                                , htmlAttribute <| Html.Attributes.style "position" "fixed"
                                , htmlAttribute <| Html.Attributes.style "top" "63px"
                                , htmlAttribute <| Html.Attributes.style "right" "0"
                                , htmlAttribute <| Html.Attributes.style "height" <| "calc(100vh - " ++ String.fromInt pixelsHeader ++ "px)"
                                , htmlAttribute <| Html.Attributes.style "width" "calc(100vw - 200px)"
                                , htmlAttribute <| Html.Events.onClick MsgOnPressHamburger
                                ]
                            <|
                                text ""
                        ]

                    else
                        []
                   )
            )
            (Components.SideMenu.view model { msgPushUrl = MsgPushUrl })
        ]


viewBody : Model -> List (Element Msg)
viewBody model =
    [ column
        [ -- , htmlAttribute <| Html.Attributes.style "height" <| "calc(100vh - " ++ String.fromInt pixelsHeader ++ "x)"
          padding 20
        , spacing 40
        , width fill
        , height fill
        , Font.size 16
        ]
        [ viewPage model
        , Components.Footer.view
        ]
    ]


viewPage : Model -> Element Msg
viewPage model =
    case model.route of
        Route.Cards ->
            map MsgPageCards <| Pages.Cards.view model.pageCardsModel

        Route.Clock ->
            map MsgPageClock <| Pages.Clock.view model.pageClockModel

        Route.Counter ->
            Pages.Counter.view
                { counter = model.counter
                , msgDecrement = MsgCounterDecrement
                , msgIncrement = MsgCounterIncrement
                , msgReset = MsgCounterReset
                }

        Route.CatsFacts ->
            map MsgPageCatsFacts <| Pages.CatsFacts.view model.pageCatsFactsModel

        Route.Geolocation ->
            map MsgPageGeolocation <| Pages.Geolocation.view model.pageGeolocationModel

        Route.Home ->
            Pages.Home.view model

        Route.Todos ->
            map MsgPageTodos <| Pages.Todos.view model.pageTodoModel
