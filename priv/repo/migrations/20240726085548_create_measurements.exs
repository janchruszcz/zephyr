defmodule Zephyr.Repo.Migrations.CreateMeasurements do
  use Ecto.Migration

  def change do
    create table(:measurements) do
      add :temperature, :decimal
      add :humidity, :decimal
      add :pressure, :decimal
      add :pm10, :decimal
      add :pm25, :decimal
      add :gas_resistance, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
