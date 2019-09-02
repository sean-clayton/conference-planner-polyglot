defmodule ConferencePlanner.Repo.Migrations.CreateConferenceSessions do
  use Ecto.Migration

  def change do
    create table(:conference_sessions) do
      add :abstract, :text
      add :end_time, :naive_datetime
      add :start_time, :naive_datetime
      add :title, :string
      add :conference_id, references(:conferences, on_delete: :nothing)
      add :track_id, references(:conference_tracks, on_delete: :nothing)

      timestamps()
    end

    create index(:conference_sessions, [:conference_id])
    create index(:conference_sessions, [:track_id])
  end
end
