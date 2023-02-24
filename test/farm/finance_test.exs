defmodule Farm.FinanceTest do
  use Farm.DataCase

  alias Farm.Finance

  describe "sales" do
    alias Farm.Finance.Sales

    import Farm.FinanceFixtures

    @invalid_attrs %{customer_name: nil, day: nil, price: nil, quantity: nil, unit: nil}

    test "list_sales/0 returns all sales" do
      sales = sales_fixture()
      assert Finance.list_sales() == [sales]
    end

    test "get_sales!/1 returns the sales with given id" do
      sales = sales_fixture()
      assert Finance.get_sales!(sales.id) == sales
    end

    test "create_sales/1 with valid data creates a sales" do
      valid_attrs = %{
        customer_name: "some customer_name",
        day: ~N[2022-06-28 08:06:00],
        price: 120.5,
        quantity: 120.5,
        unit: "some unit"
      }

      assert {:ok, %Sales{} = sales} = Finance.create_sales(valid_attrs)
      assert sales.customer_name == "some customer_name"
      assert sales.day == ~N[2022-06-28 08:06:00]
      assert sales.price == 120.5
      assert sales.quantity == 120.5
      assert sales.unit == "some unit"
    end

    test "create_sales/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_sales(@invalid_attrs)
    end

    test "update_sales/2 with valid data updates the sales" do
      sales = sales_fixture()

      update_attrs = %{
        customer_name: "some updated customer_name",
        day: ~N[2022-06-29 08:06:00],
        price: 456.7,
        quantity: 456.7,
        unit: "some updated unit"
      }

      assert {:ok, %Sales{} = sales} = Finance.update_sales(sales, update_attrs)
      assert sales.customer_name == "some updated customer_name"
      assert sales.day == ~N[2022-06-29 08:06:00]
      assert sales.price == 456.7
      assert sales.quantity == 456.7
      assert sales.unit == "some updated unit"
    end

    test "update_sales/2 with invalid data returns error changeset" do
      sales = sales_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_sales(sales, @invalid_attrs)
      assert sales == Finance.get_sales!(sales.id)
    end

    test "delete_sales/1 deletes the sales" do
      sales = sales_fixture()
      assert {:ok, %Sales{}} = Finance.delete_sales(sales)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_sales!(sales.id) end
    end

    test "change_sales/1 returns a sales changeset" do
      sales = sales_fixture()
      assert %Ecto.Changeset{} = Finance.change_sales(sales)
    end
  end

  describe "procurements" do
    alias Farm.Finance.Procurement

    import Farm.FinanceFixtures

    @invalid_attrs %{day: nil, quantity: nil, unit: nil, vendor_name: nil}

    test "list_procurements/0 returns all procurements" do
      procurements = procurements_fixture()
      assert Finance.list_procurements() == [procurements]
    end

    test "get_procurements!/1 returns the procurements with given id" do
      procurements = procurements_fixture()
      assert Finance.get_procurements!(procurements.id) == procurements
    end

    test "create_procurements/1 with valid data creates a procurements" do
      valid_attrs = %{
        day: ~N[2022-06-28 08:12:00],
        quantity: 120.5,
        unit: "some unit",
        vendor_name: "some vendor_name"
      }

      assert {:ok, %Procurements{} = procurements} = Finance.create_procurements(valid_attrs)
      assert procurements.day == ~N[2022-06-28 08:12:00]
      assert procurements.quantity == 120.5
      assert procurements.unit == "some unit"
      assert procurements.vendor_name == "some vendor_name"
    end

    test "create_procurements/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_procurements(@invalid_attrs)
    end

    test "update_procurements/2 with valid data updates the procurements" do
      procurements = procurements_fixture()

      update_attrs = %{
        day: ~N[2022-06-29 08:12:00],
        quantity: 456.7,
        unit: "some updated unit",
        vendor_name: "some updated vendor_name"
      }

      assert {:ok, %Procurements{} = procurements} = Finance.update_procurements(procurements, update_attrs)
      assert procurements.day == ~N[2022-06-29 08:12:00]
      assert procurements.quantity == 456.7
      assert procurements.unit == "some updated unit"
      assert procurements.vendor_name == "some updated vendor_name"
    end

    test "update_procurements/2 with invalid data returns error changeset" do
      procurements = procurements_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_procurements(procurements, @invalid_attrs)
      assert procurements == Finance.get_procurements!(procurements.id)
    end

    test "delete_procurements/1 deletes the procurements" do
      procurements = procurements_fixture()
      assert {:ok, %Procurements{}} = Finance.delete_procurements(procurements)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_procurements!(procurements.id) end
    end

    test "change_procurements/1 returns a procurements changeset" do
      procurements = procurements_fixture()
      assert %Ecto.Changeset{} = Finance.change_procurements(procurements)
    end
  end

  describe "salarys" do
    alias Farm.Finance.Salary

    import Farm.FinanceFixtures

    @invalid_attrs %{amount: nil, grade: nil}

    test "list_salarys/0 returns all salarys" do
      salary = salary_fixture()
      assert Finance.list_salarys() == [salary]
    end

    test "get_salary!/1 returns the salary with given id" do
      salary = salary_fixture()
      assert Finance.get_salary!(salary.id) == salary
    end

    test "create_salary/1 with valid data creates a salary" do
      valid_attrs = %{amount: 120.5, grade: 42}

      assert {:ok, %Salary{} = salary} = Finance.create_salary(valid_attrs)
      assert salary.amount == 120.5
      assert salary.grade == 42
    end

    test "create_salary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_salary(@invalid_attrs)
    end

    test "update_salary/2 with valid data updates the salary" do
      salary = salary_fixture()
      update_attrs = %{amount: 456.7, grade: 43}

      assert {:ok, %Salary{} = salary} = Finance.update_salary(salary, update_attrs)
      assert salary.amount == 456.7
      assert salary.grade == 43
    end

    test "update_salary/2 with invalid data returns error changeset" do
      salary = salary_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_salary(salary, @invalid_attrs)
      assert salary == Finance.get_salary!(salary.id)
    end

    test "delete_salary/1 deletes the salary" do
      salary = salary_fixture()
      assert {:ok, %Salary{}} = Finance.delete_salary(salary)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_salary!(salary.id) end
    end

    test "change_salary/1 returns a salary changeset" do
      salary = salary_fixture()
      assert %Ecto.Changeset{} = Finance.change_salary(salary)
    end
  end

  describe "customers" do
    alias Farm.Finance.Customer

    import Farm.FinanceFixtures

    @invalid_attrs %{location: nil, name: nil, phone_number: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Finance.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Finance.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{location: "some location", name: "some name", phone_number: 42}

      assert {:ok, %Customer{} = customer} = Finance.create_customer(valid_attrs)
      assert customer.location == "some location"
      assert customer.name == "some name"
      assert customer.phone_number == 42
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{location: "some updated location", name: "some updated name", phone_number: 43}

      assert {:ok, %Customer{} = customer} = Finance.update_customer(customer, update_attrs)
      assert customer.location == "some updated location"
      assert customer.name == "some updated name"
      assert customer.phone_number == 43
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_customer(customer, @invalid_attrs)
      assert customer == Finance.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Finance.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Finance.change_customer(customer)
    end
  end
end
