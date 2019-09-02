defmodule ConferencePlanner.Attendees.Attendee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attendees" do
    field :email_address, :string
    field :first_name, :string
    field :last_name, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(attendee, attrs) do
    attendee
    |> cast(attrs, [:email_address, :first_name, :last_name, :username])
    |> validate_required([:email_address, :first_name, :last_name, :username])
  end
end
