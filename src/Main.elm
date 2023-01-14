module Main exposing (..)

import Api
import Browser
import CityParking.ControlBuses
import CityParking.TestBuses
import CityParking.TestBusesSecond
import GraphQL.Engine
import Html exposing (Html)
import Html.Attributes as Attrs


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { controlBuses : GqlResult CityParking.ControlBuses.Response
    , testBuses : GqlResult CityParking.TestBuses.Response
    , testBuses2 : GqlResult CityParking.TestBusesSecond.Response
    }


type GqlResult a
    = Loading
    | Success a
    | Failure


type alias Bus =
    { id : Int
    , name : String
    , rows : Int
    , seats :
        { front : Int
        , leftRow : Int
        , rightRow : Int
        , back : Int
        }
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { controlBuses = Loading
      , testBuses = Loading
      , testBuses2 = Loading
      }
    , Cmd.batch
        [ fetchControlBuses
        , fetchTestBuses
        , fetchTestBuses2
        ]
    )



-- VIEW


view : Model -> Browser.Document msg
view model =
    { title = "City Parking"
    , body =
        [ Html.h1 [] [ Html.text "Buses parked at the city parking 🙂" ]
        , Html.main_ [ Attrs.class "side-by-side" ]
            [ Html.div []
                [ Html.h2 [] [ Html.text "Control query" ]
                , viewQueryResult model.controlBuses
                ]
            , Html.div []
                [ Html.h2 [] [ Html.text "Test query" ]
                , viewQueryResult model.testBuses
                ]
            , Html.div []
                [ Html.h2 [] [ Html.text "Test query #2" ]
                , viewQueryResult model.testBuses2
                ]
            ]
        ]
    }


viewQueryResult : GqlResult { buses : List Bus } -> Html msg
viewQueryResult query =
    case query of
        Loading ->
            Html.text "Loading..."

        Failure ->
            Html.text "Query failed :("

        Success response ->
            viewBuses response.buses


viewBuses : List Bus -> Html msg
viewBuses buses =
    if List.isEmpty buses then
        Html.p [] [ Html.text "No buses parked" ]

    else
        Html.div [] <|
            List.map viewBus buses


viewBus : Bus -> Html msg
viewBus bus =
    Html.section []
        [ Html.h3 [] [ Html.text ("Bus with id " ++ String.fromInt bus.id) ]
        , Html.ul []
            [ viewField "Name" bus.name
            , viewField "Rows" (String.fromInt bus.rows)
            , Html.li []
                [ Html.b [] [ Html.text "Seats" ]
                , Html.ul [] <|
                    [ viewIntField "Front row" bus.seats.front
                    , viewIntField "Left row" bus.seats.leftRow
                    , viewIntField "Right row" bus.seats.rightRow
                    , viewIntField "Back row" bus.seats.back
                    ]
                ]
            ]
        ]


viewIntField : String -> Int -> Html msg
viewIntField name number =
    viewField name (String.fromInt number)


viewField : String -> String -> Html msg
viewField name value =
    Html.li []
        [ Html.b [] [ Html.text (name ++ " ") ]
        , Html.text value
        ]



-- UPDATE


type Msg
    = ControlBusesFetched (Result GraphQL.Engine.Error CityParking.ControlBuses.Response)
    | TestBusesFetched (Result GraphQL.Engine.Error CityParking.TestBuses.Response)
    | TestBuses2Fetched (Result GraphQL.Engine.Error CityParking.TestBusesSecond.Response)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ControlBusesFetched (Ok buses) ->
            ( { model | controlBuses = Success buses }, Cmd.none )

        ControlBusesFetched (Err _) ->
            ( { model | controlBuses = Failure }, Cmd.none )

        TestBusesFetched (Ok buses) ->
            ( { model | testBuses = Success buses }, Cmd.none )

        TestBusesFetched (Err _) ->
            ( { model | testBuses = Failure }, Cmd.none )

        TestBuses2Fetched (Ok buses) ->
            ( { model | testBuses2 = Success buses }, Cmd.none )

        TestBuses2Fetched (Err _) ->
            ( { model | testBuses2 = Failure }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- GRAPHQL


request :
    (Result GraphQL.Engine.Error data -> msg)
    -> Api.Query data
    -> Cmd msg
request toMsg query =
    Api.query query
        { headers = []
        , url = "http://localhost:4000/graphql"
        , timeout = Nothing
        , tracker = Nothing
        }
        |> Cmd.map toMsg


fetchControlBuses : Cmd Msg
fetchControlBuses =
    request ControlBusesFetched CityParking.ControlBuses.query


fetchTestBuses : Cmd Msg
fetchTestBuses =
    request TestBusesFetched CityParking.TestBuses.query


fetchTestBuses2 : Cmd Msg
fetchTestBuses2 =
    request TestBuses2Fetched CityParking.TestBusesSecond.query
