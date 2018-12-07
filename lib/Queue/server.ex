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
      stack_queue(pid, 10)
    end

    meme
  end

  # Stacks the queue with more memes to fetch from.
  defp stack_queue(pid, count) do
    GenServer.cast(pid, {:stack_queue, count})
  end

  ## Server

  def init(:ok) do
    stack_queue(self(), 10)
    {:ok, [], 100}
  end

  def handle_call({:fetch_meme}, _from, state) do
    pid = Process.whereis(:meme_stack)
    {:reply, Memes.Stack.pop(pid), state}
  end

  def handle_cast({:stack_queue, count}, state) do
    fetcher = spawn(Memes.MemeFetcher, :listen, [])
    spawn(fn -> fetch_memes(fetcher, count) end)
    {:noreply, state}
  end

  def handle_info(timeout, state) do
    {:noreply, state}
  end

  defp fetch_memes(fetcher, 0) do
    IO.puts("[#{inspect self()}] done fetching memes!")
    Process.exit(fetcher, :kill)
    :ok
  end

  defp fetch_memes(fetcher, count) do
    IO.puts("[#{inspect self()}] starting to fetch a new meme!")
    Memes.MemeFetcher.fetch(fetcher)
    IO.puts("[#{inspect self()}] memes left to fetch #{count}!")
    fetch_memes(fetcher, count - 1)
  end

end
