defmodule ElixirWPMWeb.HomeLiveTest do
	use ElixirWPMWeb.ConnCase
  import ElixirWPM.AccountsFixtures


  test "mount/3", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Type a snippet."
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Type a snippet."
  end

  test "mount/3 with logged in user", %{conn: conn} do
    player = user_fixture()
    conn = conn |> log_in_user(player)
    {:ok, view, html} = live(conn, "/")
  end


end
