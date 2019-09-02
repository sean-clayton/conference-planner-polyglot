defmodule ConferencePlanner.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :bio, :string
      add :name, :string
      add :website, :string
      add :conference_id, references(:conferences, on_delete: :nothing)

      timestamps()
    end

    create index(:speakers, [:conference_id])
  end
end
