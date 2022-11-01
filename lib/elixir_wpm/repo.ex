defmodule ElixirWPM.Repo do
  use Ecto.Repo,
    otp_app: :elixir_wpm,
    adapter: Ecto.Adapters.Postgres
end
