defmodule FarmWeb.Api.MilkControllerTest do
  use FarmWeb.ConnCase

  import Farm.ProductsFixtures

  alias Farm.Products.Milk

  @create_attrs %{
    day: ~D[2022-02-28],
    milking_time: "some milking_time",
    volume: 120.5
  }
  @update_attrs %{
    day: ~D[2022-03-01],
    milking_time: "some updated milking_time",
    volume: 456.7
  }
  @invalid_attrs %{day: nil, milking_time: nil, volume: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all milks", %{conn: conn} do
      conn = get(conn, Routes.api_milk_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create milk" do
    test "renders milk when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_milk_path(conn, :create), milk: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_milk_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "2022-02-28",
               "milking_time" => "some milking_time",
               "volume" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_milk_path(conn, :create), milk: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update milk" do
    setup [:create_milk]

    test "renders milk when data is valid", %{conn: conn, milk: %Milk{id: id} = milk} do
      conn = put(conn, Routes.api_milk_path(conn, :update, milk), milk: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_milk_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "2022-03-01",
               "milking_time" => "some updated milking_time",
               "volume" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, milk: milk} do
      conn = put(conn, Routes.api_milk_path(conn, :update, milk), milk: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete milk" do
    setup [:create_milk]

    test "deletes chosen milk", %{conn: conn, milk: milk} do
      conn = delete(conn, Routes.api_milk_path(conn, :delete, milk))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_milk_path(conn, :show, milk))
      end
    end
  end

  defp create_milk(_) do
    milk = milk_fixture()
    %{milk: milk}
  end
end
