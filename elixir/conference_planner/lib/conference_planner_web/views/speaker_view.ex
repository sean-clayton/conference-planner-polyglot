defmodule ConferencePlannerWeb.SpeakerView do
  use ConferencePlannerWeb, :view
  alias ConferencePlannerWeb.SpeakerView

  def render("index.json", %{speakers: speakers}) do
    %{data: render_many(speakers, SpeakerView, "speaker.json")}
  end

  def render("show.json", %{speaker: speaker}) do
    %{data: render_one(speaker, SpeakerView, "speaker.json")}
  end

  def render("speaker.json", %{speaker: speaker}) do
    %{id: speaker.id,
      bio: speaker.bio,
      name: speaker.name,
      website: speaker.website}
  end
end
