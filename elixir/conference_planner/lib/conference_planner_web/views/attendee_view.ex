defmodule ConferencePlannerWeb.AttendeeView do
  use ConferencePlannerWeb, :view
  alias ConferencePlannerWeb.AttendeeView

  def render("index.json", %{attendees: attendees}) do
    %{data: render_many(attendees, AttendeeView, "attendee.json")}
  end

  def render("show.json", %{attendee: attendee}) do
    %{data: render_one(attendee, AttendeeView, "attendee.json")}
  end

  def render("attendee.json", %{attendee: attendee}) do
    %{id: attendee.id,
      email_address: attendee.email_address,
      first_name: attendee.first_name,
      last_name: attendee.last_name,
      username: attendee.username}
  end
end
