defmodule Convertex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ConvertexWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Convertex.PubSub},
      # Start Finch
      {Finch, name: Convertex.Finch},
      # Start the Endpoint (http/https)
      ConvertexWeb.Endpoint
      # Start a worker by calling: Convertex.Worker.start_link(arg)
      # {Convertex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Convertex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ConvertexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
