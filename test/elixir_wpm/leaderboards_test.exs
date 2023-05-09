defmodule ElixirWPM.LeaderboardsTest do
  use ElixirWPM.DataCase
  use ElixirWPMWeb.ConnCase, async: true

  alias ElixirWPM.Leaderboards
  import ElixirWPM.AccountsFixtures

  describe "player_scores" do
    alias ElixirWPM.Leaderboards.PlayerScore

    import ElixirWPM.LeaderboardsFixtures
    import ElixirWPM.AccountsFixtures

    @invalid_attrs %{total_score: nil}

    test "list_player_scores/0 returns all player_scores" do
      player1 = user_fixture()
      player_score = player_score_fixture(player_id: player1.id)

      assert Leaderboards.list_player_scores() == [player_score]
    end

    test "get_player_score!/1 returns the player_score with given id" do
      player1 = user_fixture()


      player_score = player_score_fixture(player_id: player1.id)

      assert Leaderboards.get_player_score!(player_score.id) == player_score
    end


    test "create_player_score/1 with valid data creates a player_score" do
      player1 = user_fixture()
      # conn = get(conn, "/")
      # log_in_user(conn, player1)

      valid_attrs = %{total_score: 42, player_id: player1.id}

      assert {:ok, %PlayerScore{} = player_score} = Leaderboards.create_player_score(valid_attrs)
      assert player_score.total_score == 42
    end

    test "create_player_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Leaderboards.create_player_score(@invalid_attrs)
    end

    test "update_player_score/2 with valid data updates the player_score" do
      player1 = user_fixture()
      player_score = player_score_fixture(player_id: player1.id)
      update_attrs = %{total_score: 43}

      assert {:ok, %PlayerScore{} = player_score} =
               Leaderboards.update_player_score(player_score, update_attrs)

      assert player_score.total_score == 43
    end

    test "update_player_score/2 with invalid data returns error changeset" do
      player1 = user_fixture()
      player_score = player_score_fixture(player_id: player1.id)

      assert {:error, %Ecto.Changeset{}} =
               Leaderboards.update_player_score(player_score, @invalid_attrs)

      assert player_score == Leaderboards.get_player_score!(player_score.id)
    end

    test "delete_player_score/1 deletes the player_score" do
      player1 = user_fixture()
      player_score = player_score_fixture(player_id: player1.id)

      assert {:ok, %PlayerScore{}} = Leaderboards.delete_player_score(player_score)
      assert_raise Ecto.NoResultsError, fn -> Leaderboards.get_player_score!(player_score.id) end
    end

    test "change_player_score/1 returns a player_score changeset" do
      player1 = user_fixture()
      player_score = player_score_fixture(player_id: player1.id)
      assert %Ecto.Changeset{} = Leaderboards.change_player_score(player_score)
    end
  end
end
