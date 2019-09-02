defmodule ConferencePlannerWeb.TrackView do
  use ConferencePlannerWeb, :view
  alias ConferencePlannerWeb.TrackView

  def render("index.json", %{conference_tracks: conference_tracks}) do
    %{data: render_many(conference_tracks, TrackView, "track.json")}
  end

  def render("show.json", %{track: track}) do
    %{data: render_one(track, TrackView, "track.json")}
  end

  def render("track.json", %{track: track}) do
    %{id: track.id,
      name: track.name}
  end
end
