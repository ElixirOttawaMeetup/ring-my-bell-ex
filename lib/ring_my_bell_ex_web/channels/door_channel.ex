defmodule RingMyBellExWeb.DoorChannel do
  use Phoenix.Channel

  def join("door:" <> _private_room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("ring", %{"client_id" => client_id} = payload, socket) do
    "door:" <> door = socket.topic
    RingMyBellEx.BellAgent.add_ringer(door, client_id)
    broadcast! socket, "ring", payload
    {:noreply, socket}
  end
end
