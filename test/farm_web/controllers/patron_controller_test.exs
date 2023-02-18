defmodule FarmWeb.PatronControllerTest do
  use FarmWeb.ConnCase

  import Farm.HRFixtures

  @create_attrs %{address: "some address", name: "some name", phone_number: 42}
  @update_attrs %{address: "some updated address", name: "some updated name", phone_number: 43}
  @invalid_attrs %{address: nil, name: nil, phone_number: nil}

  describe "index" do
    test "lists all patrons", %{conn: conn} do
      conn = get(conn, Routes.patron_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Patrons"
    end
  end

  describe "new patron" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.patron_path(conn, :new))
      assert html_response(conn, 200) =~ "New Patron"
    end
  end

  describe "create patron" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.patron_path(conn, :create), patron: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.patron_path(conn, :show, id)

      conn = get(conn, Routes.patron_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Patron"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.patron_path(conn, :create), patron: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Patron"
    end
  end

  describe "edit patron" do
    setup [:create_patron]

    test "renders form for editing chosen patron", %{conn: conn, patron: patron} do
      conn = get(conn, Routes.patron_path(conn, :edit, patron))
      assert html_response(conn, 200) =~ "Edit Patron"
    end
  end

  describe "update patron" do
    setup [:create_patron]

    test "redirects when data is valid", %{conn: conn, patron: patron} do
      conn = put(conn, Routes.patron_path(conn, :update, patron), patron: @update_attrs)
      assert redirected_to(conn) == Routes.patron_path(conn, :show, patron)

      conn = get(conn, Routes.patron_path(conn, :show, patron))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, patron: patron} do
      conn = put(conn, Routes.patron_path(conn, :update, patron), patron: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Patron"
    end
  end

  describe "delete patron" do
    setup [:create_patron]

    test "deletes chosen patron", %{conn: conn, patron: patron} do
      conn = delete(conn, Routes.patron_path(conn, :delete, patron))
      assert redirected_to(conn) == Routes.patron_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.patron_path(conn, :show, patron))
      end
    end
  end

  defp create_patron(_) do
    patron = patron_fixture()
    %{patron: patron}
  end
end
