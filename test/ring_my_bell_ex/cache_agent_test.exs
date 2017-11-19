defmodule RingMyBellEx.CacheAgentTest do
  use ExUnit.Case

  alias RingMyBellEx.CacheAgent

  test "return a cache from agent" do
    assert CacheAgent.set_cache(%{}) == :ok
    assert CacheAgent.get_cache() == %{}
  end

  test "storing state in cache agen" do
    assert CacheAgent.set_cache(%{foo: :bar}) == :ok
    assert CacheAgent.get_cache() == %{foo: :bar}
    CacheAgent.set_cache(%{})
  end

end
