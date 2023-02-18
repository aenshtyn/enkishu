defmodule FarmWeb.Api.SalesControllerTest do
  use FarmWeb.ConnCase

  import Farm.FinanceFixtures

  alias Farm.Finance.Sales

  @create_attrs %{
    customer_name: "some customer_name",
    day: ~N[2022-06-28 08:06:00],
    price: 120.5,
    quantity: 120.5,
    unit: "some unit"
  }
  @update_attrs %{
    customer_name: "some updated customer_name",
    day: ~N[2022-06-29 08:06:00],
    price: 456.7,
    quantity: 456.7,
    unit: "some updated unit"
  }
  @invalid_attrs %{customer_name: nil, day: nil, price: nil, quantity: nil, unit: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sales", %{conn: conn} do
      conn = get(conn, Routes.api_sales_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sales" do
    test "renders sales when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_sales_path(conn, :create), sales: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_sales_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "customer_name" => "some customer_name",
               "day" => "2022-06-28T08:06:00",
               "price" => 120.5,
               "quantity" => 120.5,
               "unit" => "some unit"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_sales_path(conn, :create), sales: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sales" do
    setup [:create_sales]

    test "renders sales when data is valid", %{conn: conn, sales: %Sales{id: id} = sales} do
      conn = put(conn, Routes.api_sales_path(conn, :update, sales), sales: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_sales_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "customer_name" => "some updated customer_name",
               "day" => "2022-06-29T08:06:00",
               "price" => 456.7,
               "quantity" => 456.7,
               "unit" => "some updated unit"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, sales: sales} do
      conn = put(conn, Routes.api_sales_path(conn, :update, sales), sales: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sales" do
    setup [:create_sales]

    test "deletes chosen sales", %{conn: conn, sales: sales} do
      conn = delete(conn, Routes.api_sales_path(conn, :delete, sales))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_sales_path(conn, :show, sales))
      end
    end
  end

  defp create_sales(_) do
    sales = sales_fixture()
    %{sales: sales}
  end
end
