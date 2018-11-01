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
      #extra_applications: [:logger],
      applications: [:logger, :httpotion, :floki, :maru, :jason, :distillery],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.1.0"},
      {:floki, "~> 0.20.0"}, 
      {:maru, "~> 0.13"},
      {:cowboy, "~> 2.3"},
      {:jason, "~> 1.1"},
      {:distillery, "~> 2.0"},
      {:plug_cowboy, "~> 2.0"},
    ]
  end
end
