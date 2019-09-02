defmodule ConferencePlannerWeb.SessionView do
  use ConferencePlannerWeb, :view
  alias ConferencePlannerWeb.SessionView

  def render("index.json", %{conference_sessions: conference_sessions}) do
    %{data: render_many(conference_sessions, SessionView, "session.json")}
  end

  def render("show.json", %{session: session}) do
    %{data: render_one(session, SessionView, "session.json")}
  end

  def render("session.json", %{session: session}) do
    %{id: session.id,
      abstract: session.abstract,
      end_time: session.end_time,
      start_time: session.start_time,
      title: session.title}
  end
end
