module CityParking.Fragments.SideSeats exposing (SideSeats, decoder)

{-| 
This file is generated from src/CityParking.gql using `elm-gql`

Please avoid modifying directly.



@docs decoder, SideSeats


-}


import GraphQL.Engine
import Json.Decode


type alias SideSeats =
    { rightRow : Int, leftRow : Int }


decoder start_ =
    start_
        |> GraphQL.Engine.versionedJsonField 0 "rightRow" Json.Decode.int
        |> GraphQL.Engine.versionedJsonField 0 "leftRow" Json.Decode.int


