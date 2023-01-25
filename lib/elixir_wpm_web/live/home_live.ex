defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers
  alias ElixirWPM.Snippets

  @default_snippet "Enum.map(element fn elem -> elem + 1 end)"

  def mount(_params, _sessions, socket) do
    {:ok,
     assign(socket, count: 60, submitted_snippets: 0, text_input: "", snippet: @default_snippet)}
  end

  def render(assigns) do
    ~H"""

    <h3 class="text-xl font-bold"><%= @snippet %></h3>

    <h2 class="text-xl font-bold"><%= @count %> </h2>

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

    if text_input == socket.assigns.snippet do
      IO.inspect("some text")

      {:noreply,
       assign(socket,
         submitted_snippets: socket.assigns.submitted_snippets + 1,
         snippet: Snippets.random(),
         text_input: ""
       )}
    else
      {:noreply, socket}
    end
  end

  def handle_event("change", form_data, socket) do
    if String.length(form_data["textinput"]["name"]) == 1 &&
         socket.assigns.submitted_snippets == 0 do
      :timer.send_interval(1000, self(), :tick)
    end

    text_input = form_data["textinput"]["name"]

    {:noreply, assign(socket, text_input: text_input)}
  end

  def handle_info(:tick, socket) do
    if socket.assigns.count > 0 do
      {:noreply, assign(socket, count: socket.assigns.count - 1)}
    else
      {:noreply, assign(socket, count: socket.assigns.count)}
    end
  end
end
