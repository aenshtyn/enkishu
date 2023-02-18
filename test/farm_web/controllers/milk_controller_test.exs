defmodule FarmWeb.MilkControllerTest do
  use FarmWeb.ConnCase

  import Farm.ProductsFixtures

  @create_attrs %{day: ~D[2022-02-28], milking_time: "some milking_time", volume: 120.5}
  @update_attrs %{day: ~D[2022-03-01], milking_time: "some updated milking_time", volume: 456.7}
  @invalid_attrs %{day: nil, milking_time: nil, volume: nil}

  describe "index" do
    test "lists all milks", %{conn: conn} do
      conn = get(conn, Routes.milk_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Milks"
    end
  end

  describe "new milk" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.milk_path(conn, :new))
      assert html_response(conn, 200) =~ "New Milk"
    end
  end

  describe "create milk" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.milk_path(conn, :create), milk: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.milk_path(conn, :show, id)

      conn = get(conn, Routes.milk_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Milk"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.milk_path(conn, :create), milk: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Milk"
    end
  end

  describe "edit milk" do
    setup [:create_milk]

    test "renders form for editing chosen milk", %{conn: conn, milk: milk} do
      conn = get(conn, Routes.milk_path(conn, :edit, milk))
      assert html_response(conn, 200) =~ "Edit Milk"
    end
  end

  describe "update milk" do
    setup [:create_milk]

    test "redirects when data is valid", %{conn: conn, milk: milk} do
      conn = put(conn, Routes.milk_path(conn, :update, milk), milk: @update_attrs)
      assert redirected_to(conn) == Routes.milk_path(conn, :show, milk)

      conn = get(conn, Routes.milk_path(conn, :show, milk))
      assert html_response(conn, 200) =~ "some updated milking_time"
    end

    test "renders errors when data is invalid", %{conn: conn, milk: milk} do
      conn = put(conn, Routes.milk_path(conn, :update, milk), milk: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Milk"
    end
  end

  describe "delete milk" do
    setup [:create_milk]

    test "deletes chosen milk", %{conn: conn, milk: milk} do
      conn = delete(conn, Routes.milk_path(conn, :delete, milk))
      assert redirected_to(conn) == Routes.milk_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.milk_path(conn, :show, milk))
      end
    end
  end

  defp create_milk(_) do
    milk = milk_fixture()
    %{milk: milk}
  end
end
