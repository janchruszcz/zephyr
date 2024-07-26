defmodule Zephyr.AirQuality.Measurement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "measurements" do
    field :temperature, :decimal
    field :humidity, :decimal
    field :pressure, :decimal
    field :pm10, :decimal
    field :pm25, :decimal
    field :gas_resistance, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(measurement, attrs) do
    measurement
    |> cast(attrs, [:temperature, :humidity, :pressure, :pm10, :pm25, :gas_resistance])
    |> validate_required([:temperature, :humidity, :pressure, :pm10, :pm25, :gas_resistance])
  end
end
