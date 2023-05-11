defmodule ElixirWPM.Snippets do
  @snippets [
    "Enum.map([1, 2, 3], fn x -> x * 2 end)",
    "if(foo, do: bar)",
    "IO.inspect(number)",
    "[1, 2, 3] = [a, b, c]",
    "{elixir: \"rules\"}",
    "add = fn a, b -> a + b end",
    "for n <- [1, 2, 3, 4], do: n * 2",
    "Float.floor(12.52, 2)",
    "Float.ceil(34.25)",
    "Float.to_charlist(7.0)",
    "start = DateTime.utc_now()",
    "text_input = form_data[\"textinput\"][\"name\"]",
    



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
