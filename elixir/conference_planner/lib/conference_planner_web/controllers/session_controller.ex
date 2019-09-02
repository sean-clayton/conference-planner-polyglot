defmodule ConferencePlannerWeb.SessionController do
  use ConferencePlannerWeb, :controller

  alias ConferencePlanner.Conference
  alias ConferencePlanner.Conference.Session

  action_fallback ConferencePlannerWeb.FallbackController

  def index(conn, _params) do
    conference_sessions = Conference.list_conference_sessions()
    render(conn, "index.json", conference_sessions: conference_sessions)
  end

  def create(conn, %{"session" => session_params}) do
    with {:ok, %Session{} = session} <- Conference.create_session(session_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.session_path(conn, :show, session))
      |> render("show.json", session: session)
    end
  end

  def show(conn, %{"id" => id}) do
    session = Conference.get_session!(id)
    render(conn, "show.json", session: session)
  end

  def update(conn, %{"id" => id, "session" => session_params}) do
    session = Conference.get_session!(id)

    with {:ok, %Session{} = session} <- Conference.update_session(session, session_params) do
      render(conn, "show.json", session: session)
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Conference.get_session!(id)

    with {:ok, %Session{}} <- Conference.delete_session(session) do
      send_resp(conn, :no_content, "")
    end
  end
end
