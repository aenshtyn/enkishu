defmodule FarmWeb.Api.ArableControllerTest do
  use FarmWeb.ConnCase

  import Farm.LandFixtures

  alias Farm.Land.Arable

  @create_attrs %{
    description: "some description",
    number: 42,
    size: 120.5
  }
  @update_attrs %{
    description: "some updated description",
    number: 43,
    size: 456.7
  }
  @invalid_attrs %{description: nil, number: nil, size: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all arable", %{conn: conn} do
      conn = get(conn, Routes.api_arable_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create arable" do
    test "renders arable when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_arable_path(conn, :create), arable: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_arable_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "number" => 42,
               "size" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_arable_path(conn, :create), arable: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update arable" do
    setup [:create_arable]

    test "renders arable when data is valid", %{conn: conn, arable: %Arable{id: id} = arable} do
      conn = put(conn, Routes.api_arable_path(conn, :update, arable), arable: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_arable_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "number" => 43,
               "size" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, arable: arable} do
      conn = put(conn, Routes.api_arable_path(conn, :update, arable), arable: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete arable" do
    setup [:create_arable]

    test "deletes chosen arable", %{conn: conn, arable: arable} do
      conn = delete(conn, Routes.api_arable_path(conn, :delete, arable))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_arable_path(conn, :show, arable))
      end
    end
  end

  defp create_arable(_) do
    arable = arable_fixture()
    %{arable: arable}
  end
end
