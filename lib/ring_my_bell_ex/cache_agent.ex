defmodule RingMyBellEx.CacheAgent do

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc "get cache"
  def get_cache() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  @doc "set cache"
  def set_cache(state) do
    Agent.update(__MODULE__, fn _old_state -> state end)
  end

end
