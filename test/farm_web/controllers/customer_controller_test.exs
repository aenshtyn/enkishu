defmodule FarmWeb.CustomerControllerTest do
  use FarmWeb.ConnCase

  import Farm.FinanceFixtures

  @create_attrs %{location: "some location", name: "some name", phone_number: 42}
  @update_attrs %{location: "some updated location", name: "some updated name", phone_number: 43}
  @invalid_attrs %{location: nil, name: nil, phone_number: nil}

  describe "index" do
    test "lists all customers", %{conn: conn} do
      conn = get(conn, Routes.customer_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Customers"
    end
  end

  describe "new customer" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.customer_path(conn, :new))
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "create customer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.customer_path(conn, :show, id)

      conn = get(conn, Routes.customer_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Customer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "edit customer" do
    setup [:create_customer]

    test "renders form for editing chosen customer", %{conn: conn, customer: customer} do
      conn = get(conn, Routes.customer_path(conn, :edit, customer))
      assert html_response(conn, 200) =~ "Edit Customer"
    end
  end

  describe "update customer" do
    setup [:create_customer]

    test "redirects when data is valid", %{conn: conn, customer: customer} do
      conn = put(conn, Routes.customer_path(conn, :update, customer), customer: @update_attrs)
      assert redirected_to(conn) == Routes.customer_path(conn, :show, customer)

      conn = get(conn, Routes.customer_path(conn, :show, customer))
      assert html_response(conn, 200) =~ "some updated location"
    end

    test "renders errors when data is invalid", %{conn: conn, customer: customer} do
      conn = put(conn, Routes.customer_path(conn, :update, customer), customer: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Customer"
    end
  end

  describe "delete customer" do
    setup [:create_customer]

    test "deletes chosen customer", %{conn: conn, customer: customer} do
      conn = delete(conn, Routes.customer_path(conn, :delete, customer))
      assert redirected_to(conn) == Routes.customer_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.customer_path(conn, :show, customer))
      end
    end
  end

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end
end
