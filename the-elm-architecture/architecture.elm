import Html exposing (..)

main = ...

-- Model
type alias ThisIsModel = { ... }

-- Update
type Msg = ActionNameOne | ActionNameTwo | ...

update : Msg -> ThisIsModel -> ThisIsModel
update msg model =
    case msg of
        ActionNameOne ->
            ...

        ActionNameTwo ->
            ...

-- View
view : ThisIsModel -> Html Msg
view model =
    ...