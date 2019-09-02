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
end
