defmodule Memes.Stack do
    use GenServer

    ## Client

    def start_link(default) when is_list(default) do
        GenServer.start_link(__MODULE__, [], default)
    end

    def pushMany(pid, [head | tail] = memes) when length(memes) == 1 do 
        GenServer.cast(pid, {:push, [head | tail]})
    end

    def pushMany(pid, [head | tail]) do
        GenServer.cast(pid, {:push, [head | tail]})
        pushMany(pid, tail)
    end
    
    def push(pid, meme) do
        GenServer.cast(pid, {:push, meme})
    end

    def pop(pid) do
        GenServer.call(pid, :pop)
    end

    def info(pid) do
        GenServer.call pid, {:info}
    end
    ## Server
    
    def init(stack) do
        {:ok, stack}
    end

    def handle_call(:pop, _from, [head | tail]) do
        {:reply, %{meme: head |> hd, count: Enum.count(tail)}, tail}
    end

    def handle_cast({:push, meme}, state) do
        {:noreply, [meme | state]}
    end

    def handle_call({:info}, _from, state) do
        {:reply, state, state}
    end

end