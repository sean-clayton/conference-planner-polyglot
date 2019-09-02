defmodule ConferencePlanner.ConferenceTest do
  use ConferencePlanner.DataCase

  alias ConferencePlanner.Conference

  describe "conference_tracks" do
    alias ConferencePlanner.Conference.Track

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def track_fixture(attrs \\ %{}) do
      {:ok, track} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Conference.create_track()

      track
    end

    test "list_conference_tracks/0 returns all conference_tracks" do
      track = track_fixture()
      assert Conference.list_conference_tracks() == [track]
    end

    test "get_track!/1 returns the track with given id" do
      track = track_fixture()
      assert Conference.get_track!(track.id) == track
    end

    test "create_track/1 with valid data creates a track" do
      assert {:ok, %Track{} = track} = Conference.create_track(@valid_attrs)
      assert track.name == "some name"
    end

    test "create_track/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conference.create_track(@invalid_attrs)
    end

    test "update_track/2 with valid data updates the track" do
      track = track_fixture()
      assert {:ok, %Track{} = track} = Conference.update_track(track, @update_attrs)
      assert track.name == "some updated name"
    end

    test "update_track/2 with invalid data returns error changeset" do
      track = track_fixture()
      assert {:error, %Ecto.Changeset{}} = Conference.update_track(track, @invalid_attrs)
      assert track == Conference.get_track!(track.id)
    end

    test "delete_track/1 deletes the track" do
      track = track_fixture()
      assert {:ok, %Track{}} = Conference.delete_track(track)
      assert_raise Ecto.NoResultsError, fn -> Conference.get_track!(track.id) end
    end

    test "change_track/1 returns a track changeset" do
      track = track_fixture()
      assert %Ecto.Changeset{} = Conference.change_track(track)
    end
  end

  describe "conference_sessions" do
    alias ConferencePlanner.Conference.Session

    @valid_attrs %{abstract: "some abstract", end_time: ~N[2010-04-17 14:00:00], start_time: ~N[2010-04-17 14:00:00], title: "some title"}
    @update_attrs %{abstract: "some updated abstract", end_time: ~N[2011-05-18 15:01:01], start_time: ~N[2011-05-18 15:01:01], title: "some updated title"}
    @invalid_attrs %{abstract: nil, end_time: nil, start_time: nil, title: nil}

    def session_fixture(attrs \\ %{}) do
      {:ok, session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Conference.create_session()

      session
    end

    test "list_conference_sessions/0 returns all conference_sessions" do
      session = session_fixture()
      assert Conference.list_conference_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Conference.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      assert {:ok, %Session{} = session} = Conference.create_session(@valid_attrs)
      assert session.abstract == "some abstract"
      assert session.end_time == ~N[2010-04-17 14:00:00]
      assert session.start_time == ~N[2010-04-17 14:00:00]
      assert session.title == "some title"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conference.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      assert {:ok, %Session{} = session} = Conference.update_session(session, @update_attrs)
      assert session.abstract == "some updated abstract"
      assert session.end_time == ~N[2011-05-18 15:01:01]
      assert session.start_time == ~N[2011-05-18 15:01:01]
      assert session.title == "some updated title"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Conference.update_session(session, @invalid_attrs)
      assert session == Conference.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Conference.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Conference.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Conference.change_session(session)
    end
  end
end
