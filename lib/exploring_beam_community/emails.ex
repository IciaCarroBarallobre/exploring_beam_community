defmodule ExploringBeamCommunity.Emails do
  @moduledoc """
  The Catalog context.
  """
  alias ExploringBeamCommunity.Repo
  alias ExploringBeamCommunity.Emails.Email

  def get_current_email do
    Repo.get_by(Email, activated: true)
  end

  @doc """
  Inserts a new email, activating it and deactivating any other emails.
  """
  def insert_email(attrs) do
    Repo.transaction(fn ->
      # Deactivate any currently activated email
      Repo.update_all(Email, set: [activated: false])

      # Insert the new email with activated: true
      %Email{}
      |> Email.changeset(Map.put(attrs, :activated, true))
      |> Repo.insert()
    end)
  end
end
