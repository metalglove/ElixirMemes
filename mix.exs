defmodule Memes.MixProject do
  use Mix.Project

  def project do
    [
      app: :memes,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      applications: [:httpotion] ,
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.1.0"}, #https://github.com/myfreeweb/httpotion
      {:floki, "~> 0.20.0"}, #https://github.com/myfreeweb/httpotion
    ]
  end
end
