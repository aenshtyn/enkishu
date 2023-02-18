defmodule Farm.LandTest do
  use Farm.DataCase

  alias Farm.Land

  describe "paddocks" do
    alias Farm.Land.Paddock

    import Farm.LandFixtures

    @invalid_attrs %{description: nil, number: nil, size: nil}

    test "list_paddocks/0 returns all paddocks" do
      paddock = paddock_fixture()
      assert Land.list_paddocks() == [paddock]
    end

    test "get_paddock!/1 returns the paddock with given id" do
      paddock = paddock_fixture()
      assert Land.get_paddock!(paddock.id) == paddock
    end

    test "create_paddock/1 with valid data creates a paddock" do
      valid_attrs = %{description: "some description", number: 42, size: 120.5}

      assert {:ok, %Paddock{} = paddock} = Land.create_paddock(valid_attrs)
      assert paddock.description == "some description"
      assert paddock.number == 42
      assert paddock.size == 120.5
    end

    test "create_paddock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Land.create_paddock(@invalid_attrs)
    end

    test "update_paddock/2 with valid data updates the paddock" do
      paddock = paddock_fixture()
      update_attrs = %{description: "some updated description", number: 43, size: 456.7}

      assert {:ok, %Paddock{} = paddock} = Land.update_paddock(paddock, update_attrs)
      assert paddock.description == "some updated description"
      assert paddock.number == 43
      assert paddock.size == 456.7
    end

    test "update_paddock/2 with invalid data returns error changeset" do
      paddock = paddock_fixture()
      assert {:error, %Ecto.Changeset{}} = Land.update_paddock(paddock, @invalid_attrs)
      assert paddock == Land.get_paddock!(paddock.id)
    end

    test "delete_paddock/1 deletes the paddock" do
      paddock = paddock_fixture()
      assert {:ok, %Paddock{}} = Land.delete_paddock(paddock)
      assert_raise Ecto.NoResultsError, fn -> Land.get_paddock!(paddock.id) end
    end

    test "change_paddock/1 returns a paddock changeset" do
      paddock = paddock_fixture()
      assert %Ecto.Changeset{} = Land.change_paddock(paddock)
    end
  end

  describe "arable_lands" do
    alias Farm.Land.Arable_land

    import Farm.LandFixtures

    @invalid_attrs %{description: nil, number: nil, size: nil}

    test "list_arable_lands/0 returns all arable_lands" do
      arable_land = arable_land_fixture()
      assert Land.list_arable_lands() == [arable_land]
    end

    test "get_arable_land!/1 returns the arable_land with given id" do
      arable_land = arable_land_fixture()
      assert Land.get_arable_land!(arable_land.id) == arable_land
    end

    test "create_arable_land/1 with valid data creates a arable_land" do
      valid_attrs = %{description: "some description", number: 42, size: 120.5}

      assert {:ok, %Arable_land{} = arable_land} = Land.create_arable_land(valid_attrs)
      assert arable_land.description == "some description"
      assert arable_land.number == 42
      assert arable_land.size == 120.5
    end

    test "create_arable_land/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Land.create_arable_land(@invalid_attrs)
    end

    test "update_arable_land/2 with valid data updates the arable_land" do
      arable_land = arable_land_fixture()
      update_attrs = %{description: "some updated description", number: 43, size: 456.7}

      assert {:ok, %Arable_land{} = arable_land} =
               Land.update_arable_land(arable_land, update_attrs)

      assert arable_land.description == "some updated description"
      assert arable_land.number == 43
      assert arable_land.size == 456.7
    end

    test "update_arable_land/2 with invalid data returns error changeset" do
      arable_land = arable_land_fixture()
      assert {:error, %Ecto.Changeset{}} = Land.update_arable_land(arable_land, @invalid_attrs)
      assert arable_land == Land.get_arable_land!(arable_land.id)
    end

    test "delete_arable_land/1 deletes the arable_land" do
      arable_land = arable_land_fixture()
      assert {:ok, %Arable_land{}} = Land.delete_arable_land(arable_land)
      assert_raise Ecto.NoResultsError, fn -> Land.get_arable_land!(arable_land.id) end
    end

    test "change_arable_land/1 returns a arable_land changeset" do
      arable_land = arable_land_fixture()
      assert %Ecto.Changeset{} = Land.change_arable_land(arable_land)
    end
  end

  describe "arable" do
    alias Farm.Land.Arable

    import Farm.LandFixtures

    @invalid_attrs %{description: nil, number: nil, size: nil}

    test "list_arable/0 returns all arable" do
      arable = arable_fixture()
      assert Land.list_arable() == [arable]
    end

    test "get_arable!/1 returns the arable with given id" do
      arable = arable_fixture()
      assert Land.get_arable!(arable.id) == arable
    end

    test "create_arable/1 with valid data creates a arable" do
      valid_attrs = %{description: "some description", number: 42, size: 120.5}

      assert {:ok, %Arable{} = arable} = Land.create_arable(valid_attrs)
      assert arable.description == "some description"
      assert arable.number == 42
      assert arable.size == 120.5
    end

    test "create_arable/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Land.create_arable(@invalid_attrs)
    end

    test "update_arable/2 with valid data updates the arable" do
      arable = arable_fixture()
      update_attrs = %{description: "some updated description", number: 43, size: 456.7}

      assert {:ok, %Arable{} = arable} = Land.update_arable(arable, update_attrs)
      assert arable.description == "some updated description"
      assert arable.number == 43
      assert arable.size == 456.7
    end

    test "update_arable/2 with invalid data returns error changeset" do
      arable = arable_fixture()
      assert {:error, %Ecto.Changeset{}} = Land.update_arable(arable, @invalid_attrs)
      assert arable == Land.get_arable!(arable.id)
    end

    test "delete_arable/1 deletes the arable" do
      arable = arable_fixture()
      assert {:ok, %Arable{}} = Land.delete_arable(arable)
      assert_raise Ecto.NoResultsError, fn -> Land.get_arable!(arable.id) end
    end

    test "change_arable/1 returns a arable changeset" do
      arable = arable_fixture()
      assert %Ecto.Changeset{} = Land.change_arable(arable)
    end
  end
end
