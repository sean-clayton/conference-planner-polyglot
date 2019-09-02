defmodule ConferencePlanner.Speakers.Speaker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :bio, :string
    field :name, :string
    field :website, :string
    field :conference_id, :id

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:bio, :name, :website])
    |> validate_required([:bio, :name, :website])
  end
end
