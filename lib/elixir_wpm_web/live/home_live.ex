defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers

  def render(assigns) do
    ~H"""
    <h3><%= snippet = "Enum.map(element fn elem -> elem + 1 end)" %></h3>
    <.form let={f} phx-change="change" for={:textinput}>
      <%= text_input f, :name %>
    </.form>
    <%!-- cond do
      Map.fetch(form_data, "textinput") == "s" -> "Hello!"
    end --%>

    """

  end

  def handle_event("change", form_data, socket) do
    # IO.inspect(form_data)
    # IO.inspect(Map.fetch(form_data, "textinput"))
    text_input = form_data["textinput"]["name"]
    IO.inspect(text_input)
    {:noreply, socket}


    #convert form data to a string?
    #get code snippet
    # compare against code snippet

  end


end
