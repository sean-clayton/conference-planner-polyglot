defmodule ConferencePlannerWeb.ConferenceView do
  use ConferencePlannerWeb, :view
  alias ConferencePlannerWeb.ConferenceView

  def render("index.json", %{conferences: conferences}) do
    %{data: render_many(conferences, ConferenceView, "conference.json")}
  end

  def render("show.json", %{conference: conference}) do
    %{data: render_one(conference, ConferenceView, "conference.json")}
  end

  def render("conference.json", %{conference: conference}) do
    %{id: conference.id,
      name: conference.name}
  end
end
