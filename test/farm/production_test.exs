defmodule Farm.ProductionTest do
  use Farm.DataCase

  alias Farm.Production

  describe "crops" do
    alias Farm.Production.Crop

    import Farm.ProductionFixtures

    @invalid_attrs %{fertilizer: nil, maturity: nil, name: nil, plating_day: nil, production_per_acre: nil, rainfall_requirements: nil, scientific_name: nil, variety: nil, weeding: nil}

    test "list_crops/0 returns all crops" do
      crop = crop_fixture()
      assert Production.list_crops() == [crop]
    end

    test "get_crop!/1 returns the crop with given id" do
      crop = crop_fixture()
      assert Production.get_crop!(crop.id) == crop
    end

    test "create_crop/1 with valid data creates a crop" do
      valid_attrs = %{fertilizer: true, maturity: 42, name: "some name", plating_day: ~D[2023-03-09], production_per_acre: 42, rainfall_requirements: 42, scientific_name: "some scientific_name", variety: "some variety", weeding: true}

      assert {:ok, %Crop{} = crop} = Production.create_crop(valid_attrs)
      assert crop.fertilizer == true
      assert crop.maturity == 42
      assert crop.name == "some name"
      assert crop.plating_day == ~D[2023-03-09]
      assert crop.production_per_acre == 42
      assert crop.rainfall_requirements == 42
      assert crop.scientific_name == "some scientific_name"
      assert crop.variety == "some variety"
      assert crop.weeding == true
    end

    test "create_crop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Production.create_crop(@invalid_attrs)
    end

    test "update_crop/2 with valid data updates the crop" do
      crop = crop_fixture()
      update_attrs = %{fertilizer: false, maturity: 43, name: "some updated name", plating_day: ~D[2023-03-10], production_per_acre: 43, rainfall_requirements: 43, scientific_name: "some updated scientific_name", variety: "some updated variety", weeding: false}

      assert {:ok, %Crop{} = crop} = Production.update_crop(crop, update_attrs)
      assert crop.fertilizer == false
      assert crop.maturity == 43
      assert crop.name == "some updated name"
      assert crop.plating_day == ~D[2023-03-10]
      assert crop.production_per_acre == 43
      assert crop.rainfall_requirements == 43
      assert crop.scientific_name == "some updated scientific_name"
      assert crop.variety == "some updated variety"
      assert crop.weeding == false
    end

    test "update_crop/2 with invalid data returns error changeset" do
      crop = crop_fixture()
      assert {:error, %Ecto.Changeset{}} = Production.update_crop(crop, @invalid_attrs)
      assert crop == Production.get_crop!(crop.id)
    end

    test "delete_crop/1 deletes the crop" do
      crop = crop_fixture()
      assert {:ok, %Crop{}} = Production.delete_crop(crop)
      assert_raise Ecto.NoResultsError, fn -> Production.get_crop!(crop.id) end
    end

    test "change_crop/1 returns a crop changeset" do
      crop = crop_fixture()
      assert %Ecto.Changeset{} = Production.change_crop(crop)
    end
  end
end
