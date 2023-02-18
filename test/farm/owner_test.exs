defmodule Farm.OwnerTest do
  use Farm.DataCase

  alias Farm.Owner

  describe "patrons" do
    alias Farm.Owner.Patron

    import Farm.OwnerFixtures

    @invalid_attrs %{name: nil, phone_number: nil}

    test "list_patrons/0 returns all patrons" do
      patron = patron_fixture()
      assert Owner.list_patrons() == [patron]
    end

    test "get_patron!/1 returns the patron with given id" do
      patron = patron_fixture()
      assert Owner.get_patron!(patron.id) == patron
    end

    test "create_patron/1 with valid data creates a patron" do
      valid_attrs = %{name: "some name", phone_number: 42}

      assert {:ok, %Patron{} = patron} = Owner.create_patron(valid_attrs)
      assert patron.name == "some name"
      assert patron.phone_number == 42
    end

    test "create_patron/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Owner.create_patron(@invalid_attrs)
    end

    test "update_patron/2 with valid data updates the patron" do
      patron = patron_fixture()
      update_attrs = %{name: "some updated name", phone_number: 43}

      assert {:ok, %Patron{} = patron} = Owner.update_patron(patron, update_attrs)
      assert patron.name == "some updated name"
      assert patron.phone_number == 43
    end

    test "update_patron/2 with invalid data returns error changeset" do
      patron = patron_fixture()
      assert {:error, %Ecto.Changeset{}} = Owner.update_patron(patron, @invalid_attrs)
      assert patron == Owner.get_patron!(patron.id)
    end

    test "delete_patron/1 deletes the patron" do
      patron = patron_fixture()
      assert {:ok, %Patron{}} = Owner.delete_patron(patron)
      assert_raise Ecto.NoResultsError, fn -> Owner.get_patron!(patron.id) end
    end

    test "change_patron/1 returns a patron changeset" do
      patron = patron_fixture()
      assert %Ecto.Changeset{} = Owner.change_patron(patron)
    end
  end
end
