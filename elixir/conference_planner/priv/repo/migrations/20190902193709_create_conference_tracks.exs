defmodule ConferencePlanner.Repo.Migrations.CreateConferenceTracks do
  use Ecto.Migration

  def change do
    create table(:conference_tracks) do
      add :name, :string
      add :conference_id, references(:conferences, on_delete: :nothing)

      timestamps()
    end

    create index(:conference_tracks, [:conference_id])
  end
end
