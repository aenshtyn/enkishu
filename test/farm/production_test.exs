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

  describe "feedings" do
    alias Farm.Production.Feeding

    import Farm.ProductionFixtures

    @invalid_attrs %{day: nil, volume: nil}

    test "list_feedings/0 returns all feedings" do
      feeding = feeding_fixture()
      assert Production.list_feedings() == [feeding]
    end

    test "get_feeding!/1 returns the feeding with given id" do
      feeding = feeding_fixture()
      assert Production.get_feeding!(feeding.id) == feeding
    end

    test "create_feeding/1 with valid data creates a feeding" do
      valid_attrs = %{day: ~D[2023-03-09], volume: 42}

      assert {:ok, %Feeding{} = feeding} = Production.create_feeding(valid_attrs)
      assert feeding.day == ~D[2023-03-09]
      assert feeding.volume == 42
    end

    test "create_feeding/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Production.create_feeding(@invalid_attrs)
    end

    test "update_feeding/2 with valid data updates the feeding" do
      feeding = feeding_fixture()
      update_attrs = %{day: ~D[2023-03-10], volume: 43}

      assert {:ok, %Feeding{} = feeding} = Production.update_feeding(feeding, update_attrs)
      assert feeding.day == ~D[2023-03-10]
      assert feeding.volume == 43
    end

    test "update_feeding/2 with invalid data returns error changeset" do
      feeding = feeding_fixture()
      assert {:error, %Ecto.Changeset{}} = Production.update_feeding(feeding, @invalid_attrs)
      assert feeding == Production.get_feeding!(feeding.id)
    end

    test "delete_feeding/1 deletes the feeding" do
      feeding = feeding_fixture()
      assert {:ok, %Feeding{}} = Production.delete_feeding(feeding)
      assert_raise Ecto.NoResultsError, fn -> Production.get_feeding!(feeding.id) end
    end

    test "change_feeding/1 returns a feeding changeset" do
      feeding = feeding_fixture()
      assert %Ecto.Changeset{} = Production.change_feeding(feeding)
    end
  end

  describe "feeds" do
    alias Farm.Production.Feeds

    import Farm.ProductionFixtures

    @invalid_attrs %{name: nil, quantity: nil, weight: nil}

    test "list_feeds/0 returns all feeds" do
      feeds = feeds_fixture()
      assert Production.list_feeds() == [feeds]
    end

    test "get_feeds!/1 returns the feeds with given id" do
      feeds = feeds_fixture()
      assert Production.get_feeds!(feeds.id) == feeds
    end

    test "create_feeds/1 with valid data creates a feeds" do
      valid_attrs = %{name: "some name", quantity: 42, weight: 42}

      assert {:ok, %Feeds{} = feeds} = Production.create_feeds(valid_attrs)
      assert feeds.name == "some name"
      assert feeds.quantity == 42
      assert feeds.weight == 42
    end

    test "create_feeds/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Production.create_feeds(@invalid_attrs)
    end

    test "update_feeds/2 with valid data updates the feeds" do
      feeds = feeds_fixture()
      update_attrs = %{name: "some updated name", quantity: 43, weight: 43}

      assert {:ok, %Feeds{} = feeds} = Production.update_feeds(feeds, update_attrs)
      assert feeds.name == "some updated name"
      assert feeds.quantity == 43
      assert feeds.weight == 43
    end

    test "update_feeds/2 with invalid data returns error changeset" do
      feeds = feeds_fixture()
      assert {:error, %Ecto.Changeset{}} = Production.update_feeds(feeds, @invalid_attrs)
      assert feeds == Production.get_feeds!(feeds.id)
    end

    test "delete_feeds/1 deletes the feeds" do
      feeds = feeds_fixture()
      assert {:ok, %Feeds{}} = Production.delete_feeds(feeds)
      assert_raise Ecto.NoResultsError, fn -> Production.get_feeds!(feeds.id) end
    end

    test "change_feeds/1 returns a feeds changeset" do
      feeds = feeds_fixture()
      assert %Ecto.Changeset{} = Production.change_feeds(feeds)
    end
  end
end
