defmodule ConferencePlanner.Conference.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conference_sessions" do
    field :abstract, :string
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    field :title, :string
    field :conference_id, :id
    field :track_id, :id

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:abstract, :end_time, :start_time, :title])
    |> validate_required([:abstract, :end_time, :start_time, :title])
  end
end
