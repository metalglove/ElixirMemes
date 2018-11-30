defmodule Memes.GServer do
  use GenServer

  ## Client

  @doc """
  Starts the meme queue
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Fetch a meme from the queue.
  """
  def fetch_meme(pid) do
    %{meme: meme, count: count} = GenServer.call(pid, {:fetch_meme})

    if count <= 5 do
      stack_queue(pid)
    end

    meme
  end

  # Stacks the queue with more memes to fetch from.
  defp stack_queue(pid) do
    GenServer.cast(pid, {:stack_queue})
  end

  ## Server

  def init(:ok) do
    {:ok, [], 100}
  end

  def handle_call({:fetch_meme}, _from, state) do
    pid = Process.whereis(:meme_stack)
    {:reply, Memes.Stack.pop(pid), state}
  end

  def handle_cast({:stack_queue}, state) do
    fetch_memes()
    {:noreply, state}
  end

  def handle_info(timeout, state) do
    fetch_memes()
    {:noreply, state}
  end

  defp fetch_memes() do
    result = Memes.Service.fetchRandomMemes(10)
    pid = Process.whereis(:meme_stack)
    Memes.Stack.pushMany(pid, result)
  end
end
