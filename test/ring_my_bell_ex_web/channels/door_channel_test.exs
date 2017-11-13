defmodule RingMyBellExWeb.DoorChannelTest do
  use RingMyBellExWeb.ChannelCase

  alias RingMyBellExWeb.DoorChannel

  setup do
    name = Faker.Code.iban
    client_id = Faker.String.base64
    {:ok, _, socket} =
      socket("user_id", %{client_id: client_id})
      |> subscribe_and_join(DoorChannel, "door:" <> name)
    {:ok, socket: socket, name: name, client_id: client_id}
  end

  test "ring sends a broadcast to all clients", %{socket: socket, client_id: client_id} do
    push socket, "ring", %{"client_id" => client_id}
    assert_broadcast "ring", %{}
  end

end