defmodule Zephyr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ZephyrWeb.Telemetry,
      Zephyr.Repo,
      {DNSCluster, query: Application.get_env(:zephyr, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Zephyr.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Zephyr.Finch},
      # Start a worker by calling: Zephyr.Worker.start_link(arg)
      # {Zephyr.Worker, arg},
      # Start to serve requests, typically the last entry
      ZephyrWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Zephyr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ZephyrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
