defmodule ZephyrWeb.MeasurementLive.Index do
  use ZephyrWeb, :live_view

  alias Zephyr.AirQuality
  alias Zephyr.AirQuality.Measurement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :measurements, AirQuality.list_measurements())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Measurement")
    |> assign(:measurement, AirQuality.get_measurement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Measurement")
    |> assign(:measurement, %Measurement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Measurements")
    |> assign(:measurement, nil)
  end

  @impl true
  def handle_info({ZephyrWeb.MeasurementLive.FormComponent, {:saved, measurement}}, socket) do
    {:noreply, stream_insert(socket, :measurements, measurement)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    measurement = AirQuality.get_measurement!(id)
    {:ok, _} = AirQuality.delete_measurement(measurement)

    {:noreply, stream_delete(socket, :measurements, measurement)}
  end
end
