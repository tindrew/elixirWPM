defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers

  # @my_string "Enum.map(element fn elem -> elem + 1 end)"
  #TODO: use send_after
  #TODO: convert snippet to a list

  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, text_input: "", snippet: "Enum.map(element fn elem -> elem + 1 end)" )}
  end

  def render(assigns) do
    ~H"""

    <h3 class="text-xl font-bold"><%= @snippet %></h3>

    <%!-- <p><b>Here is something that changes:</b>
       <%= assigns.new_data %>
    </p> --%>

    <.form let={f} phx-submit="submit"  phx-change="change" for={:textinput}>
      <%= text_input f, :name,  value: @text_input, class: " rounded-lg border-transparent flex-1
       appearance-none border border-gray-300 w-full py-2 px-4 bg-white text-gray-700
        placeholder-gray-400 shadow-sm text-base focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"%>
    </.form>

    """

  end

  def handle_event("submit", form_data, socket) do
    # IO.inspect(form_data)
    # IO.inspect(Map.fetch(form_data, "textinput"))
    text_input = form_data["textinput"]["name"]
    IO.inspect(text_input)
    IO.inspect(@my_string)
    IO.inspect(socket)
    if text_input == socket.assigns.snippet do
      IO.inspect("some text")
      {:noreply, assign(socket, snippet: "Enum.map(map, fn {k, v} -> {k, v * 2} end)", text_input: "")}

    else
      {:noreply, socket}
    end
    #list of snippets
    #start timer
    #user finishes typing
    #if snippet matches form data, after a few seconds change snippet

    # Take a list of snippets and cycle through them based on a timer.
    #start the timer on first keystroke in the form
    # End the timer when the form data matches the snippet
  end

  def handle_event("change", form_data, socket) do
    text_input = form_data["textinput"]["name"]

    {:noreply, assign(socket, text_input: text_input)}
  end


end
