defmodule FarmWeb.PaddockControllerTest do
  use FarmWeb.ConnCase

  import Farm.LandFixtures

  @create_attrs %{description: "some description", number: 42, size: 120.5}
  @update_attrs %{description: "some updated description", number: 43, size: 456.7}
  @invalid_attrs %{description: nil, number: nil, size: nil}

  describe "index" do
    test "lists all paddocks", %{conn: conn} do
      conn = get(conn, Routes.paddock_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Paddocks"
    end
  end

  describe "new paddock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.paddock_path(conn, :new))
      assert html_response(conn, 200) =~ "New Paddock"
    end
  end

  describe "create paddock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.paddock_path(conn, :create), paddock: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.paddock_path(conn, :show, id)

      conn = get(conn, Routes.paddock_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Paddock"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.paddock_path(conn, :create), paddock: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Paddock"
    end
  end

  describe "edit paddock" do
    setup [:create_paddock]

    test "renders form for editing chosen paddock", %{conn: conn, paddock: paddock} do
      conn = get(conn, Routes.paddock_path(conn, :edit, paddock))
      assert html_response(conn, 200) =~ "Edit Paddock"
    end
  end

  describe "update paddock" do
    setup [:create_paddock]

    test "redirects when data is valid", %{conn: conn, paddock: paddock} do
      conn = put(conn, Routes.paddock_path(conn, :update, paddock), paddock: @update_attrs)
      assert redirected_to(conn) == Routes.paddock_path(conn, :show, paddock)

      conn = get(conn, Routes.paddock_path(conn, :show, paddock))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, paddock: paddock} do
      conn = put(conn, Routes.paddock_path(conn, :update, paddock), paddock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Paddock"
    end
  end

  describe "delete paddock" do
    setup [:create_paddock]

    test "deletes chosen paddock", %{conn: conn, paddock: paddock} do
      conn = delete(conn, Routes.paddock_path(conn, :delete, paddock))
      assert redirected_to(conn) == Routes.paddock_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.paddock_path(conn, :show, paddock))
      end
    end
  end

  defp create_paddock(_) do
    paddock = paddock_fixture()
    %{paddock: paddock}
  end
end
