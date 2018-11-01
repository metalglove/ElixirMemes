use Mix.Config

config :memes, Memes.Server,
    adapter: Plug.Adapters.Cowboy2,
    plug: Memes.API,
    scheme: :http,
    port: 8880

config :memes,
    maru_servers: [Memes.Server]