defmodule ExploringBeamCommunity.Emails.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emails" do
    field(:content, :string)
    field(:activated, :boolean, default: false)
    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
