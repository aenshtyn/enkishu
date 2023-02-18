defmodule FarmWeb.MedicationControllerTest do
  use FarmWeb.ConnCase

  import Farm.InventoryFixtures

  @create_attrs %{brand: "some brand", patient: "some patient", type: "some type"}
  @update_attrs %{
    brand: "some updated brand",
    patient: "some updated patient",
    type: "some updated type"
  }
  @invalid_attrs %{brand: nil, patient: nil, type: nil}

  describe "index" do
    test "lists all medications", %{conn: conn} do
      conn = get(conn, Routes.medication_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Medications"
    end
  end

  describe "new medication" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.medication_path(conn, :new))
      assert html_response(conn, 200) =~ "New Medication"
    end
  end

  describe "create medication" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.medication_path(conn, :create), medication: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.medication_path(conn, :show, id)

      conn = get(conn, Routes.medication_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Medication"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.medication_path(conn, :create), medication: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Medication"
    end
  end

  describe "edit medication" do
    setup [:create_medication]

    test "renders form for editing chosen medication", %{conn: conn, medication: medication} do
      conn = get(conn, Routes.medication_path(conn, :edit, medication))
      assert html_response(conn, 200) =~ "Edit Medication"
    end
  end

  describe "update medication" do
    setup [:create_medication]

    test "redirects when data is valid", %{conn: conn, medication: medication} do
      conn =
        put(conn, Routes.medication_path(conn, :update, medication), medication: @update_attrs)

      assert redirected_to(conn) == Routes.medication_path(conn, :show, medication)

      conn = get(conn, Routes.medication_path(conn, :show, medication))
      assert html_response(conn, 200) =~ "some updated brand"
    end

    test "renders errors when data is invalid", %{conn: conn, medication: medication} do
      conn =
        put(conn, Routes.medication_path(conn, :update, medication), medication: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Medication"
    end
  end

  describe "delete medication" do
    setup [:create_medication]

    test "deletes chosen medication", %{conn: conn, medication: medication} do
      conn = delete(conn, Routes.medication_path(conn, :delete, medication))
      assert redirected_to(conn) == Routes.medication_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.medication_path(conn, :show, medication))
      end
    end
  end

  defp create_medication(_) do
    medication = medication_fixture()
    %{medication: medication}
  end
end
