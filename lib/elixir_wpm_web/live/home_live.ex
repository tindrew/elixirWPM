defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers

  def render(assigns) do
    ~H"""
    <h3>Enum.map(element fn elem -> elem + 1 end)</h3>
    <.form let={f} phx-change="change" for={:textinput}>
      <%= text_input f, :name %>
    </.form>
    <%!-- cond do
      Map.fetch(form_data, "textinput") == "s" -> "Hello!"
    end --%>

    """

  end

  def handle_event("change", form_data, socket) do
    IO.inspect(form_data)
    {:noreply, socket}
    IO.inspect(Map.fetch(form_data, "textinput"))
    #get form data
    #get code snippet
    # compare against code snippet

  end

  #got a form
  #

end
