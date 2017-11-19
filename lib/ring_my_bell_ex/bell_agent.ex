defmodule RingMyBellEx.BellAgent do

  def start_link() do
    Agent.start_link(&RingMyBellEx.CacheAgent.get_cache/0, name: __MODULE__)
  end

  @doc "Adds a ringer to a door"
  def add_ringer(door, client_id) do
    state = Agent.update(__MODULE__, fn state ->
      Map.update(state, door, MapSet.new([client_id]), &(MapSet.put(&1, client_id)))
    end)
    update_cache()
    state
  end

  @doc "Removes all ringers for a door"
  def clear_ringers(door) do
    state = Agent.update(__MODULE__, &Map.put(&1, door, MapSet.new))
    update_cache()
    state
  end

  @doc "list all ringers from a door"
  def list_ringers(door) do
    case Agent.get(__MODULE__, fn state -> state[door] end) do
      nil -> []
      list -> MapSet.to_list(list)
    end
  end

  defp update_cache() do
    Agent.get(__MODULE__, &RingMyBellEx.CacheAgent.set_cache/1)
  end

end
