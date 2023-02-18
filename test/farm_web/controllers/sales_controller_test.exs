defmodule FarmWeb.SalesControllerTest do
  use FarmWeb.ConnCase

  import Farm.FinanceFixtures

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

  describe "index" do
    test "lists all sales", %{conn: conn} do
      conn = get(conn, Routes.sales_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sales"
    end
  end

  describe "new sales" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sales_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sales"
    end
  end

  describe "create sales" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sales_path(conn, :create), sales: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sales_path(conn, :show, id)

      conn = get(conn, Routes.sales_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sales"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sales_path(conn, :create), sales: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sales"
    end
  end

  describe "edit sales" do
    setup [:create_sales]

    test "renders form for editing chosen sales", %{conn: conn, sales: sales} do
      conn = get(conn, Routes.sales_path(conn, :edit, sales))
      assert html_response(conn, 200) =~ "Edit Sales"
    end
  end

  describe "update sales" do
    setup [:create_sales]

    test "redirects when data is valid", %{conn: conn, sales: sales} do
      conn = put(conn, Routes.sales_path(conn, :update, sales), sales: @update_attrs)
      assert redirected_to(conn) == Routes.sales_path(conn, :show, sales)

      conn = get(conn, Routes.sales_path(conn, :show, sales))
      assert html_response(conn, 200) =~ "some updated customer_name"
    end

    test "renders errors when data is invalid", %{conn: conn, sales: sales} do
      conn = put(conn, Routes.sales_path(conn, :update, sales), sales: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sales"
    end
  end

  describe "delete sales" do
    setup [:create_sales]

    test "deletes chosen sales", %{conn: conn, sales: sales} do
      conn = delete(conn, Routes.sales_path(conn, :delete, sales))
      assert redirected_to(conn) == Routes.sales_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.sales_path(conn, :show, sales))
      end
    end
  end

  defp create_sales(_) do
    sales = sales_fixture()
    %{sales: sales}
  end
end
