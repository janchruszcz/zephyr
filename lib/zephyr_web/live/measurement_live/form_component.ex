defmodule ZephyrWeb.MeasurementLive.FormComponent do
  use ZephyrWeb, :live_component

  alias Zephyr.AirQuality

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage measurement records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="measurement-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:temperature]} type="number" label="Temperature" step="any" />
        <.input field={@form[:humidity]} type="number" label="Humidity" step="any" />
        <.input field={@form[:pressure]} type="number" label="Pressure" step="any" />
        <.input field={@form[:pm10]} type="number" label="Pm10" step="any" />
        <.input field={@form[:pm25]} type="number" label="Pm25" step="any" />
        <.input field={@form[:gas_resistance]} type="number" label="Gas resistance" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Measurement</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{measurement: measurement} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(AirQuality.change_measurement(measurement))
     end)}
  end

  @impl true
  def handle_event("validate", %{"measurement" => measurement_params}, socket) do
    changeset = AirQuality.change_measurement(socket.assigns.measurement, measurement_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"measurement" => measurement_params}, socket) do
    save_measurement(socket, socket.assigns.action, measurement_params)
  end

  defp save_measurement(socket, :edit, measurement_params) do
    case AirQuality.update_measurement(socket.assigns.measurement, measurement_params) do
      {:ok, measurement} ->
        notify_parent({:saved, measurement})

        {:noreply,
         socket
         |> put_flash(:info, "Measurement updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_measurement(socket, :new, measurement_params) do
    case AirQuality.create_measurement(measurement_params) do
      {:ok, measurement} ->
        notify_parent({:saved, measurement})

        {:noreply,
         socket
         |> put_flash(:info, "Measurement created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
