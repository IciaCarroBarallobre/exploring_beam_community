defmodule ExploringBeamCommunity.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :content, :text, null: false
      add :activated, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:emails, [:activated], where: "activated = true")
  end
end
