defmodule ConferencePlannerWeb.ConferenceControllerTest do
  use ConferencePlannerWeb.ConnCase

  alias ConferencePlanner.Conferences
  alias ConferencePlanner.Conferences.Conference

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:conference) do
    {:ok, conference} = Conferences.create_conference(@create_attrs)
    conference
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all conferences", %{conn: conn} do
      conn = get(conn, Routes.conference_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create conference" do
    test "renders conference when data is valid", %{conn: conn} do
      conn = post(conn, Routes.conference_path(conn, :create), conference: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.conference_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.conference_path(conn, :create), conference: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update conference" do
    setup [:create_conference]

    test "renders conference when data is valid", %{conn: conn, conference: %Conference{id: id} = conference} do
      conn = put(conn, Routes.conference_path(conn, :update, conference), conference: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.conference_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, conference: conference} do
      conn = put(conn, Routes.conference_path(conn, :update, conference), conference: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete conference" do
    setup [:create_conference]

    test "deletes chosen conference", %{conn: conn, conference: conference} do
      conn = delete(conn, Routes.conference_path(conn, :delete, conference))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.conference_path(conn, :show, conference))
      end
    end
  end

  defp create_conference(_) do
    conference = fixture(:conference)
    {:ok, conference: conference}
  end
end
