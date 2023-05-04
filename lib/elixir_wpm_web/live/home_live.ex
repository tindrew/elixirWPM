defmodule ElixirWPMWeb.HomeLive do
  use ElixirWPMWeb, :live_view

  import Phoenix.LiveView.Helpers

  alias ElixirWPM.Snippets
  alias ElixirWPM.Leaderboards
  import ElixirWPM.Accounts

  @default_snippet "123"
  @initial_timer 3

  def mount(_params, session, socket) do
    #live session
    player_id = if session["user_token"], do: get_user_by_session_token(session["user_token"]).id
    player_name = if session["user_token"], do: get_user_by_session_token(session["user_token"]).player_name
    {:ok,
     assign(socket,
       session_timer: @initial_timer,
       submitted_snippets: 0,
       words_per_minute: 0,
       text_input: "",
       playing: false,
       snippet: @default_snippet,
       total_score: 0,
       total_word_count: 0,
       player_id: player_id,
       player_name: player_name
     )}
  end

  def render(assigns) do
    ~H"""
    <section class="flex flex-col h-screen w-screen justify-center items-center">
    <h2 class="text-3xl intro_text py-8 px-8 text-slate-gray "> Type a snippet.</h2>
    <h3 class="text-4xl font-monoid-bold snippet_text py-4 "><%= @snippet %></h3>


    <%= if @session_timer == 0 do %>
      <button  phx-click="restart" type="button" id="start-button" class=" mt-6 py-4 px-6  bg-slate-700 hover:bg-slate-500
               text-white transition ease-in duration-200 text-center text-base font-monoid-bold shadow-md focus:outline-none focus:ring-2 focus:ring-offset-2 rounded-bl-lg rounded-tr-lg {{css_block}}"
                                  >
        Play again!
      </button>

      <% else %>

      <.form let={f} phx-submit="submit"  phx-change="change" for={:textinput} autocomplete="off">
      <%= text_input f, :name,  value: @text_input, class: "flex w-full border-transparent
       appearance-none border border-gray-300 py-2 px-4 placeholder-gray-400 text-base focus:outline-none focus:ring-amber-600 focus:border-transparent"%>
    </.form>
    <% end %>
    <.my_table snippet={@snippet} session_timer={@session_timer} submitted_snippets={@submitted_snippets} words_per_minute={@words_per_minute} total_score={@total_score}/>

    </section>
    """
  end

  def handle_event("submit", form_data, socket) do
    text_input = form_data["textinput"]["name"]
    finish = DateTime.utc_now()
    start = socket.assigns.start_time

    if text_input == socket.assigns.snippet do
      snippet_score = socket.assigns.submitted_snippets + 1
      words = String.length(text_input) / 5
      total_word_count = words + socket.assigns.total_word_count
      wpm = calculate_wpm(total_word_count, finish, start)

      {:noreply,
       assign(socket,
         total_word_count: total_word_count,
         submitted_snippets: snippet_score,
         total_score: snippet_score * 1024 + wpm,
         snippet: Snippets.random(),
         words_per_minute: wpm,
         text_input: "",
         finish_time: finish
       )}
    else
      {:noreply, socket}
    end
  end

  def handle_event("change", form_data, socket) do
    start = DateTime.utc_now()

    socket =
      if !socket.assigns.playing do
        {:ok, timer} = :timer.send_interval(:timer.seconds(1), self(), :tick)
        assign(socket, timer: timer, playing: true, start_time: start)
      else
        socket
      end

    text_input = form_data["textinput"]["name"]
    {:noreply, assign(socket, text_input: text_input)}
  end

  def handle_event("restart", _, socket) do
    if socket.assigns.session_timer <= 0 do
      {:noreply,
       assign(socket,
         session_timer: @initial_timer,
         submitted_snippets: 0,
         text_input: "",
         total_word_count: 0
       )}
    end
  end

  def handle_info(:tick, socket) do
    socket =
      case socket.assigns.session_timer do
        0 ->
          start = socket.assigns.start_time
          finish = DateTime.utc_now()
          total_word_count = socket.assigns.total_word_count

          wpm = calculate_wpm(total_word_count, finish, start)

          :timer.cancel(socket.assigns.timer)

          if socket.assigns.player_id do
            Leaderboards.create_player_score(%{
              total_score: socket.assigns.total_score,
              player_id: socket.assigns.player_id,
              player_name: socket.assigns.player_name
            })
          end

          assign(socket, playing: false, words_per_minute: wpm)

        _ ->
          assign(socket, session_timer: socket.assigns.session_timer - 1)
      end

    {:noreply, socket}
  end

  defp calculate_wpm(total_word_count, finish, start_time) do
    time_in_milliseconds = DateTime.diff(finish, start_time, :millisecond)
    time_in_seconds = time_in_milliseconds * 0.001
    words_per_second = total_word_count / time_in_seconds
    (words_per_second * 60) |> round()
  end

  def my_table(assigns) do
    ~H"""
    <section class="flex grid grid-cols-3 gap-10 py-10 w-3/6 my-8">
      <div class="font-monoid w-36 h-36 rounded-full bg-slate-700 flex flex-col items-center justify-center">
        <h3 class="text-khaki-500">WPM</h3>
        <h2 class="text-khaki-500 font-monoid-bold text-3xl"><%= @words_per_minute %></h2>
      </div>
      <div class="font-monoid flex flex-col items-center justify-center">
      <%!-- <h3>Snippets</h3>
      <h2 class="text-xl font-bold bg-red-500"><%= @submitted_snippets %> </h2> --%>
        <h3 class="text-slate-gray font-monoid-bold text-xl mb-3">Total Score</h3>
        <h2 class="text-6xl font-monoid-bold score-text justify-center items-center"><%= @total_score %> </h2>
      </div>
      <div class="text-khaki-500 font-monoid w-36 h-36 rounded-full bg-slate-700 flex flex-col items-center justify-center ml-auto">
        <h3>Session Time</h3>
        <h2 class=" font-monoid-bold text-3xl"><%= @session_timer %> </h2>
      </div>
    </section>
    """
  end
end
