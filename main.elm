module Main exposing (main)

import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import Html exposing (..)


-- MODEL


type alias Model =
    { message : String }



-- UPDATE


isEven : Int -> Bool
isEven int =
    int % 2 == 0


toMessage : Result String Bool -> String
toMessage res =
    case res of
        Ok True ->
            "That is an even number"

        Ok False ->
            "That is not an even number"

        Err str ->
            str


checkIsEven : String -> String
checkIsEven =
    String.trim >> String.toInt >> Result.map isEven >> toMessage


type Msg
    = Check String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Check val ->
            { model | message = checkIsEven val }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (model.message) ]
        , input [ placeholder "Enter number to check here", onInput Check ] []
        ]


main : Program Never {message: String} Msg
main =
    Html.beginnerProgram
        { model = { message = "" }
        , view = view
        , update = update
        }
