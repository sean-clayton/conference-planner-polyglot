defmodule ConferencePlannerWeb.TrackController do
  use ConferencePlannerWeb, :controller

  alias ConferencePlanner.Conference
  alias ConferencePlanner.Conference.Track

  action_fallback ConferencePlannerWeb.FallbackController

  def index(conn, _params) do
    conference_tracks = Conference.list_conference_tracks()
    render(conn, "index.json", conference_tracks: conference_tracks)
  end

  def create(conn, %{"track" => track_params}) do
    with {:ok, %Track{} = track} <- Conference.create_track(track_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.track_path(conn, :show, track))
      |> render("show.json", track: track)
    end
  end

  def show(conn, %{"id" => id}) do
    track = Conference.get_track!(id)
    render(conn, "show.json", track: track)
  end

  def update(conn, %{"id" => id, "track" => track_params}) do
    track = Conference.get_track!(id)

    with {:ok, %Track{} = track} <- Conference.update_track(track, track_params) do
      render(conn, "show.json", track: track)
    end
  end

  def delete(conn, %{"id" => id}) do
    track = Conference.get_track!(id)

    with {:ok, %Track{}} <- Conference.delete_track(track) do
      send_resp(conn, :no_content, "")
    end
  end
end
