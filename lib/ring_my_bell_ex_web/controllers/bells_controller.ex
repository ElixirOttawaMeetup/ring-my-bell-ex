defmodule RingMyBellExWeb.BellsController do
  use RingMyBellExWeb, :controller

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"bell" => %{"name" => name}})  do
    redirect conn, to: Routes.bells_path(conn, :show, name)
  end

  def show(conn, %{"id" => id}) do
    count =
      RingMyBellEx.BellAgent.list_ringers(id)
      |> length
    render conn, :show, id: id, count: count
  end
end
