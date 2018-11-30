defmodule Router.Index do
  use Memes.Server

  get do
    conn |> text("hello there! :D")
  end
end
