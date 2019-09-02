defmodule ConferencePlanner.SpeakersTest do
  use ConferencePlanner.DataCase

  alias ConferencePlanner.Speakers

  describe "speakers" do
    alias ConferencePlanner.Speakers.Speaker

    @valid_attrs %{bio: "some bio", name: "some name", website: "some website"}
    @update_attrs %{bio: "some updated bio", name: "some updated name", website: "some updated website"}
    @invalid_attrs %{bio: nil, name: nil, website: nil}

    def speaker_fixture(attrs \\ %{}) do
      {:ok, speaker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Speakers.create_speaker()

      speaker
    end

    test "list_speakers/0 returns all speakers" do
      speaker = speaker_fixture()
      assert Speakers.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker = speaker_fixture()
      assert Speakers.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      assert {:ok, %Speaker{} = speaker} = Speakers.create_speaker(@valid_attrs)
      assert speaker.bio == "some bio"
      assert speaker.name == "some name"
      assert speaker.website == "some website"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Speakers.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{} = speaker} = Speakers.update_speaker(speaker, @update_attrs)
      assert speaker.bio == "some updated bio"
      assert speaker.name == "some updated name"
      assert speaker.website == "some updated website"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker = speaker_fixture()
      assert {:error, %Ecto.Changeset{}} = Speakers.update_speaker(speaker, @invalid_attrs)
      assert speaker == Speakers.get_speaker!(speaker.id)
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{}} = Speakers.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> Speakers.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture()
      assert %Ecto.Changeset{} = Speakers.change_speaker(speaker)
    end
  end
end
