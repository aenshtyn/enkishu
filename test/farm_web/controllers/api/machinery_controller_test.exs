defmodule FarmWeb.Api.MachineryControllerTest do
  use FarmWeb.ConnCase

  import Farm.InventoryFixtures

  alias Farm.Inventory.Machinery

  @create_attrs %{
    area_of_use: "some area_of_use",
    brand: "some brand",
    hp: 120.5,
    name: "some name",
    price: 120.5
  }
  @update_attrs %{
    area_of_use: "some updated area_of_use",
    brand: "some updated brand",
    hp: 456.7,
    name: "some updated name",
    price: 456.7
  }
  @invalid_attrs %{area_of_use: nil, brand: nil, hp: nil, name: nil, price: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all machinerys", %{conn: conn} do
      conn = get(conn, Routes.api_machinery_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create machinery" do
    test "renders machinery when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_machinery_path(conn, :create), machinery: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_machinery_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "area_of_use" => "some area_of_use",
               "brand" => "some brand",
               "hp" => 120.5,
               "name" => "some name",
               "price" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_machinery_path(conn, :create), machinery: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update machinery" do
    setup [:create_machinery]

    test "renders machinery when data is valid", %{
      conn: conn,
      machinery: %Machinery{id: id} = machinery
    } do
      conn =
        put(conn, Routes.api_machinery_path(conn, :update, machinery), machinery: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_machinery_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "area_of_use" => "some updated area_of_use",
               "brand" => "some updated brand",
               "hp" => 456.7,
               "name" => "some updated name",
               "price" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, machinery: machinery} do
      conn =
        put(conn, Routes.api_machinery_path(conn, :update, machinery), machinery: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete machinery" do
    setup [:create_machinery]

    test "deletes chosen machinery", %{conn: conn, machinery: machinery} do
      conn = delete(conn, Routes.api_machinery_path(conn, :delete, machinery))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_machinery_path(conn, :show, machinery))
      end
    end
  end

  defp create_machinery(_) do
    machinery = machinery_fixture()
    %{machinery: machinery}
  end
end
