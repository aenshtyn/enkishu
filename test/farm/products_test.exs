defmodule Farm.ProductsTest do
  use Farm.DataCase

  alias Farm.Products

  describe "milks" do
    alias Farm.Products.Milk

    import Farm.ProductsFixtures

    @invalid_attrs %{day: nil, milking_time: nil, volume: nil}

    test "list_milks/0 returns all milks" do
      milk = milk_fixture()
      assert Products.list_milks() == [milk]
    end

    test "get_milk!/1 returns the milk with given id" do
      milk = milk_fixture()
      assert Products.get_milk!(milk.id) == milk
    end

    test "create_milk/1 with valid data creates a milk" do
      valid_attrs = %{day: ~D[2022-02-28], milking_time: "some milking_time", volume: 120.5}

      assert {:ok, %Milk{} = milk} = Products.create_milk(valid_attrs)
      assert milk.day == ~D[2022-02-28]
      assert milk.milking_time == "some milking_time"
      assert milk.volume == 120.5
    end

    test "create_milk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_milk(@invalid_attrs)
    end

    test "update_milk/2 with valid data updates the milk" do
      milk = milk_fixture()

      update_attrs = %{
        day: ~D[2022-03-01],
        milking_time: "some updated milking_time",
        volume: 456.7
      }

      assert {:ok, %Milk{} = milk} = Products.update_milk(milk, update_attrs)
      assert milk.day == ~D[2022-03-01]
      assert milk.milking_time == "some updated milking_time"
      assert milk.volume == 456.7
    end

    test "update_milk/2 with invalid data returns error changeset" do
      milk = milk_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_milk(milk, @invalid_attrs)
      assert milk == Products.get_milk!(milk.id)
    end

    test "delete_milk/1 deletes the milk" do
      milk = milk_fixture()
      assert {:ok, %Milk{}} = Products.delete_milk(milk)
      assert_raise Ecto.NoResultsError, fn -> Products.get_milk!(milk.id) end
    end

    test "change_milk/1 returns a milk changeset" do
      milk = milk_fixture()
      assert %Ecto.Changeset{} = Products.change_milk(milk)
    end
  end
end
