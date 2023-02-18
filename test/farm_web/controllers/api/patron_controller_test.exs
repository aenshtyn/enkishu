defmodule FarmWeb.Api.PatronControllerTest do
  use FarmWeb.ConnCase

  import Farm.HRFixtures

  alias Farm.HR.Patron

  @create_attrs %{
    address: "some address",
    name: "some name",
    phone_number: 42
  }
  @update_attrs %{
    address: "some updated address",
    name: "some updated name",
    phone_number: 43
  }
  @invalid_attrs %{address: nil, name: nil, phone_number: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all patrons", %{conn: conn} do
      conn = get(conn, Routes.api_patron_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create patron" do
    test "renders patron when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_patron_path(conn, :create), patron: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_patron_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some address",
               "name" => "some name",
               "phone_number" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_patron_path(conn, :create), patron: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update patron" do
    setup [:create_patron]

    test "renders patron when data is valid", %{conn: conn, patron: %Patron{id: id} = patron} do
      conn = put(conn, Routes.api_patron_path(conn, :update, patron), patron: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_patron_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "name" => "some updated name",
               "phone_number" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, patron: patron} do
      conn = put(conn, Routes.api_patron_path(conn, :update, patron), patron: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete patron" do
    setup [:create_patron]

    test "deletes chosen patron", %{conn: conn, patron: patron} do
      conn = delete(conn, Routes.api_patron_path(conn, :delete, patron))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_patron_path(conn, :show, patron))
      end
    end
  end

  defp create_patron(_) do
    patron = patron_fixture()
    %{patron: patron}
  end
end
