module Components.SideMenu exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Route
import Shared


view :
    { a
        | isSideMenuOpen : Bool
        , route : Route.Route
        , navigationModality : Shared.NavigationModality
    }
    -> { msgPushUrl : String -> msg }
    -> Element msg
view args args2 =
    column
        [ width fill ]
        ([ rowMenu args args2 { icon = "⌂", route = Route.Home }
         , rowMenu args args2 { icon = "±", route = Route.Counter }
         , rowMenu args args2 { icon = "🐾", route = Route.CatsFacts }
         , rowMenu args args2 { icon = "📍", route = Route.Geolocation }
         , rowMenu args args2 { icon = "♥", route = Route.Cards }
         , rowMenu args args2 { icon = "🕑", route = Route.Clock }
         , rowMenu args args2 { icon = "✓", route = Route.Todos }
         ]
            ++ (if args.isSideMenuOpen then
                    [ separator

                    -- , navigationModeSelector args.form args2.msgForm
                    ]

                else
                    []
               )
        )


separator : Element msg
separator =
    el
        [ width fill
        , paddingEach { bottom = 0, left = 30, right = 30, top = 20 }
        ]
    <|
        el
            [ Border.widthEach { bottom = 0, left = 0, right = 0, top = 1 }
            , Border.color <| rgba 0 0 0 0.2
            , width fill
            , paddingEach { bottom = 20, left = 0, right = 0, top = 0 }
            ]
            (text "")


rowMenu :
    { a
        | isSideMenuOpen : Bool
        , route : Route.Route
        , navigationModality : Shared.NavigationModality
    }
    -> { b | msgPushUrl : String -> msg }
    ->
        { icon : String
        , route : Route.Route
        }
    -> Element msg
rowMenu args { msgPushUrl } args2 =
    let
        locationHref : String
        locationHref =
            Route.toLocationHref args.navigationModality args2.route
    in
    link
        ([ paddingEach
            { bottom = 10
            , left =
                if args.isSideMenuOpen then
                    28

                else
                    0
            , right = 0
            , top = 10
            }
         , mouseOver [ Background.color Shared.color.backgroundBelow ]
         , width fill
         , htmlAttribute <| Shared.preventDefault (msgPushUrl locationHref)
         ]
            ++ (if args.route == args2.route then
                    [ Background.color Shared.color.backgroundBelow ]

                else
                    []
               )
        )
        { label =
            if args.isSideMenuOpen then
                row [ spacing 26 ]
                    [ el [ width <| px 20, Font.center ] <| text args2.icon
                    , paragraph [ Font.size 13 ]
                        [ text <| Route.toTitle args2.route ]
                    ]

            else
                column [ spacing 5, width fill ]
                    [ el [ centerX, Font.size 26 ] <| text args2.icon
                    , paragraph [ Font.size 12, width fill, Font.center ]
                        [ text <| Route.toTitle args2.route ]
                    ]
        , url = locationHref
        }
