module Shared exposing
    ( Env
    , NavigationModality(..)
    , card
    , cardTop
    , color
    , fontCode
    , fontTitle
    , linkAttrsInline
    , prettify
    , preventDefault
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import String.Extra


type alias Env =
    { baseHref : String
    , branchName : String
    , commitHash : String
    , osType : String
    , repoName : String
    , serviceName : String
    , tenantName : String
    }


color : { backgroundBelow : Color, backgroundMiddle : Color, backgroundTop : Color, opaqueCover : Color }
color =
    { backgroundBelow = rgb 0.9 0.9 0.9
    , backgroundMiddle = rgb 0.95 0.95 0.95
    , backgroundTop = rgb 1 1 1
    , opaqueCover = rgba 0 0 0 0.5
    }


card : List (Attribute msg)
card =
    [ Border.width 0
    , Border.rounded 10
    , Border.shadow { blur = 10, color = rgba 0 0 0 0.2, offset = ( 0, 0 ), size = 0 }
    , Background.color <| color.backgroundMiddle
    , padding 20
    , width fill
    ]


cardTop : List (Attribute msg)
cardTop =
    card ++ [ Background.color <| color.backgroundTop ]


type NavigationModality
    = NavigationByFragment
    | NavigationByPath


linkAttrsInline : List (Attribute msg)
linkAttrsInline =
    [ mouseOver
        [ Background.color <| rgba255 17 123 180 0.1
        , Border.color <| rgba255 17 123 180 0.5
        , Font.color <| rgb255 0 0 0
        ]
    , htmlAttribute <| Html.Attributes.style "transition" "all .2s ease-out"
    , Font.color <| rgb255 17 123 180
    , Border.width 1
    , Border.rounded 4
    , Border.color <| rgba 1 1 1 0
    , padding 2
    , moveDown 3
    ]


preventDefault : msg -> Html.Attribute msg
preventDefault href =
    Html.Events.preventDefaultOn "click" (Json.Decode.succeed ( href, True ))


fontCode : Attribute msg
fontCode =
    Font.family [ Font.typeface "Fira Code", Font.monospace ]


fontTitle : Attribute msg
fontTitle =
    Font.family [ Font.typeface "Alegreya Sans SC" ]


prettify : String -> String
prettify string =
    string
        |> String.split "-"
        |> List.map String.Extra.toTitleCase
        |> String.join " · "
