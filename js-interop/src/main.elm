port module Main exposing (..)
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
    App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model
type alias User =
    { email: String
    , isValid: Bool
    }

init : (User, Cmd Action)
init =
    (User "" False, Cmd.none)

-- Port command
port sendToJS : String -> Cmd action

-- Port subscriptions
port dataFromJS : (Bool -> action) -> Sub action

subscriptions : User -> Sub Action
subscriptions model =
    dataFromJS Submit

-- Update
type Action
    = CheckEmail
    | Submit Bool
    | UpdateEmail String

update msg model =
    case msg of
        CheckEmail -> 
            (model, sendToJS model.email)

        Submit validEmail ->
            ({model | isValid = validEmail}, Cmd.none)

        UpdateEmail email ->
            ({model | email = email}, Cmd.none)

-- View
view : User -> Html Action
view model =
    div [] 
    [ formArea
    , resultArea model
    ]

formArea =
    Html.form [onSubmit CheckEmail]
    [ input [type' "text", placeholder "Email", name "email", onInput UpdateEmail] []
    , input [type' "submit", value "Login"] []
    ]

resultArea model =
    if model.isValid && model.email /= "" then
        div [] [text "Your email is valid"]
    else if model.email == "" then
        div [] []
    else
        div [] [text "Your email is fake"]