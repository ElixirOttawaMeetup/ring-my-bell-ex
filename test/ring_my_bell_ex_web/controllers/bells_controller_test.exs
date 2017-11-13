defmodule RingMyBellExWeb.BellsControllerTest do
  use RingMyBellExWeb.ConnCase

  setup do
    name = Faker.Code.iban
    {:ok, conn: build_conn(), name: name}
  end

  describe "creating a new bell " do

    test "GET /bells/new", %{conn: conn} do
      conn = get conn, "/bells/new"
      assert html_response(conn, 200) =~ "Create a new bell"
    end

    test "POST /bells redirects to to /bells/:id", %{conn: conn, name: name} do
       conn = post conn, "/bells", %{bell: %{name: name}}
       assert html_response(conn, 302)
       assert redirected_to(conn) =~ "/bells/" <> name
    end

  end

  describe "viewing a bell " do

    test "GET /bells/show/:id", %{conn: conn, name: name} do
      conn = get conn, "/bells/" <> name
      assert html_response(conn, 200) =~ name
    end

  end


end
