defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers
  alias ElixirWPM.Snippets

  @default_snippet "Enum.map(element fn elem -> elem + 1 end)"
  @initial_timer 3
  def mount(_params, _sessions, socket) do
    {:ok,
     assign(socket,
       css_block: "hidden",
       session_timer: @initial_timer,
       submitted_snippets: 0,
       words_per_minute: 0,
       text_input: "",
       playing: false,
       snippet: @default_snippet
     )}
  end

  def render(assigns) do
    ~H"""
    <section class="flex flex-col bg-red-400 h-screen w-screen justify-center items-center">
    <h2 class="text-3xl font-bold">Welcome to ElixirWPM</h2>
    <h3 class="text-indigo-500 text-2xl font-bold">Start the game by typing the snippet!</h3>


    <.my_table snippet={@snippet} session_timer={@session_timer} submitted_snippets={@submitted_snippets} words_per_minute={@words_per_minute} />

    <%= if @session_timer == 0 do %>
      <button  phx-click="restart" type="button" id="start-button" class=" mt-6 py-4 px-6  bg-indigo-600 hover:bg-indigo-700
              focus:ring-indigo-500 focus:ring-offset-indigo-200 text-white transition ease-in duration-200
              text-center text-base font-semibold shadow-md focus:outline-none focus:ring-2 focus:ring-offset-2 rounded-lg {{css_block}}"
                                  >
        Play again!
      </button>

      <% else %>

      <.form let={f} phx-submit="submit"  phx-change="change" for={:textinput} autocomplete="off">
      <%= text_input f, :name,  value: @text_input, class: " rounded-lg border-transparent flex-1
       appearance-none border border-gray-300 w-full py-2 px-4 bg-white text-gray-700
        placeholder-gray-400 shadow-sm text-base focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"%>
    </.form>
    <% end %>
    </section>
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
    socket =
      if !socket.assigns.playing do
        {:ok, timer} = :timer.send_interval(:timer.seconds(1), self(), :tick)
        assign(socket, timer: timer, playing: true)
      else
        socket
      end

    elapsed_time = 60.0
    text_input = form_data["textinput"]["name"] |> IO.inspect()

    word_count = String.length(text_input) / 5

    minutes = elapsed_time / 60.0
    words_per_minute = (word_count / minutes) |> round
    IO.inspect(words_per_minute)

    {:noreply, assign(socket, text_input: text_input, words_per_minute: words_per_minute)}
  end

  ##### Handles button click #######
  ###### restarts timer on click #######
  def handle_event("restart", _, socket) do
    if socket.assigns.session_timer <= 0 do
      {:noreply,
       assign(socket, session_timer: @initial_timer, submitted_snippets: 0, text_input: "")}
    end
  end

  def handle_info(:tick, socket) do
    socket =
      case socket.assigns.session_timer do
        0 ->
          :timer.cancel(socket.assigns.timer)
          assign(socket, playing: false)

        _ ->
          assign(socket, session_timer: socket.assigns.session_timer - 1)
      end

    {:noreply, socket}
  end

  def my_table(assigns) do
    ~H"""
    <section >
    <table >
      <tr>
        <td>
          Current WPM goes here
          <h2><%= @words_per_minute %></h2>
          <br>
          Score History goes here
        </td>
        <td class="flex flex-col justify-center items-center">
          <h3 class="text-4xl font-bold"><%= @snippet %></h3>



          <h2 class="text-xl font-bold"><%= @submitted_snippets * 100 %> </h2>

          <br>
            Highscore goes here
          </td>
        <td>
          Session Time
          <h2 class="text-xl font-bold"><%= @session_timer %> </h2>
        </td>
      </tr>
    </table>
    </section>
    """
  end
end

# raw words per minute is a calculation of how fast you type with no errors
# a "word" is any five characters. spaces, numbers, letters and punctuation are all included
# edge cases: function keys or anything not a number, letter, space, or punctuation should be excluded
# count number of characters typed. divide by 5
# divide number of mistakes by total of typed characters

# start = DateTime.now!("Etc/UTC")
# finish = DateTime.now!("Etc/UTC")
# minutes = DateTime.diff(finish, start) |> div(60)
# IO.inspect(minutes)

# jaro distance?
