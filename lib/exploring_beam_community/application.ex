defmodule ExploringBeamCommunity.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExploringBeamCommunity.Repo,
      {Oban, Application.fetch_env!(:exploring_beam_community, Oban)},
      # Start the PubSub system
      {Phoenix.PubSub, name: ExploringBeamCommunity.PubSub},
      # Start the Endpoint (http/https)
      ExploringBeamCommunityWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExploringBeamCommunity.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExploringBeamCommunityWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
