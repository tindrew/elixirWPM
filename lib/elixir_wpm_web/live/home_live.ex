defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers

  @my_string "Enum.map(element fn elem -> elem + 1 end)"

  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, :new_data, "" )}
  end

  def render(assigns) do
    ~H"""

    <h3>"Enum.map(element fn elem -> elem + 1 end)"</h3>

    <p><b>Here is something that changes:</b>
       <%= assigns.new_data %>
    </p>

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
    IO.inspect(@my_string)
    IO.inspect(socket)
    if text_input == @my_string do
      IO.inspect("some text")
      {:noreply, assign(socket, :new_data, text_input)}
    else
      {:noreply, socket}
    end

    #convert form data to a string?
    #get code snippet
    # compare against code snippet

  end


end
