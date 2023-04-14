defmodule ElixirWPM.Snippets do
  @snippets [

    "list = [1, 2, 3, 4, 5, 6, 7, 8, 9 10]",
    "2 3 4 5 6 7 8 9 10",
    "asdfasdfasdfasdfasdfasdf",

  ]
  def random() do
    Enum.random(@snippets)
  end
end

# "|> Enum.group_by(&(&1.name), &(&1.ids))",
#     "|> Enum.map(fn {color, ids} -> %{name: color, ids: List.flatten(ids)} end)",
#     "|> Enum.reduce(%{}, fn %{ids: ids, name: name}, acc ->",
#     "Map.update(acc, name, ids, fn prev_ids -> prev_ids ++ ids end)",
#     "|> Enum.map(fn {color, ids} -> %{name: color, ids: ids} end)",
#     "conn |> Plug.Conn.assign(:name, Keyword.get(opts, :name, background_job))",
#     "Enum.map(map, fn {k, v} -> {k, v * 2} end)",
