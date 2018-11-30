defmodule Memes do
  use Application
  use Supervisor

  def start() do
    start([], [])
  end

  def start(_type, _args) do
    children = [
      worker(Memes.Server, []),
      worker(Memes.Stack, [[name: :meme_stack]]),
      worker(Memes.GServer, [[name: :meme_genserver]])
    ]

    opts = [strategy: :one_for_one, name: Memes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
