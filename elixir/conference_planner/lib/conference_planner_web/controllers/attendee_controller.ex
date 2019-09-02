defmodule ConferencePlannerWeb.AttendeeController do
  use ConferencePlannerWeb, :controller

  alias ConferencePlanner.Attendees
  alias ConferencePlanner.Attendees.Attendee

  action_fallback ConferencePlannerWeb.FallbackController

  def index(conn, _params) do
    attendees = Attendees.list_attendees()
    render(conn, "index.json", attendees: attendees)
  end

  def create(conn, %{"attendee" => attendee_params}) do
    with {:ok, %Attendee{} = attendee} <- Attendees.create_attendee(attendee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.attendee_path(conn, :show, attendee))
      |> render("show.json", attendee: attendee)
    end
  end

  def show(conn, %{"id" => id}) do
    attendee = Attendees.get_attendee!(id)
    render(conn, "show.json", attendee: attendee)
  end

  def update(conn, %{"id" => id, "attendee" => attendee_params}) do
    attendee = Attendees.get_attendee!(id)

    with {:ok, %Attendee{} = attendee} <- Attendees.update_attendee(attendee, attendee_params) do
      render(conn, "show.json", attendee: attendee)
    end
  end

  def delete(conn, %{"id" => id}) do
    attendee = Attendees.get_attendee!(id)

    with {:ok, %Attendee{}} <- Attendees.delete_attendee(attendee) do
      send_resp(conn, :no_content, "")
    end
  end
end
