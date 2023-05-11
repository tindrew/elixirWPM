defmodule ElixirWPMWeb.LeaderboardLive do
  use ElixirWPMWeb, :live_view
  import Phoenix.LiveView.Helpers

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(ElixirWPM.PubSub, "score_board")

    {:ok,
     assign(socket,
       player_scores:
         ElixirWPM.Leaderboards.list_player_scores()
         |> Enum.map(&{&1.player_name, &1.total_score})
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center table-font">
      <h1 class=" text-3xl font-bold mb-8 my-8 text-center">LEADERBOARD</h1>
    <div class="w-full flex justify-center">
    <table class="table-auto w-3/4" style="table-layout: fixed;">
    <colgroup>
        <col width="50%">
        <col width="50%">
        <col width="50%">
      </colgroup>
    <thead>
    <tr>
      <th class="px-4 py-2">Rank</th>
      <th class="px-4 py-2">Player Name</th>
      <th class="px-4 py-2">Score</th>
    </tr>
    </thead>
    <tbody >

    <%= for {rank, {name, score}} <- Enum.zip(1..length(@player_scores), @player_scores) do %>

      <tr class="h-10 even:bg-gradient-to-r from-gray-500 to-gray-300 odd:bg-gradient-to-l from-orange-300 to-orange-200 ">
        <td class="  border border-r-0 border-l-2 text-center"><%= rank %></td>
        <td class=" border text-center"><%= name %></td>
        <td class=" border border-r-2 text-center"><%= score %></td>
      </tr>
    <% end %>
    </tbody>
    </table>
    </div>
    </div>
    """
  end

  @impl true
  def handle_info({:player_scores, {updated_player_score}}, socket) do
    {:noreply,
     assign(
       socket,
       :player_scores,
       updated_player_score |> Enum.map(&{&1.player_name, &1.total_score})
     )}
  end
end
