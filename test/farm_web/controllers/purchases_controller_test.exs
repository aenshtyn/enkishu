defmodule FarmWeb.ProcurementsControllerTest do
  use FarmWeb.ConnCase

  import Farm.FinanceFixtures

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

  describe "index" do
    test "lists all procurements", %{conn: conn} do
      conn = get(conn, Routes.procurements_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Procurements"
    end
  end

  describe "new procurements" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.procurements_path(conn, :new))
      assert html_response(conn, 200) =~ "New Procurements"
    end
  end

  describe "create procurements" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.procurements_path(conn, :create), procurements: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.procurements_path(conn, :show, id)

      conn = get(conn, Routes.procurements_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Procurements"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.procurements_path(conn, :create), procurements: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Procurements"
    end
  end

  describe "edit procurements" do
    setup [:create_procurements]

    test "renders form for editing chosen procurements", %{conn: conn, procurements: procurements} do
      conn = get(conn, Routes.procurements_path(conn, :edit, procurements))
      assert html_response(conn, 200) =~ "Edit Procurements"
    end
  end

  describe "update procurements" do
    setup [:create_procurements]

    test "redirects when data is valid", %{conn: conn, procurements: procurements} do
      conn = put(conn, Routes.procurements_path(conn, :update, procurements), procurements: @update_attrs)
      assert redirected_to(conn) == Routes.procurements_path(conn, :show, procurements)

      conn = get(conn, Routes.procurements_path(conn, :show, procurements))
      assert html_response(conn, 200) =~ "some updated unit"
    end

    test "renders errors when data is invalid", %{conn: conn, procurements: procurements} do
      conn = put(conn, Routes.procurements_path(conn, :update, procurements), procurements: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Procurements"
    end
  end

  describe "delete procurements" do
    setup [:create_procurements]

    test "deletes chosen procurements", %{conn: conn, procurements: procurements} do
      conn = delete(conn, Routes.procurements_path(conn, :delete, procurements))
      assert redirected_to(conn) == Routes.procurements_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.procurements_path(conn, :show, procurements))
      end
    end
  end

  defp create_procurements(_) do
    procurements = procurements_fixture()
    %{procurements: procurements}
  end
end
