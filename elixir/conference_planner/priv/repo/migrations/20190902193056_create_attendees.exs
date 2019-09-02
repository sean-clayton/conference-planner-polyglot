defmodule ConferencePlanner.Repo.Migrations.CreateAttendees do
  use Ecto.Migration

  def change do
    create table(:attendees) do
      add :email_address, :string
      add :first_name, :string
      add :last_name, :string
      add :username, :string

      timestamps()
    end

  end
end
