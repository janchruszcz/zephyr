defmodule Zephyr.AirQualityTest do
  use Zephyr.DataCase

  alias Zephyr.AirQuality

  describe "measurements" do
    alias Zephyr.AirQuality.Measurement

    import Zephyr.AirQualityFixtures

    @invalid_attrs %{temperature: nil, humidity: nil, pressure: nil, pm10: nil, pm25: nil, gas_resistance: nil}

    test "list_measurements/0 returns all measurements" do
      measurement = measurement_fixture()
      assert AirQuality.list_measurements() == [measurement]
    end

    test "get_measurement!/1 returns the measurement with given id" do
      measurement = measurement_fixture()
      assert AirQuality.get_measurement!(measurement.id) == measurement
    end

    test "create_measurement/1 with valid data creates a measurement" do
      valid_attrs = %{temperature: "120.5", humidity: "120.5", pressure: "120.5", pm10: "120.5", pm25: "120.5", gas_resistance: "120.5"}

      assert {:ok, %Measurement{} = measurement} = AirQuality.create_measurement(valid_attrs)
      assert measurement.temperature == Decimal.new("120.5")
      assert measurement.humidity == Decimal.new("120.5")
      assert measurement.pressure == Decimal.new("120.5")
      assert measurement.pm10 == Decimal.new("120.5")
      assert measurement.pm25 == Decimal.new("120.5")
      assert measurement.gas_resistance == Decimal.new("120.5")
    end

    test "create_measurement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AirQuality.create_measurement(@invalid_attrs)
    end

    test "update_measurement/2 with valid data updates the measurement" do
      measurement = measurement_fixture()
      update_attrs = %{temperature: "456.7", humidity: "456.7", pressure: "456.7", pm10: "456.7", pm25: "456.7", gas_resistance: "456.7"}

      assert {:ok, %Measurement{} = measurement} = AirQuality.update_measurement(measurement, update_attrs)
      assert measurement.temperature == Decimal.new("456.7")
      assert measurement.humidity == Decimal.new("456.7")
      assert measurement.pressure == Decimal.new("456.7")
      assert measurement.pm10 == Decimal.new("456.7")
      assert measurement.pm25 == Decimal.new("456.7")
      assert measurement.gas_resistance == Decimal.new("456.7")
    end

    test "update_measurement/2 with invalid data returns error changeset" do
      measurement = measurement_fixture()
      assert {:error, %Ecto.Changeset{}} = AirQuality.update_measurement(measurement, @invalid_attrs)
      assert measurement == AirQuality.get_measurement!(measurement.id)
    end

    test "delete_measurement/1 deletes the measurement" do
      measurement = measurement_fixture()
      assert {:ok, %Measurement{}} = AirQuality.delete_measurement(measurement)
      assert_raise Ecto.NoResultsError, fn -> AirQuality.get_measurement!(measurement.id) end
    end

    test "change_measurement/1 returns a measurement changeset" do
      measurement = measurement_fixture()
      assert %Ecto.Changeset{} = AirQuality.change_measurement(measurement)
    end
  end
end
