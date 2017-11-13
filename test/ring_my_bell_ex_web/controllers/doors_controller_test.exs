defmodule RingMyBellExWeb.DoorsControllerTest do
  use RingMyBellExWeb.ConnCase

  describe "viewing a door" do

    test "GET /doors/:id", %{conn: conn} do
      name = Faker.Code.iban
      conn = get conn, "/doors/" <> name
      assert html_response(conn, 200) =~ "Ringing " <> name
    end

  end
end
