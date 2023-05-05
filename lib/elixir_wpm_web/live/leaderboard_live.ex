defmodule ElixirWPMWeb.LeaderboardLive do
  use ElixirWPMWeb, :live_view
  import Phoenix.LiveView.Helpers



  def mount(_params, _session, socket) do
    # player_id = if session["user_token"], do: get_user_by_session_token(session["user_token"]).id
    # player_name = if session["user_token"], do: get_user_by_session_token(session["user_token"]).player_name
    {:ok, assign(socket,
    player_scores: ElixirWPM.Leaderboards.list_player_scores() |> Enum.map(&{&1.player_name, &1.total_score})
    )}
  end

  def render(assigns) do

    ~H"""
    <div class="flex flex-col items-center">
    <h1 class="text-3x1 font-bold mb-4 mb-8 text-center">LEADERBOARD</h1>
    <div class="w-full flex justify-center">
    <table class="table-auto w-1/2 " style="table-layout: fixed;">
    <colgroup>
        <col width="50%">
        <col width="50%">
      </colgroup>
    <thead>
    <tr>
      <th class="px-4 py-2">Player Name</th>
      <th class="px-4 py-2">Score</th>
    </tr>
    </thead>
    <tbody>

    <%= for {name, score} <- @player_scores do %>

      <tr class="h-12">
        <td class="even border px-4 py-2 text-center font-medium"><%= name %></td>
        <td class="border px-4 py-2 text-center font-medium"><%= score %></td>
      </tr>

    <% end %>
    </tbody>
    </table>
    </div>
    </div>
    """
  end
end
