defmodule ConferencePlannerWeb.SpeakerControllerTest do
  use ConferencePlannerWeb.ConnCase

  alias ConferencePlanner.Speakers
  alias ConferencePlanner.Speakers.Speaker

  @create_attrs %{
    bio: "some bio",
    name: "some name",
    website: "some website"
  }
  @update_attrs %{
    bio: "some updated bio",
    name: "some updated name",
    website: "some updated website"
  }
  @invalid_attrs %{bio: nil, name: nil, website: nil}

  def fixture(:speaker) do
    {:ok, speaker} = Speakers.create_speaker(@create_attrs)
    speaker
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all speakers", %{conn: conn} do
      conn = get(conn, Routes.speaker_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create speaker" do
    test "renders speaker when data is valid", %{conn: conn} do
      conn = post(conn, Routes.speaker_path(conn, :create), speaker: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.speaker_path(conn, :show, id))

      assert %{
               "id" => id,
               "bio" => "some bio",
               "name" => "some name",
               "website" => "some website"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.speaker_path(conn, :create), speaker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update speaker" do
    setup [:create_speaker]

    test "renders speaker when data is valid", %{conn: conn, speaker: %Speaker{id: id} = speaker} do
      conn = put(conn, Routes.speaker_path(conn, :update, speaker), speaker: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.speaker_path(conn, :show, id))

      assert %{
               "id" => id,
               "bio" => "some updated bio",
               "name" => "some updated name",
               "website" => "some updated website"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, speaker: speaker} do
      conn = put(conn, Routes.speaker_path(conn, :update, speaker), speaker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete speaker" do
    setup [:create_speaker]

    test "deletes chosen speaker", %{conn: conn, speaker: speaker} do
      conn = delete(conn, Routes.speaker_path(conn, :delete, speaker))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.speaker_path(conn, :show, speaker))
      end
    end
  end

  defp create_speaker(_) do
    speaker = fixture(:speaker)
    {:ok, speaker: speaker}
  end
end
