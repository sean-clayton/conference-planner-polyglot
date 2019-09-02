defmodule ConferencePlannerWeb.ConferenceController do
  use ConferencePlannerWeb, :controller

  alias ConferencePlanner.Conferences
  alias ConferencePlanner.Conferences.Conference

  action_fallback ConferencePlannerWeb.FallbackController

  def index(conn, _params) do
    conferences = Conferences.list_conferences()
    render(conn, "index.json", conferences: conferences)
  end

  def create(conn, %{"conference" => conference_params}) do
    with {:ok, %Conference{} = conference} <- Conferences.create_conference(conference_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.conference_path(conn, :show, conference))
      |> render("show.json", conference: conference)
    end
  end

  def show(conn, %{"id" => id}) do
    conference = Conferences.get_conference!(id)
    render(conn, "show.json", conference: conference)
  end

  def update(conn, %{"id" => id, "conference" => conference_params}) do
    conference = Conferences.get_conference!(id)

    with {:ok, %Conference{} = conference} <- Conferences.update_conference(conference, conference_params) do
      render(conn, "show.json", conference: conference)
    end
  end

  def delete(conn, %{"id" => id}) do
    conference = Conferences.get_conference!(id)

    with {:ok, %Conference{}} <- Conferences.delete_conference(conference) do
      send_resp(conn, :no_content, "")
    end
  end
end
