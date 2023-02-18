defmodule FarmWeb.MachineryControllerTest do
  use FarmWeb.ConnCase

  import Farm.InventoryFixtures

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

  describe "index" do
    test "lists all machinerys", %{conn: conn} do
      conn = get(conn, Routes.machinery_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Machinerys"
    end
  end

  describe "new machinery" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.machinery_path(conn, :new))
      assert html_response(conn, 200) =~ "New Machinery"
    end
  end

  describe "create machinery" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.machinery_path(conn, :create), machinery: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.machinery_path(conn, :show, id)

      conn = get(conn, Routes.machinery_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Machinery"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.machinery_path(conn, :create), machinery: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Machinery"
    end
  end

  describe "edit machinery" do
    setup [:create_machinery]

    test "renders form for editing chosen machinery", %{conn: conn, machinery: machinery} do
      conn = get(conn, Routes.machinery_path(conn, :edit, machinery))
      assert html_response(conn, 200) =~ "Edit Machinery"
    end
  end

  describe "update machinery" do
    setup [:create_machinery]

    test "redirects when data is valid", %{conn: conn, machinery: machinery} do
      conn = put(conn, Routes.machinery_path(conn, :update, machinery), machinery: @update_attrs)
      assert redirected_to(conn) == Routes.machinery_path(conn, :show, machinery)

      conn = get(conn, Routes.machinery_path(conn, :show, machinery))
      assert html_response(conn, 200) =~ "some updated area_of_use"
    end

    test "renders errors when data is invalid", %{conn: conn, machinery: machinery} do
      conn = put(conn, Routes.machinery_path(conn, :update, machinery), machinery: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Machinery"
    end
  end

  describe "delete machinery" do
    setup [:create_machinery]

    test "deletes chosen machinery", %{conn: conn, machinery: machinery} do
      conn = delete(conn, Routes.machinery_path(conn, :delete, machinery))
      assert redirected_to(conn) == Routes.machinery_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.machinery_path(conn, :show, machinery))
      end
    end
  end

  defp create_machinery(_) do
    machinery = machinery_fixture()
    %{machinery: machinery}
  end
end
