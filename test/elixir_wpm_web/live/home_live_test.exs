defmodule ElixirWPMWeb.HomeLiveTest do
	use ElixirWPMWeb.ConnCase
	alias ElixirWPMWeb.HomeLive
  import ElixirWPM.AccountsFixtures


  test "mount/3", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to ElixirWPM"
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Welcome to ElixirWPM"
  end

  test "mount/3 with logged in user", %{conn: conn} do
    player = user_fixture()
    conn = conn |> log_in_user(player)
    {:ok, view, html} = live(conn, "/")
  end


end
