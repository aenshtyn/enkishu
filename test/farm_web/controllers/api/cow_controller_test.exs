defmodule FarmWeb.Api.CowControllerTest do
  use FarmWeb.ConnCase

  import Farm.AnimalsFixtures

  alias Farm.Animals.Cow

  @create_attrs %{
    breed: "some breed",
    dob: ~D[2022-02-28],
    name: "some name",
    owner: "some owner"
  }
  @update_attrs %{
    breed: "some updated breed",
    dob: ~D[2022-03-01],
    name: "some updated name",
    owner: "some updated owner"
  }
  @invalid_attrs %{breed: nil, dob: nil, name: nil, owner: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cows", %{conn: conn} do
      conn = get(conn, Routes.api_cow_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cow" do
    test "renders cow when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_cow_path(conn, :create), cow: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_cow_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "breed" => "some breed",
               "dob" => "2022-02-28",
               "name" => "some name",
               "owner" => "some owner"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_cow_path(conn, :create), cow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cow" do
    setup [:create_cow]

    test "renders cow when data is valid", %{conn: conn, cow: %Cow{id: id} = cow} do
      conn = put(conn, Routes.api_cow_path(conn, :update, cow), cow: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_cow_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "breed" => "some updated breed",
               "dob" => "2022-03-01",
               "name" => "some updated name",
               "owner" => "some updated owner"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cow: cow} do
      conn = put(conn, Routes.api_cow_path(conn, :update, cow), cow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cow" do
    setup [:create_cow]

    test "deletes chosen cow", %{conn: conn, cow: cow} do
      conn = delete(conn, Routes.api_cow_path(conn, :delete, cow))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_cow_path(conn, :show, cow))
      end
    end
  end

  defp create_cow(_) do
    cow = cow_fixture()
    %{cow: cow}
  end
end
