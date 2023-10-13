defmodule ConvertexWeb.ConvertControllerTest do
  use ConvertexWeb.ConnCase

  test "POST /convert", %{conn: conn} do
    conn = post(conn, ~p"/convert")
    assert html_response(conn, 200)
  end
end
