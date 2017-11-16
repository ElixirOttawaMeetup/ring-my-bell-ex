defmodule RingMyBellExWeb.DoorChannel do
  @moduledoc """
  The main channel which the organizers communicate with the waiters.

  See the sequence diagram for details on the communication:

  ![main_sequence](main_sequence.png)
  """
  use Phoenix.Channel

  def join("door:" <> _private_room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("coming", payload, socket) do
    "door:" <> door = socket.topic
    RingMyBellEx.BellAgent.clear_ringers(door)
    broadcast! socket, "coming", payload
    {:noreply, socket}
  end

  def handle_in("ring", %{"client_id" => client_id} = payload, socket) do
    "door:" <> door = socket.topic
    RingMyBellEx.BellAgent.add_ringer(door, client_id)
    broadcast! socket, "ring", payload
    {:noreply, socket}
  end
end
