defmodule RingMyBellExWeb.PageController do
  use RingMyBellExWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
