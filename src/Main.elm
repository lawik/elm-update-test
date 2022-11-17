module Main exposing (main)

import Browser as Browser exposing (application, Document)
import Browser.Navigation exposing (Key)
import Url exposing (Url)
import Html as Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Blog exposing (BlogPost, samples)
import BlogDetail as BlogDetail

type alias Model =
    { loggedInUsername : Maybe String
    , blogListing : List BlogPost
    , activePost : Maybe BlogPost
    , url : Url
    }

type Msg
    = LogInUsername String
    | ViewPost BlogPost
    | BlogDetailMsg BlogDetail.Msg
    | Noop


main : Program () Model Msg
main =
    application { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = onUrlRequest
    , onUrlChange = onUrlChange
    }

init : () -> Url -> Key -> (Model, Cmd msg)
init _ url _ =
    ( { loggedInUsername = Nothing, blogListing = samples, activePost = Nothing, url = url }, Cmd.none )

view : Model -> Document Msg
view model =
    { title = "sample"
    , body =
        case model.activePost of
            Just post ->
                BlogDetail.view model
                |> Html.map BlogDetailMsg
                |> List.singleton
            Nothing ->
                List.map blogListItem model.blogListing
    }

update : Msg -> Model -> ( Model, Cmd msg)
update msg model =
    case msg of
        LogInUsername name ->
            ( { model | loggedInUsername = Just name }, Cmd.none )
        ViewPost post ->
            ( { model | activePost = Just post }, Cmd.none )
        BlogDetailMsg subMsg ->
            BlogDetail.update subMsg model
        Noop ->
            ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest request =
    Noop

onUrlChange : Url -> Msg
onUrlChange url =
    Noop

blogListItem : BlogPost -> Html Msg
blogListItem post =
    Html.div [ HA.class "post" ]
        [ Html.h2 [ HE.onClick (ViewPost post)] [Html.text post.title]
        , Html.p [] [Html.text post.text]
        ]
