defmodule RingMyBellEx.BellAgentTest do
  use ExUnit.Case

  alias RingMyBellEx.{BellAgent, CacheAgent}

  setup do
    door = Faker.Code.iban
    client_id = Faker.String.base64
    {:ok, door: door, client_id: client_id}
  end

  test "add a ringer client id to a door", %{door: door, client_id: client_id} do
    assert BellAgent.add_ringer(door, client_id) == :ok
  end

  test "returns a list of ringers added to a door", %{door: door, client_id: client_id} do
    BellAgent.add_ringer(door, client_id)
    assert BellAgent.list_ringers(door) == [client_id]
  end

  test "returns an empty list of no door exists", %{door: door} do
    assert BellAgent.list_ringers(door) == []
  end

  test "removes all ringers from a door", %{door: door, client_id: client_id} do
    BellAgent.add_ringer(door, client_id)
    assert BellAgent.clear_ringers(door) == :ok
    assert BellAgent.list_ringers(door) == []
  end

  test "saves the state to the cache agent on add_ringer/2", %{door: door, client_id: client_id} do
    CacheAgent.set_cache(%{})
    BellAgent.add_ringer(door, client_id)
    assert Map.has_key?(CacheAgent.get_cache(), door)
  end

  test "loads the state from the cache agent if the process crashes", %{door: door, client_id: client_id} do
    CacheAgent.set_cache(%{})
    BellAgent.add_ringer(door, client_id)
    Agent.stop(BellAgent)
    Process.sleep(1)
    assert BellAgent.list_ringers(door) == [client_id]
  end

end
