defmodule FarmWeb.FeedsControllerTest do
  use FarmWeb.ConnCase

  import Farm.ProductionFixtures

  @create_attrs %{name: "some name", quantity: 42, weight: 42}
  @update_attrs %{name: "some updated name", quantity: 43, weight: 43}
  @invalid_attrs %{name: nil, quantity: nil, weight: nil}

  describe "index" do
    test "lists all feeds", %{conn: conn} do
      conn = get(conn, Routes.feeds_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Feeds"
    end
  end

  describe "new feeds" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.feeds_path(conn, :new))
      assert html_response(conn, 200) =~ "New Feeds"
    end
  end

  describe "create feeds" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.feeds_path(conn, :create), feeds: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.feeds_path(conn, :show, id)

      conn = get(conn, Routes.feeds_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Feeds"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.feeds_path(conn, :create), feeds: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Feeds"
    end
  end

  describe "edit feeds" do
    setup [:create_feeds]

    test "renders form for editing chosen feeds", %{conn: conn, feeds: feeds} do
      conn = get(conn, Routes.feeds_path(conn, :edit, feeds))
      assert html_response(conn, 200) =~ "Edit Feeds"
    end
  end

  describe "update feeds" do
    setup [:create_feeds]

    test "redirects when data is valid", %{conn: conn, feeds: feeds} do
      conn = put(conn, Routes.feeds_path(conn, :update, feeds), feeds: @update_attrs)
      assert redirected_to(conn) == Routes.feeds_path(conn, :show, feeds)

      conn = get(conn, Routes.feeds_path(conn, :show, feeds))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, feeds: feeds} do
      conn = put(conn, Routes.feeds_path(conn, :update, feeds), feeds: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Feeds"
    end
  end

  describe "delete feeds" do
    setup [:create_feeds]

    test "deletes chosen feeds", %{conn: conn, feeds: feeds} do
      conn = delete(conn, Routes.feeds_path(conn, :delete, feeds))
      assert redirected_to(conn) == Routes.feeds_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.feeds_path(conn, :show, feeds))
      end
    end
  end

  defp create_feeds(_) do
    feeds = feeds_fixture()
    %{feeds: feeds}
  end
end
