defmodule ConferencePlannerWeb.SessionControllerTest do
  use ConferencePlannerWeb.ConnCase

  alias ConferencePlanner.Conference
  alias ConferencePlanner.Conference.Session

  @create_attrs %{
    abstract: "some abstract",
    end_time: ~N[2010-04-17 14:00:00],
    start_time: ~N[2010-04-17 14:00:00],
    title: "some title"
  }
  @update_attrs %{
    abstract: "some updated abstract",
    end_time: ~N[2011-05-18 15:01:01],
    start_time: ~N[2011-05-18 15:01:01],
    title: "some updated title"
  }
  @invalid_attrs %{abstract: nil, end_time: nil, start_time: nil, title: nil}

  def fixture(:session) do
    {:ok, session} = Conference.create_session(@create_attrs)
    session
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all conference_sessions", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create session" do
    test "renders session when data is valid", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), session: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.session_path(conn, :show, id))

      assert %{
               "id" => id,
               "abstract" => "some abstract",
               "end_time" => "2010-04-17T14:00:00",
               "start_time" => "2010-04-17T14:00:00",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update session" do
    setup [:create_session]

    test "renders session when data is valid", %{conn: conn, session: %Session{id: id} = session} do
      conn = put(conn, Routes.session_path(conn, :update, session), session: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.session_path(conn, :show, id))

      assert %{
               "id" => id,
               "abstract" => "some updated abstract",
               "end_time" => "2011-05-18T15:01:01",
               "start_time" => "2011-05-18T15:01:01",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, session: session} do
      conn = put(conn, Routes.session_path(conn, :update, session), session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete session" do
    setup [:create_session]

    test "deletes chosen session", %{conn: conn, session: session} do
      conn = delete(conn, Routes.session_path(conn, :delete, session))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.session_path(conn, :show, session))
      end
    end
  end

  defp create_session(_) do
    session = fixture(:session)
    {:ok, session: session}
  end
end
