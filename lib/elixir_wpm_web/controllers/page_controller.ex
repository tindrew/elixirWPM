defmodule ElixirWPMWeb.PageController do
  use ElixirWPMWeb, :controller

  def index(conn, _params) do
    render(conn, "index.htmll")
  end
end
