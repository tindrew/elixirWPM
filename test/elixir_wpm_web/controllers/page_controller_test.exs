defmodule ElixirWPMWeb.PageControllerTest do
  use ElixirWPMWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Total Score"
  end
end
