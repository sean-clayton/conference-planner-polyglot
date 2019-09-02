defmodule ConferencePlanner.AttendeesTest do
  use ConferencePlanner.DataCase

  alias ConferencePlanner.Attendees

  describe "attendees" do
    alias ConferencePlanner.Attendees.Attendee

    @valid_attrs %{email_address: "some email_address", first_name: "some first_name", last_name: "some last_name", username: "some username"}
    @update_attrs %{email_address: "some updated email_address", first_name: "some updated first_name", last_name: "some updated last_name", username: "some updated username"}
    @invalid_attrs %{email_address: nil, first_name: nil, last_name: nil, username: nil}

    def attendee_fixture(attrs \\ %{}) do
      {:ok, attendee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Attendees.create_attendee()

      attendee
    end

    test "list_attendees/0 returns all attendees" do
      attendee = attendee_fixture()
      assert Attendees.list_attendees() == [attendee]
    end

    test "get_attendee!/1 returns the attendee with given id" do
      attendee = attendee_fixture()
      assert Attendees.get_attendee!(attendee.id) == attendee
    end

    test "create_attendee/1 with valid data creates a attendee" do
      assert {:ok, %Attendee{} = attendee} = Attendees.create_attendee(@valid_attrs)
      assert attendee.email_address == "some email_address"
      assert attendee.first_name == "some first_name"
      assert attendee.last_name == "some last_name"
      assert attendee.username == "some username"
    end

    test "create_attendee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendees.create_attendee(@invalid_attrs)
    end

    test "update_attendee/2 with valid data updates the attendee" do
      attendee = attendee_fixture()
      assert {:ok, %Attendee{} = attendee} = Attendees.update_attendee(attendee, @update_attrs)
      assert attendee.email_address == "some updated email_address"
      assert attendee.first_name == "some updated first_name"
      assert attendee.last_name == "some updated last_name"
      assert attendee.username == "some updated username"
    end

    test "update_attendee/2 with invalid data returns error changeset" do
      attendee = attendee_fixture()
      assert {:error, %Ecto.Changeset{}} = Attendees.update_attendee(attendee, @invalid_attrs)
      assert attendee == Attendees.get_attendee!(attendee.id)
    end

    test "delete_attendee/1 deletes the attendee" do
      attendee = attendee_fixture()
      assert {:ok, %Attendee{}} = Attendees.delete_attendee(attendee)
      assert_raise Ecto.NoResultsError, fn -> Attendees.get_attendee!(attendee.id) end
    end

    test "change_attendee/1 returns a attendee changeset" do
      attendee = attendee_fixture()
      assert %Ecto.Changeset{} = Attendees.change_attendee(attendee)
    end
  end
end
