defmodule ElixirWPMWeb.AboutLive do
  use ElixirWPMWeb, :live_view
  import Phoenix.LiveView.Helpers


  def mount(_params, _sessions, socket) do
    {:ok, socket}
  end



  def render(assigns) do
    ~H"""
    <h1>HELLO FROM THE ABOUT PAGE!</h1>

    """
  end
end
