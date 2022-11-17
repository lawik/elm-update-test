module Blog exposing (BlogPost, like, samples)

type alias BlogPost =
    { title : String
    , text : String
    , likes : Int
    , id : Int
    }

like : BlogPost -> BlogPost
like post =
    { post | likes = post.likes + 1 }

samples : List BlogPost
samples =
    [
        { title = "Foo"
        , text = "Lorem ipsum"
        , likes = 1
        , id = 1
        },
        { title = "Bar"
        , text = "Ipsum lipsum"
        , likes = 0
        , id = 2
        },
        { title = "Baz"
        , text = "Njllkljlkjklj"
        , likes = 200
        , id = 3
        }
    ]