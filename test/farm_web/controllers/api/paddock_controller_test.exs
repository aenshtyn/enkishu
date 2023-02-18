defmodule FarmWeb.Api.PaddockControllerTest do
  use FarmWeb.ConnCase

  import Farm.LandFixtures

  alias Farm.Land.Paddock

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
    test "lists all paddocks", %{conn: conn} do
      conn = get(conn, Routes.api_paddock_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create paddock" do
    test "renders paddock when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_paddock_path(conn, :create), paddock: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_paddock_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "number" => 42,
               "size" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_paddock_path(conn, :create), paddock: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update paddock" do
    setup [:create_paddock]

    test "renders paddock when data is valid", %{conn: conn, paddock: %Paddock{id: id} = paddock} do
      conn = put(conn, Routes.api_paddock_path(conn, :update, paddock), paddock: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_paddock_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "number" => 43,
               "size" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, paddock: paddock} do
      conn = put(conn, Routes.api_paddock_path(conn, :update, paddock), paddock: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete paddock" do
    setup [:create_paddock]

    test "deletes chosen paddock", %{conn: conn, paddock: paddock} do
      conn = delete(conn, Routes.api_paddock_path(conn, :delete, paddock))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_paddock_path(conn, :show, paddock))
      end
    end
  end

  defp create_paddock(_) do
    paddock = paddock_fixture()
    %{paddock: paddock}
  end
end
