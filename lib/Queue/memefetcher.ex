defmodule Memes.MemeFetcher do
  @moduledoc """
  MemeFetcher is a module for spawning new process to fetch a meme.
  """

  @doc """
  Fetches a meme and sends it to back to the listen process.
  """
  def fetch(receiver) do
    result = Memes.Service.fetchRandomMeme()
    IO.puts("[#{inspect self()}] fetched a new meme!")
    send(receiver, {:ok, self(), %{ result: result, receiver: receiver }}) 
  end

  @doc """
  Listens for calls and pushes Memes on the stack
  """
  def listen() do
    receive do
      {:ok, sender, wrappedmeme} ->
        IO.puts("[#{inspect self()}] Received meme from #{inspect sender}")
        if wrappedmeme.result.status == :success do
          pid = Process.whereis(:meme_stack)
          Memes.Stack.push(pid, wrappedmeme.result.data)
        else
          Memes.MemeFetcher.fetch(wrappedmeme.receiver)
        end
    end
    listen()
  end
end