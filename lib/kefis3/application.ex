defmodule Kefis3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Kefis3.Repo,
      # Start the Telemetry supervisor
      Kefis3Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kefis3.PubSub},
      # Start the Endpoint (http/https)
      Kefis3Web.Endpoint
      # Start a worker by calling: Kefis3.Worker.start_link(arg)
      # {Kefis3.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kefis3.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Kefis3Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
