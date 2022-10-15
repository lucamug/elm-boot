module Pages.Home exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Shared


codeAttrs : List (Attribute msg)
codeAttrs =
    [ Shared.fontCode
    , Font.bold
    , Border.color <| rgba255 17 123 180 0.5
    , Background.color <| rgba255 17 123 180 0.1
    , paddingEach { bottom = 0, left = 3, right = 3, top = 0 }
    , Border.width 1
    , Border.rounded 4
    ]


code : String -> Element msg
code string =
    el codeAttrs <| text string


view : { a | env : Shared.Env, isSmallScreen : Bool } -> Element msg
view args =
    let
        largeSpacing : Int
        largeSpacing =
            if args.isSmallScreen then
                15

            else
                30
    in
    column
        [ spacing largeSpacing
        , centerX
        , height fill
        , Border.rounded 10
        , width (fill |> maximum 900)
        ]
        ([]
            ++ viewHelloThere args largeSpacing
            ++ viewVariables args
            ++ viewWhatsNext largeSpacing
            ++ viewHappyCoding
        )


viewHelloThere : { b | env : { a | serviceName : String } } -> Int -> List (Element msg)
viewHelloThere args largeSpacing =
    [ column [ paddingEach { bottom = 0, left = largeSpacing, right = 0, top = largeSpacing }, spacing 10 ]
        [ paragraph [ Font.size 24 ] [ text "Hello there," ]
        , paragraph [ Shared.fontTitle, Font.size 60, Font.bold ]
            [ el [ Font.size 40 ] <| text "Welcome "
            , text <| Shared.prettify args.env.serviceName ++ " 👋"
            ]
        , paragraph [ Font.size 18 ] [ text "✅ You're up and running" ]
        ]
    ]


viewVariables : { b | env : Shared.Env } -> List (Element msg)
viewVariables args =
    [ column
        (spacing 15 :: Shared.card)
        [ row [] [ el [ alignTop, width <| px 140 ] <| text "Repo name: ", paragraph [ spacing 10 ] [ code args.env.repoName ] ]
        , row [] [ el [ alignTop, width <| px 140 ] <| text "Branch name: ", paragraph [ spacing 10 ] [ code args.env.branchName ] ]
        , row [] [ el [ alignTop, width <| px 140 ] <| text "Commit hash: ", paragraph [ spacing 10 ] [ code args.env.commitHash ] ]
        , row [] [ el [ alignTop, width <| px 140 ] <| text "OS Type: ", paragraph [ spacing 10 ] [ code args.env.osType ] ]
        ]
    ]


viewWhatsNext : Int -> List (Element msg)
viewWhatsNext largeSpacing =
    [ paragraph
        [ Font.size 34
        , Font.bold
        , paddingEach { bottom = 0, left = largeSpacing, right = 0, top = 0 }
        , moveDown 10
        , Shared.fontTitle
        ]
        [ text "What's next?" ]
    , column (Shared.card ++ [ spacing 30 ])
        [ paragraph [] [ text "Edit any Elm file in your favorite editor. Any modification done to the code will be automatically hot-reloaded in the browser." ]
        ]
    ]


viewHappyCoding : List (Element msg)
viewHappyCoding =
    [ column (Shared.card ++ [ spacing 50 ])
        [ paragraph [ Font.center ]
            [ text "For more info, check "
            , newTabLink Shared.linkAttrsInline
                { label = text "the README of the elm-boostrap repository"
                , url = "https://github.com/lucamug/elm-boot"
                }
            , text "."
            ]
        , paragraph [ Shared.fontTitle, Font.center, Font.size 40 ] [ text "😃 Happy Coding! 😃" ]
        ]
    ]
