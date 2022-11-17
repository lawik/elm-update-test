module BlogDetail exposing (view, update, Msg)
import Html as Html
import Html.Attributes as HA
import Html.Events as HE
import Blog exposing (BlogPost, like)
import Html as Html exposing (Html)

type alias Model e =
    { e | activePost : Maybe BlogPost
    }

type Msg
    = Like
    | Noop

update : Msg -> Model e -> ( Model e, Cmd msg )
update msg model =
    case msg of
        Like ->
            let
                updated =
                    model.activePost
                    |> Maybe.map like
            in
            ( { model | activePost = updated}, Cmd.none )
        Noop ->
            ( model, Cmd.none )

view : Model e -> Html Msg
view model =
    model.activePost
    |> Maybe.map (\post ->
        Html.div [ HA.class "post" ]
            [ Html.h2 [] [Html.text post.title]
            , Html.p [] [Html.text post.text]
            , Html.p [] [Html.text (String.fromInt post.likes)]
            , Html.button [ HE.onClick Like] [ Html.text "Like"]
            ]
    )
    |> Maybe.withDefault (Html.text "")
