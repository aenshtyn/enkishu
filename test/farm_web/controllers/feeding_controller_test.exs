defmodule FarmWeb.FeedingControllerTest do
  use FarmWeb.ConnCase

  import Farm.ProductionFixtures

  @create_attrs %{day: ~D[2023-03-09], volume: 42}
  @update_attrs %{day: ~D[2023-03-10], volume: 43}
  @invalid_attrs %{day: nil, volume: nil}

  describe "index" do
    test "lists all feedings", %{conn: conn} do
      conn = get(conn, Routes.feeding_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Feedings"
    end
  end

  describe "new feeding" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.feeding_path(conn, :new))
      assert html_response(conn, 200) =~ "New Feeding"
    end
  end

  describe "create feeding" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.feeding_path(conn, :create), feeding: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.feeding_path(conn, :show, id)

      conn = get(conn, Routes.feeding_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Feeding"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.feeding_path(conn, :create), feeding: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Feeding"
    end
  end

  describe "edit feeding" do
    setup [:create_feeding]

    test "renders form for editing chosen feeding", %{conn: conn, feeding: feeding} do
      conn = get(conn, Routes.feeding_path(conn, :edit, feeding))
      assert html_response(conn, 200) =~ "Edit Feeding"
    end
  end

  describe "update feeding" do
    setup [:create_feeding]

    test "redirects when data is valid", %{conn: conn, feeding: feeding} do
      conn = put(conn, Routes.feeding_path(conn, :update, feeding), feeding: @update_attrs)
      assert redirected_to(conn) == Routes.feeding_path(conn, :show, feeding)

      conn = get(conn, Routes.feeding_path(conn, :show, feeding))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, feeding: feeding} do
      conn = put(conn, Routes.feeding_path(conn, :update, feeding), feeding: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Feeding"
    end
  end

  describe "delete feeding" do
    setup [:create_feeding]

    test "deletes chosen feeding", %{conn: conn, feeding: feeding} do
      conn = delete(conn, Routes.feeding_path(conn, :delete, feeding))
      assert redirected_to(conn) == Routes.feeding_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.feeding_path(conn, :show, feeding))
      end
    end
  end

  defp create_feeding(_) do
    feeding = feeding_fixture()
    %{feeding: feeding}
  end
end
