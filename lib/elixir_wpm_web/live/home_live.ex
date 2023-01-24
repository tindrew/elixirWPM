defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers

 @snippets [
    "|> Enum.group_by(&(&1.name), &(&1.ids))",
    "|> Enum.map(fn {color, ids} -> %{name: color, ids: List.flatten(ids)} end)",
    "|> Enum.reduce(%{}, fn %{ids: ids, name: name}, acc ->",
    "Map.update(acc, name, ids, fn prev_ids -> prev_ids ++ ids end)",
    "|> Enum.map(fn {color, ids} -> %{name: color, ids: ids} end)",
    "conn |> Plug.Conn.assign(:name, Keyword.get(opts, :name, background_job))",
    "Enum.map(map, fn {k, v} -> {k, v * 2} end)"
  ]

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

    text_input = form_data["textinput"]["name"]
    IO.inspect(text_input)
    IO.inspect(socket)
    if text_input == socket.assigns.snippet do
      IO.inspect("some text")
      {:noreply, assign(socket, snippet: Enum.random(@snippets), text_input: "")}

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
