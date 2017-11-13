defmodule RingMyBellExWeb.DoorChannel do
  use Phoenix.Channel

  def join("door:" <> private_room_id, params, socket) do
    {:ok, socket}
  end

  def handle_in("ring", %{"client_id" => client_id} = payload, socket) do
    broadcast! socket, "ring", payload
    {:noreply, socket}
  end
end
