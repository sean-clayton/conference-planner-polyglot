defmodule ConferencePlanner.Repo.Migrations.CreateConferences do
  use Ecto.Migration

  def change do
    create table(:conferences) do
      add :name, :string

      timestamps()
    end

  end
end
