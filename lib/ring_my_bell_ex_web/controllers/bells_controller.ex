defmodule RingMyBellExWeb.BellsController do
  use RingMyBellExWeb, :controller

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"bell" => %{"name" => name}})  do
    redirect conn, to: Routes.bells_path(conn, :show, name)
  end

  def show(conn, %{"id" => id}) do
    render conn, :show, id: id
  end
end
