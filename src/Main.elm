module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


---- MODEL ----


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



---- UPDATE ----


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
      Name name ->
        { model | name = name }
      Password password ->
        { model | password = password }
      PasswordAgain password ->
        { model | passwordAgain = password }



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , viewInput "text" "Name" model.name Name
        , viewInput "text" "Password" model.password Password
        , viewInput "text" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html Msg
viewValidation model =
    if model.password == model.passwordAgain then
        div [ style "color" "green" ] [ text "OK" ]
    else
        div [ style "color" "red" ] [ text "password didn't match" ]

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }
