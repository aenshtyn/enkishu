defmodule FarmWeb.ArableControllerTest do
  use FarmWeb.ConnCase

  import Farm.LandFixtures

  @create_attrs %{description: "some description", number: 42, size: 120.5}
  @update_attrs %{description: "some updated description", number: 43, size: 456.7}
  @invalid_attrs %{description: nil, number: nil, size: nil}

  describe "index" do
    test "lists all arable", %{conn: conn} do
      conn = get(conn, Routes.arable_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Arable"
    end
  end

  describe "new arable" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.arable_path(conn, :new))
      assert html_response(conn, 200) =~ "New Arable"
    end
  end

  describe "create arable" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.arable_path(conn, :create), arable: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.arable_path(conn, :show, id)

      conn = get(conn, Routes.arable_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Arable"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.arable_path(conn, :create), arable: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Arable"
    end
  end

  describe "edit arable" do
    setup [:create_arable]

    test "renders form for editing chosen arable", %{conn: conn, arable: arable} do
      conn = get(conn, Routes.arable_path(conn, :edit, arable))
      assert html_response(conn, 200) =~ "Edit Arable"
    end
  end

  describe "update arable" do
    setup [:create_arable]

    test "redirects when data is valid", %{conn: conn, arable: arable} do
      conn = put(conn, Routes.arable_path(conn, :update, arable), arable: @update_attrs)
      assert redirected_to(conn) == Routes.arable_path(conn, :show, arable)

      conn = get(conn, Routes.arable_path(conn, :show, arable))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, arable: arable} do
      conn = put(conn, Routes.arable_path(conn, :update, arable), arable: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Arable"
    end
  end

  describe "delete arable" do
    setup [:create_arable]

    test "deletes chosen arable", %{conn: conn, arable: arable} do
      conn = delete(conn, Routes.arable_path(conn, :delete, arable))
      assert redirected_to(conn) == Routes.arable_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.arable_path(conn, :show, arable))
      end
    end
  end

  defp create_arable(_) do
    arable = arable_fixture()
    %{arable: arable}
  end
end
