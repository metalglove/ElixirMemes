defmodule Memes do
    use Application

    def start(_type, _args) do
        children = [
            Memes.Server
        ]
    
        opts = [strategy: :one_for_one, name: Memes.Supervisor]
        Supervisor.start_link(children, opts)
      end
end