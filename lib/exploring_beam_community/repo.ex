defmodule ExploringBeamCommunity.Repo do
  use Ecto.Repo,
    otp_app: :exploring_beam_community,
    adapter: Ecto.Adapters.Postgres
end
