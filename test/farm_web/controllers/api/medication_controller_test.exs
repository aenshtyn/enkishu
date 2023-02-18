defmodule FarmWeb.Api.MedicationControllerTest do
  use FarmWeb.ConnCase

  import Farm.InventoryFixtures

  alias Farm.Inventory.Medication

  @create_attrs %{
    brand: "some brand",
    patient: "some patient",
    type: "some type"
  }
  @update_attrs %{
    brand: "some updated brand",
    patient: "some updated patient",
    type: "some updated type"
  }
  @invalid_attrs %{brand: nil, patient: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all medications", %{conn: conn} do
      conn = get(conn, Routes.api_medication_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create medication" do
    test "renders medication when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_medication_path(conn, :create), medication: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_medication_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "brand" => "some brand",
               "patient" => "some patient",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_medication_path(conn, :create), medication: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update medication" do
    setup [:create_medication]

    test "renders medication when data is valid", %{
      conn: conn,
      medication: %Medication{id: id} = medication
    } do
      conn =
        put(conn, Routes.api_medication_path(conn, :update, medication), medication: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_medication_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "brand" => "some updated brand",
               "patient" => "some updated patient",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, medication: medication} do
      conn =
        put(conn, Routes.api_medication_path(conn, :update, medication),
          medication: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete medication" do
    setup [:create_medication]

    test "deletes chosen medication", %{conn: conn, medication: medication} do
      conn = delete(conn, Routes.api_medication_path(conn, :delete, medication))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_medication_path(conn, :show, medication))
      end
    end
  end

  defp create_medication(_) do
    medication = medication_fixture()
    %{medication: medication}
  end
end
