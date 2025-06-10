defmodule TestPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TestPhxWeb.Telemetry,
      TestPhx.Repo,
      {DNSCluster, query: Application.get_env(:test_phx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TestPhx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TestPhx.Finch},
      # Start a worker by calling: TestPhx.Worker.start_link(arg)
      # {TestPhx.Worker, arg},
      # Start to serve requests, typically the last entry
      TestPhxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
