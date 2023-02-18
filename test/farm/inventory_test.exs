defmodule Farm.InventoryTest do
  use Farm.DataCase

  alias Farm.Inventory

  describe "machinerys" do
    alias Farm.Inventory.Machinery

    import Farm.InventoryFixtures

    @invalid_attrs %{area_of_use: nil, brand: nil, hp: nil, name: nil, price: nil}

    test "list_machinerys/0 returns all machinerys" do
      machinery = machinery_fixture()
      assert Inventory.list_machinerys() == [machinery]
    end

    test "get_machinery!/1 returns the machinery with given id" do
      machinery = machinery_fixture()
      assert Inventory.get_machinery!(machinery.id) == machinery
    end

    test "create_machinery/1 with valid data creates a machinery" do
      valid_attrs = %{
        area_of_use: "some area_of_use",
        brand: "some brand",
        hp: 120.5,
        name: "some name",
        price: 120.5
      }

      assert {:ok, %Machinery{} = machinery} = Inventory.create_machinery(valid_attrs)
      assert machinery.area_of_use == "some area_of_use"
      assert machinery.brand == "some brand"
      assert machinery.hp == 120.5
      assert machinery.name == "some name"
      assert machinery.price == 120.5
    end

    test "create_machinery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_machinery(@invalid_attrs)
    end

    test "update_machinery/2 with valid data updates the machinery" do
      machinery = machinery_fixture()

      update_attrs = %{
        area_of_use: "some updated area_of_use",
        brand: "some updated brand",
        hp: 456.7,
        name: "some updated name",
        price: 456.7
      }

      assert {:ok, %Machinery{} = machinery} = Inventory.update_machinery(machinery, update_attrs)
      assert machinery.area_of_use == "some updated area_of_use"
      assert machinery.brand == "some updated brand"
      assert machinery.hp == 456.7
      assert machinery.name == "some updated name"
      assert machinery.price == 456.7
    end

    test "update_machinery/2 with invalid data returns error changeset" do
      machinery = machinery_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_machinery(machinery, @invalid_attrs)
      assert machinery == Inventory.get_machinery!(machinery.id)
    end

    test "delete_machinery/1 deletes the machinery" do
      machinery = machinery_fixture()
      assert {:ok, %Machinery{}} = Inventory.delete_machinery(machinery)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_machinery!(machinery.id) end
    end

    test "change_machinery/1 returns a machinery changeset" do
      machinery = machinery_fixture()
      assert %Ecto.Changeset{} = Inventory.change_machinery(machinery)
    end
  end

  describe "medications" do
    alias Farm.Inventory.Medication

    import Farm.InventoryFixtures

    @invalid_attrs %{brand: nil, patient: nil, type: nil}

    test "list_medications/0 returns all medications" do
      medication = medication_fixture()
      assert Inventory.list_medications() == [medication]
    end

    test "get_medication!/1 returns the medication with given id" do
      medication = medication_fixture()
      assert Inventory.get_medication!(medication.id) == medication
    end

    test "create_medication/1 with valid data creates a medication" do
      valid_attrs = %{brand: "some brand", patient: "some patient", type: "some type"}

      assert {:ok, %Medication{} = medication} = Inventory.create_medication(valid_attrs)
      assert medication.brand == "some brand"
      assert medication.patient == "some patient"
      assert medication.type == "some type"
    end

    test "create_medication/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_medication(@invalid_attrs)
    end

    test "update_medication/2 with valid data updates the medication" do
      medication = medication_fixture()

      update_attrs = %{
        brand: "some updated brand",
        patient: "some updated patient",
        type: "some updated type"
      }

      assert {:ok, %Medication{} = medication} =
               Inventory.update_medication(medication, update_attrs)

      assert medication.brand == "some updated brand"
      assert medication.patient == "some updated patient"
      assert medication.type == "some updated type"
    end

    test "update_medication/2 with invalid data returns error changeset" do
      medication = medication_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_medication(medication, @invalid_attrs)
      assert medication == Inventory.get_medication!(medication.id)
    end

    test "delete_medication/1 deletes the medication" do
      medication = medication_fixture()
      assert {:ok, %Medication{}} = Inventory.delete_medication(medication)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_medication!(medication.id) end
    end

    test "change_medication/1 returns a medication changeset" do
      medication = medication_fixture()
      assert %Ecto.Changeset{} = Inventory.change_medication(medication)
    end
  end

  describe "products" do
    alias Farm.Inventory.Product

    import Farm.InventoryFixtures

    @invalid_attrs %{name: nil, quantity: nil, unit: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Inventory.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Inventory.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", quantity: 120.5, unit: "some unit"}

      assert {:ok, %Product{} = product} = Inventory.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.quantity == 120.5
      assert product.unit == "some unit"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name", quantity: 456.7, unit: "some updated unit"}

      assert {:ok, %Product{} = product} = Inventory.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.quantity == 456.7
      assert product.unit == "some updated unit"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_product(product, @invalid_attrs)
      assert product == Inventory.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Inventory.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Inventory.change_product(product)
    end
  end
end
