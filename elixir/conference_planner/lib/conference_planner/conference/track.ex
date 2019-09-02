defmodule ConferencePlanner.Conference.Track do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conference_tracks" do
    field :name, :string
    field :conference_id, :id

    timestamps()
  end

  @doc false
  def changeset(track, attrs) do
    track
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
