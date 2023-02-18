defmodule FarmWeb.Api.ProcurementsControllerTest do
  use FarmWeb.ConnCase

  import Farm.FinanceFixtures

  alias Farm.Finance.Procurement

  @create_attrs %{
    day: ~N[2022-06-28 08:12:00],
    quantity: 120.5,
    unit: "some unit",
    vendor_name: "some vendor_name"
  }
  @update_attrs %{
    day: ~N[2022-06-29 08:12:00],
    quantity: 456.7,
    unit: "some updated unit",
    vendor_name: "some updated vendor_name"
  }
  @invalid_attrs %{day: nil, quantity: nil, unit: nil, vendor_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all procurements", %{conn: conn} do
      conn = get(conn, Routes.api_procurements_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create procurements" do
    test "renders procurements when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_procurements_path(conn, :create), procurements: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_procurements_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "2022-06-28T08:12:00",
               "quantity" => 120.5,
               "unit" => "some unit",
               "vendor_name" => "some vendor_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_procurements_path(conn, :create), procurements: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update procurements" do
    setup [:create_procurements]

    test "renders procurements when data is valid", %{
      conn: conn,
      procurements: %Procurements{id: id} = procurements
    } do
      conn =
        put(conn, Routes.api_procurements_path(conn, :update, procurements), procurements: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_procurements_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "2022-06-29T08:12:00",
               "quantity" => 456.7,
               "unit" => "some updated unit",
               "vendor_name" => "some updated vendor_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, procurements: procurements} do
      conn =
        put(conn, Routes.api_procurements_path(conn, :update, procurements), procurements: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete procurements" do
    setup [:create_procurements]

    test "deletes chosen procurements", %{conn: conn, procurements: procurements} do
      conn = delete(conn, Routes.api_procurements_path(conn, :delete, procurements))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_procurements_path(conn, :show, procurements))
      end
    end
  end

  defp create_procurements(_) do
    procurements = procurements_fixture()
    %{procurements: procurements}
  end
end
