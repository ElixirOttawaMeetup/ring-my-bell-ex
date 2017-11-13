defmodule RingMyBellEx.BellAgent do

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc "Adds a ringer to a door"
  def add_ringer(door, client_id) do
    Agent.update(__MODULE__, fn state ->
      Map.update(state, door, MapSet.new([client_id]), &(MapSet.put(&1, client_id)))
    end)
  end

  @doc "Removes all ringers for a door"
  def clear_ringers(door) do
    Agent.update(__MODULE__, &Map.put(&1, door, MapSet.new))
  end

  @doc "list all ringers from a door"
  def list_ringers(door) do
    case Agent.get(__MODULE__, fn state -> state[door] end) do
      nil -> []
      list -> MapSet.to_list(list)
    end
  end

end
