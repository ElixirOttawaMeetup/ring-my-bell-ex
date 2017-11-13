defmodule RingMyBellExWeb.DoorsController do
  use RingMyBellExWeb, :controller

  def show(conn, %{"id" => id}) do
    render conn, :show, id: id
  end
end
