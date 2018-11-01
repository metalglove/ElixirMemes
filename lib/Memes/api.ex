defmodule Memes.API do
  use Memes.Server
  
  before do
    plug Plug.Logger
  end
  
  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Jason,
    parsers: [:urlencoded, :json, :multipart]

  mount Router.Index

  rescue_from Unauthorized, as: e do
    IO.inspect(e)

    conn
    |> put_status(401)
    |> text("Unauthorized")
  end

  rescue_from [MatchError, RuntimeError], with: :custom_error

    rescue_from :all, as: e do
    conn
    |> put_status(Plug.Exception.status(e))
    |> text("Server Error")
  end

  defp custom_error(conn, exception) do
    conn
    |> put_status(500)
    |> text(exception.message)
  end

  namespace :getRandomMeme do
		get do
			json(conn, Memes.Service.fetchRandomMeme())
		end
  end

  
end