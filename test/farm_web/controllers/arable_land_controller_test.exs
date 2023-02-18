defmodule FarmWeb.Arable_landControllerTest do
  use FarmWeb.ConnCase

  import Farm.LandFixtures

  @create_attrs %{description: "some description", number: 42, size: 120.5}
  @update_attrs %{description: "some updated description", number: 43, size: 456.7}
  @invalid_attrs %{description: nil, number: nil, size: nil}

  describe "index" do
    test "lists all arable_lands", %{conn: conn} do
      conn = get(conn, Routes.arable_land_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Arable lands"
    end
  end

  describe "new arable_land" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.arable_land_path(conn, :new))
      assert html_response(conn, 200) =~ "New Arable land"
    end
  end

  describe "create arable_land" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.arable_land_path(conn, :create), arable_land: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.arable_land_path(conn, :show, id)

      conn = get(conn, Routes.arable_land_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Arable land"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.arable_land_path(conn, :create), arable_land: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Arable land"
    end
  end

  describe "edit arable_land" do
    setup [:create_arable_land]

    test "renders form for editing chosen arable_land", %{conn: conn, arable_land: arable_land} do
      conn = get(conn, Routes.arable_land_path(conn, :edit, arable_land))
      assert html_response(conn, 200) =~ "Edit Arable land"
    end
  end

  describe "update arable_land" do
    setup [:create_arable_land]

    test "redirects when data is valid", %{conn: conn, arable_land: arable_land} do
      conn =
        put(conn, Routes.arable_land_path(conn, :update, arable_land), arable_land: @update_attrs)

      assert redirected_to(conn) == Routes.arable_land_path(conn, :show, arable_land)

      conn = get(conn, Routes.arable_land_path(conn, :show, arable_land))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, arable_land: arable_land} do
      conn =
        put(conn, Routes.arable_land_path(conn, :update, arable_land), arable_land: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Arable land"
    end
  end

  describe "delete arable_land" do
    setup [:create_arable_land]

    test "deletes chosen arable_land", %{conn: conn, arable_land: arable_land} do
      conn = delete(conn, Routes.arable_land_path(conn, :delete, arable_land))
      assert redirected_to(conn) == Routes.arable_land_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.arable_land_path(conn, :show, arable_land))
      end
    end
  end

  defp create_arable_land(_) do
    arable_land = arable_land_fixture()
    %{arable_land: arable_land}
  end
end
