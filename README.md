# Memes


```elixir
#first get the dependencies and compile
mix deps.get, compile

#then run it!
iex -S mix

#start the server 
Memes.start()

#the server will first fetch 10 memes to the cache (stack).
will count from 1 to 10...

#open a webbrowser and go to http://localhost:8880/getRandomMeme
#success result
{
  "data":
  {
    "id":"abYXZbr",
    "imgUrl":"https://images-cdn.9gag.com/photo/abYXZbr_700b.jpg",
    "pageUrl":"http://9gag.com/gag/abYXZbr",
    "title":"God is listening"
  },
  "status":"success"
}
#failed result
{
  "data":
  {
    "error (reason)"
  },
  "status":"failed"
}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `memes` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:memes, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/memes](https://hexdocs.pm/memes).

