module CityParking.Fragments.Seats exposing (Seats, decoder)

{-| 
This file is generated from src/CityParking.gql using `elm-gql`

Please avoid modifying directly.



@docs decoder, Seats


-}


import GraphQL.Engine
import Json.Decode


type alias Seats =
    { front : Int, back : Int, leftRow : Int, rightRow : Int }


decoder start_ =
    start_
        |> GraphQL.Engine.versionedJsonField 0 "front" Json.Decode.int
        |> GraphQL.Engine.versionedJsonField 0 "back" Json.Decode.int
        |> GraphQL.Engine.versionedJsonField 0 "leftRow" Json.Decode.int
        |> GraphQL.Engine.versionedJsonField 0 "rightRow" Json.Decode.int


