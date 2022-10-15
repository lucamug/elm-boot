module Components.Header exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Route
import Shared


view :
    { a
        | env : { b | serviceName : String }
        , isSideMenuOpen : Bool
        , navigationModality : Shared.NavigationModality
    }
    ->
        { msgOnPress : msg
        , msgPushUrl : String -> msg
        }
    -> Element msg
view args args2 =
    let
        locationHref : String
        locationHref =
            Route.toLocationHref args.navigationModality Route.Home
    in
    row
        [ spacing 15
        , Background.color Shared.color.backgroundTop
        , width fill
        , paddingEach { bottom = 8, left = 24, right = 10, top = 8 }
        ]
        [ Input.button []
            { label =
                el [ Font.size 28, moveUp 4 ] <|
                    text <|
                        if args.isSideMenuOpen then
                            "☰"

                        else
                            "☰"
            , onPress = Just args2.msgOnPress
            }
        , link
            [ htmlAttribute <| Shared.preventDefault (args2.msgPushUrl locationHref) ]
            { label =
                row [ spacing 15, Shared.fontTitle, Font.bold ]
                    [ row [ spacing 2 ]
                        [ el [ Font.size 28 ] <| text <| Shared.prettify args.env.serviceName
                        ]
                    ]
            , url = locationHref
            }
        ]
