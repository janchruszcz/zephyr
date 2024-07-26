defmodule Zephyr.AirQualityFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zephyr.AirQuality` context.
  """

  @doc """
  Generate a measurement.
  """
  def measurement_fixture(attrs \\ %{}) do
    {:ok, measurement} =
      attrs
      |> Enum.into(%{
        gas_resistance: "120.5",
        humidity: "120.5",
        pm10: "120.5",
        pm25: "120.5",
        pressure: "120.5",
        temperature: "120.5"
      })
      |> Zephyr.AirQuality.create_measurement()

    measurement
  end
end
