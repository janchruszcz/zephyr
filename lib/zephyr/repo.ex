defmodule Zephyr.Repo do
  use Ecto.Repo,
    otp_app: :zephyr,
    adapter: Ecto.Adapters.Postgres
end
