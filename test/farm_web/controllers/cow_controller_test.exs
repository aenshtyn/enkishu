defmodule FarmWeb.CowControllerTest do
  use FarmWeb.ConnCase

  import Farm.AnimalsFixtures

  @create_attrs %{
    breed: "some breed",
    dob: ~D[2022-02-28],
    name: "some name",
    owner: "some owner"
  }
  @update_attrs %{
    breed: "some updated breed",
    dob: ~D[2022-03-01],
    name: "some updated name",
    owner: "some updated owner"
  }
  @invalid_attrs %{breed: nil, dob: nil, name: nil, owner: nil}

  describe "index" do
    test "lists all cows", %{conn: conn} do
      conn = get(conn, Routes.cow_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Cows"
    end
  end

  describe "new cow" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.cow_path(conn, :new))
      assert html_response(conn, 200) =~ "New Cow"
    end
  end

  describe "create cow" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cow_path(conn, :create), cow: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.cow_path(conn, :show, id)

      conn = get(conn, Routes.cow_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Cow"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cow_path(conn, :create), cow: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Cow"
    end
  end

  describe "edit cow" do
    setup [:create_cow]

    test "renders form for editing chosen cow", %{conn: conn, cow: cow} do
      conn = get(conn, Routes.cow_path(conn, :edit, cow))
      assert html_response(conn, 200) =~ "Edit Cow"
    end
  end

  describe "update cow" do
    setup [:create_cow]

    test "redirects when data is valid", %{conn: conn, cow: cow} do
      conn = put(conn, Routes.cow_path(conn, :update, cow), cow: @update_attrs)
      assert redirected_to(conn) == Routes.cow_path(conn, :show, cow)

      conn = get(conn, Routes.cow_path(conn, :show, cow))
      assert html_response(conn, 200) =~ "some updated breed"
    end

    test "renders errors when data is invalid", %{conn: conn, cow: cow} do
      conn = put(conn, Routes.cow_path(conn, :update, cow), cow: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Cow"
    end
  end

  describe "delete cow" do
    setup [:create_cow]

    test "deletes chosen cow", %{conn: conn, cow: cow} do
      conn = delete(conn, Routes.cow_path(conn, :delete, cow))
      assert redirected_to(conn) == Routes.cow_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.cow_path(conn, :show, cow))
      end
    end
  end

  defp create_cow(_) do
    cow = cow_fixture()
    %{cow: cow}
  end
end
