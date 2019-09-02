defmodule ConferencePlanner.Conferences.Conference do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conferences" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(conference, attrs) do
    conference
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
