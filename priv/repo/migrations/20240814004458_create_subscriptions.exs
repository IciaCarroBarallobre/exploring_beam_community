defmodule ExploringBeamCommunity.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :email, :string
      add :activated, :boolean, default: false, null: false
      add :activation_token, :string
      add :unsubscribe_token, :string

      timestamps()
    end

    create unique_index(:subscriptions, [:email])
    create unique_index(:subscriptions, [:unsubscribe_token])
    create unique_index(:subscriptions, [:activation_token])
  end
end
