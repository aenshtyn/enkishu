defmodule FarmWeb.CropControllerTest do
  use FarmWeb.ConnCase

  import Farm.ProductionFixtures

  @create_attrs %{fertilizer: true, maturity: 42, name: "some name", plating_day: ~D[2023-03-09], production_per_acre: 42, rainfall_requirements: 42, scientific_name: "some scientific_name", variety: "some variety", weeding: true}
  @update_attrs %{fertilizer: false, maturity: 43, name: "some updated name", plating_day: ~D[2023-03-10], production_per_acre: 43, rainfall_requirements: 43, scientific_name: "some updated scientific_name", variety: "some updated variety", weeding: false}
  @invalid_attrs %{fertilizer: nil, maturity: nil, name: nil, plating_day: nil, production_per_acre: nil, rainfall_requirements: nil, scientific_name: nil, variety: nil, weeding: nil}

  describe "index" do
    test "lists all crops", %{conn: conn} do
      conn = get(conn, Routes.crop_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Crops"
    end
  end

  describe "new crop" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.crop_path(conn, :new))
      assert html_response(conn, 200) =~ "New Crop"
    end
  end

  describe "create crop" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.crop_path(conn, :create), crop: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.crop_path(conn, :show, id)

      conn = get(conn, Routes.crop_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Crop"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.crop_path(conn, :create), crop: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Crop"
    end
  end

  describe "edit crop" do
    setup [:create_crop]

    test "renders form for editing chosen crop", %{conn: conn, crop: crop} do
      conn = get(conn, Routes.crop_path(conn, :edit, crop))
      assert html_response(conn, 200) =~ "Edit Crop"
    end
  end

  describe "update crop" do
    setup [:create_crop]

    test "redirects when data is valid", %{conn: conn, crop: crop} do
      conn = put(conn, Routes.crop_path(conn, :update, crop), crop: @update_attrs)
      assert redirected_to(conn) == Routes.crop_path(conn, :show, crop)

      conn = get(conn, Routes.crop_path(conn, :show, crop))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, crop: crop} do
      conn = put(conn, Routes.crop_path(conn, :update, crop), crop: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Crop"
    end
  end

  describe "delete crop" do
    setup [:create_crop]

    test "deletes chosen crop", %{conn: conn, crop: crop} do
      conn = delete(conn, Routes.crop_path(conn, :delete, crop))
      assert redirected_to(conn) == Routes.crop_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.crop_path(conn, :show, crop))
      end
    end
  end

  defp create_crop(_) do
    crop = crop_fixture()
    %{crop: crop}
  end
end
