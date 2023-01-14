module CityParking.TestBuses exposing (Buses, Response, Seats, query)

{-| 
This file is generated from src/CityParking.gql using `elm-gql`

Please avoid modifying directly.


@docs Response

@docs query

@docs Seats, Buses


-}


import Api
import CityParking.Fragments.SideSeats
import GraphQL.Engine
import Json.Decode


query : Api.Query Response
query =
    GraphQL.Engine.bakeToSelection
        (Just "TestBuses")
        (\version_ ->
            { args = []
            , body = toPayload_ version_
            , fragments = toFragments_ version_
            }
        )
        decoder_


{-  Return data  -}


type alias Response =
    { buses : List Buses }


type alias Buses =
    { id : Int, name : String, rows : Int, seats : Seats }


type alias Seats =
    { front : Int, leftRow : Int, rightRow : Int, back : Int }


decoder_ : Int -> Json.Decode.Decoder Response
decoder_ version_ =
    Json.Decode.succeed Response
        |> GraphQL.Engine.versionedJsonField
            version_
            "buses"
            (Json.Decode.list
                (Json.Decode.succeed Buses
                    |> GraphQL.Engine.versionedJsonField 0 "id" Json.Decode.int
                    |> GraphQL.Engine.versionedJsonField
                        0
                        "name"
                        Json.Decode.string
                    |> GraphQL.Engine.versionedJsonField
                        0
                        "rows"
                        Json.Decode.int
                    |> GraphQL.Engine.versionedJsonField
                        0
                        "seats"
                        (Json.Decode.succeed Seats
                            |> GraphQL.Engine.versionedJsonField
                                0
                                "front"
                                Json.Decode.int
                            |> CityParking.Fragments.SideSeats.decoder
                            |> GraphQL.Engine.versionedJsonField
                                0
                                "back"
                                Json.Decode.int
                        )
                )
            )


toPayload_ : Int -> String
toPayload_ version_ =
    ((GraphQL.Engine.versionedAlias version_ "buses"
        ++ """ {id
name
rows
seats {front

..."""
     )
        ++ GraphQL.Engine.versionedName version_ "SideSeats"
    )
        ++ """
back } }"""


toFragments_ : Int -> String
toFragments_ version_ =
    String.join
        """
"""
        [ ("fragment " ++ GraphQL.Engine.versionedName version_ "SideSeats")
            ++ """ on Seats {rightRow
leftRow }"""
        ]


