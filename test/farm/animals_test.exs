defmodule Farm.AnimalsTest do
  use Farm.DataCase

  alias Farm.Animals

  describe "cows" do
    alias Farm.Animals.Cow

    import Farm.AnimalsFixtures

    @invalid_attrs %{breed: nil, dob: nil, name: nil, owner: nil}

    test "list_cows/0 returns all cows" do
      cow = cow_fixture()
      assert Animals.list_cows() == [cow]
    end

    test "get_cow!/1 returns the cow with given id" do
      cow = cow_fixture()
      assert Animals.get_cow!(cow.id) == cow
    end

    test "create_cow/1 with valid data creates a cow" do
      valid_attrs = %{
        breed: "some breed",
        dob: ~D[2022-02-28],
        name: "some name",
        owner: "some owner"
      }

      assert {:ok, %Cow{} = cow} = Animals.create_cow(valid_attrs)
      assert cow.breed == "some breed"
      assert cow.dob == ~D[2022-02-28]
      assert cow.name == "some name"
      assert cow.owner == "some owner"
    end

    test "create_cow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Animals.create_cow(@invalid_attrs)
    end

    test "update_cow/2 with valid data updates the cow" do
      cow = cow_fixture()

      update_attrs = %{
        breed: "some updated breed",
        dob: ~D[2022-03-01],
        name: "some updated name",
        owner: "some updated owner"
      }

      assert {:ok, %Cow{} = cow} = Animals.update_cow(cow, update_attrs)
      assert cow.breed == "some updated breed"
      assert cow.dob == ~D[2022-03-01]
      assert cow.name == "some updated name"
      assert cow.owner == "some updated owner"
    end

    test "update_cow/2 with invalid data returns error changeset" do
      cow = cow_fixture()
      assert {:error, %Ecto.Changeset{}} = Animals.update_cow(cow, @invalid_attrs)
      assert cow == Animals.get_cow!(cow.id)
    end

    test "delete_cow/1 deletes the cow" do
      cow = cow_fixture()
      assert {:ok, %Cow{}} = Animals.delete_cow(cow)
      assert_raise Ecto.NoResultsError, fn -> Animals.get_cow!(cow.id) end
    end

    test "change_cow/1 returns a cow changeset" do
      cow = cow_fixture()
      assert %Ecto.Changeset{} = Animals.change_cow(cow)
    end
  end

  describe "sheeps" do
    alias Farm.Animals.Sheep

    import Farm.AnimalsFixtures

    @invalid_attrs %{age: nil, name: nil}

    test "list_sheeps/0 returns all sheeps" do
      sheep = sheep_fixture()
      assert Animals.list_sheeps() == [sheep]
    end

    test "get_sheep!/1 returns the sheep with given id" do
      sheep = sheep_fixture()
      assert Animals.get_sheep!(sheep.id) == sheep
    end

    test "create_sheep/1 with valid data creates a sheep" do
      valid_attrs = %{age: "some age", name: "some name"}

      assert {:ok, %Sheep{} = sheep} = Animals.create_sheep(valid_attrs)
      assert sheep.age == "some age"
      assert sheep.name == "some name"
    end

    test "create_sheep/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Animals.create_sheep(@invalid_attrs)
    end

    test "update_sheep/2 with valid data updates the sheep" do
      sheep = sheep_fixture()
      update_attrs = %{age: "some updated age", name: "some updated name"}

      assert {:ok, %Sheep{} = sheep} = Animals.update_sheep(sheep, update_attrs)
      assert sheep.age == "some updated age"
      assert sheep.name == "some updated name"
    end

    test "update_sheep/2 with invalid data returns error changeset" do
      sheep = sheep_fixture()
      assert {:error, %Ecto.Changeset{}} = Animals.update_sheep(sheep, @invalid_attrs)
      assert sheep == Animals.get_sheep!(sheep.id)
    end

    test "delete_sheep/1 deletes the sheep" do
      sheep = sheep_fixture()
      assert {:ok, %Sheep{}} = Animals.delete_sheep(sheep)
      assert_raise Ecto.NoResultsError, fn -> Animals.get_sheep!(sheep.id) end
    end

    test "change_sheep/1 returns a sheep changeset" do
      sheep = sheep_fixture()
      assert %Ecto.Changeset{} = Animals.change_sheep(sheep)
    end
  end
end
