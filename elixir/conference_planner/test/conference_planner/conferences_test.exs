defmodule ConferencePlanner.ConferencesTest do
  use ConferencePlanner.DataCase

  alias ConferencePlanner.Conferences

  describe "conferences" do
    alias ConferencePlanner.Conferences.Conference

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def conference_fixture(attrs \\ %{}) do
      {:ok, conference} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Conferences.create_conference()

      conference
    end

    test "list_conferences/0 returns all conferences" do
      conference = conference_fixture()
      assert Conferences.list_conferences() == [conference]
    end

    test "get_conference!/1 returns the conference with given id" do
      conference = conference_fixture()
      assert Conferences.get_conference!(conference.id) == conference
    end

    test "create_conference/1 with valid data creates a conference" do
      assert {:ok, %Conference{} = conference} = Conferences.create_conference(@valid_attrs)
      assert conference.name == "some name"
    end

    test "create_conference/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conferences.create_conference(@invalid_attrs)
    end

    test "update_conference/2 with valid data updates the conference" do
      conference = conference_fixture()
      assert {:ok, %Conference{} = conference} = Conferences.update_conference(conference, @update_attrs)
      assert conference.name == "some updated name"
    end

    test "update_conference/2 with invalid data returns error changeset" do
      conference = conference_fixture()
      assert {:error, %Ecto.Changeset{}} = Conferences.update_conference(conference, @invalid_attrs)
      assert conference == Conferences.get_conference!(conference.id)
    end

    test "delete_conference/1 deletes the conference" do
      conference = conference_fixture()
      assert {:ok, %Conference{}} = Conferences.delete_conference(conference)
      assert_raise Ecto.NoResultsError, fn -> Conferences.get_conference!(conference.id) end
    end

    test "change_conference/1 returns a conference changeset" do
      conference = conference_fixture()
      assert %Ecto.Changeset{} = Conferences.change_conference(conference)
    end
  end
end
