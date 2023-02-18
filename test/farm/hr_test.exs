defmodule Farm.HRTest do
  use Farm.DataCase

  alias Farm.HR

  describe "workers" do
    alias Farm.HR.Worker

    import Farm.HRFixtures

    @invalid_attrs %{address: nil, dob: nil, name: nil, phone_number: nil, report_date: nil}

    test "list_workers/0 returns all workers" do
      worker = worker_fixture()
      assert HR.list_workers() == [worker]
    end

    test "get_worker!/1 returns the worker with given id" do
      worker = worker_fixture()
      assert HR.get_worker!(worker.id) == worker
    end

    test "create_worker/1 with valid data creates a worker" do
      valid_attrs = %{
        address: "some address",
        dob: ~N[2022-06-27 08:30:00],
        name: "some name",
        phone_number: 42,
        report_date: ~N[2022-06-27 08:30:00]
      }

      assert {:ok, %Worker{} = worker} = HR.create_worker(valid_attrs)
      assert worker.address == "some address"
      assert worker.dob == ~N[2022-06-27 08:30:00]
      assert worker.name == "some name"
      assert worker.phone_number == 42
      assert worker.report_date == ~N[2022-06-27 08:30:00]
    end

    test "create_worker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_worker(@invalid_attrs)
    end

    test "update_worker/2 with valid data updates the worker" do
      worker = worker_fixture()

      update_attrs = %{
        address: "some updated address",
        dob: ~N[2022-06-28 08:30:00],
        name: "some updated name",
        phone_number: 43,
        report_date: ~N[2022-06-28 08:30:00]
      }

      assert {:ok, %Worker{} = worker} = HR.update_worker(worker, update_attrs)
      assert worker.address == "some updated address"
      assert worker.dob == ~N[2022-06-28 08:30:00]
      assert worker.name == "some updated name"
      assert worker.phone_number == 43
      assert worker.report_date == ~N[2022-06-28 08:30:00]
    end

    test "update_worker/2 with invalid data returns error changeset" do
      worker = worker_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_worker(worker, @invalid_attrs)
      assert worker == HR.get_worker!(worker.id)
    end

    test "delete_worker/1 deletes the worker" do
      worker = worker_fixture()
      assert {:ok, %Worker{}} = HR.delete_worker(worker)
      assert_raise Ecto.NoResultsError, fn -> HR.get_worker!(worker.id) end
    end

    test "change_worker/1 returns a worker changeset" do
      worker = worker_fixture()
      assert %Ecto.Changeset{} = HR.change_worker(worker)
    end
  end

  describe "patrons" do
    alias Farm.HR.Patron

    import Farm.HRFixtures

    @invalid_attrs %{address: nil, name: nil, phone_number: nil}

    test "list_patrons/0 returns all patrons" do
      patron = patron_fixture()
      assert HR.list_patrons() == [patron]
    end

    test "get_patron!/1 returns the patron with given id" do
      patron = patron_fixture()
      assert HR.get_patron!(patron.id) == patron
    end

    test "create_patron/1 with valid data creates a patron" do
      valid_attrs = %{address: "some address", name: "some name", phone_number: 42}

      assert {:ok, %Patron{} = patron} = HR.create_patron(valid_attrs)
      assert patron.address == "some address"
      assert patron.name == "some name"
      assert patron.phone_number == 42
    end

    test "create_patron/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_patron(@invalid_attrs)
    end

    test "update_patron/2 with valid data updates the patron" do
      patron = patron_fixture()

      update_attrs = %{
        address: "some updated address",
        name: "some updated name",
        phone_number: 43
      }

      assert {:ok, %Patron{} = patron} = HR.update_patron(patron, update_attrs)
      assert patron.address == "some updated address"
      assert patron.name == "some updated name"
      assert patron.phone_number == 43
    end

    test "update_patron/2 with invalid data returns error changeset" do
      patron = patron_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_patron(patron, @invalid_attrs)
      assert patron == HR.get_patron!(patron.id)
    end

    test "delete_patron/1 deletes the patron" do
      patron = patron_fixture()
      assert {:ok, %Patron{}} = HR.delete_patron(patron)
      assert_raise Ecto.NoResultsError, fn -> HR.get_patron!(patron.id) end
    end

    test "change_patron/1 returns a patron changeset" do
      patron = patron_fixture()
      assert %Ecto.Changeset{} = HR.change_patron(patron)
    end
  end

  describe "roles" do
    alias Farm.HR.Role

    import Farm.HRFixtures

    @invalid_attrs %{name: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert HR.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert HR.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Role{} = role} = HR.create_role(valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Role{} = role} = HR.update_role(role, update_attrs)
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_role(role, @invalid_attrs)
      assert role == HR.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = HR.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> HR.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = HR.change_role(role)
    end
  end

  describe "duties" do
    alias Farm.HR.Duty

    import Farm.HRFixtures

    @invalid_attrs %{day: nil, description: nil, name: nil}

    test "list_duties/0 returns all duties" do
      duty = duty_fixture()
      assert HR.list_duties() == [duty]
    end

    test "get_duty!/1 returns the duty with given id" do
      duty = duty_fixture()
      assert HR.get_duty!(duty.id) == duty
    end

    test "create_duty/1 with valid data creates a duty" do
      valid_attrs = %{
        day: ~N[2022-06-27 08:35:00],
        description: "some description",
        name: "some name"
      }

      assert {:ok, %Duty{} = duty} = HR.create_duty(valid_attrs)
      assert duty.day == ~N[2022-06-27 08:35:00]
      assert duty.description == "some description"
      assert duty.name == "some name"
    end

    test "create_duty/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_duty(@invalid_attrs)
    end

    test "update_duty/2 with valid data updates the duty" do
      duty = duty_fixture()

      update_attrs = %{
        day: ~N[2022-06-28 08:35:00],
        description: "some updated description",
        name: "some updated name"
      }

      assert {:ok, %Duty{} = duty} = HR.update_duty(duty, update_attrs)
      assert duty.day == ~N[2022-06-28 08:35:00]
      assert duty.description == "some updated description"
      assert duty.name == "some updated name"
    end

    test "update_duty/2 with invalid data returns error changeset" do
      duty = duty_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_duty(duty, @invalid_attrs)
      assert duty == HR.get_duty!(duty.id)
    end

    test "delete_duty/1 deletes the duty" do
      duty = duty_fixture()
      assert {:ok, %Duty{}} = HR.delete_duty(duty)
      assert_raise Ecto.NoResultsError, fn -> HR.get_duty!(duty.id) end
    end

    test "change_duty/1 returns a duty changeset" do
      duty = duty_fixture()
      assert %Ecto.Changeset{} = HR.change_duty(duty)
    end
  end

  describe "workers" do
    alias Farm.HR.Worker

    import Farm.HRFixtures

    @invalid_attrs %{adress: nil, dob: nil, name: nil, phone_number: nil, report_date: nil}

    test "list_workers/0 returns all workers" do
      worker = worker_fixture()
      assert HR.list_workers() == [worker]
    end

    test "get_worker!/1 returns the worker with given id" do
      worker = worker_fixture()
      assert HR.get_worker!(worker.id) == worker
    end

    test "create_worker/1 with valid data creates a worker" do
      valid_attrs = %{
        adress: "some adress",
        dob: ~N[2022-06-27 08:46:00],
        name: "some name",
        phone_number: 42,
        report_date: ~N[2022-06-27 08:46:00]
      }

      assert {:ok, %Worker{} = worker} = HR.create_worker(valid_attrs)
      assert worker.adress == "some adress"
      assert worker.dob == ~N[2022-06-27 08:46:00]
      assert worker.name == "some name"
      assert worker.phone_number == 42
      assert worker.report_date == ~N[2022-06-27 08:46:00]
    end

    test "create_worker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_worker(@invalid_attrs)
    end

    test "update_worker/2 with valid data updates the worker" do
      worker = worker_fixture()

      update_attrs = %{
        adress: "some updated adress",
        dob: ~N[2022-06-28 08:46:00],
        name: "some updated name",
        phone_number: 43,
        report_date: ~N[2022-06-28 08:46:00]
      }

      assert {:ok, %Worker{} = worker} = HR.update_worker(worker, update_attrs)
      assert worker.adress == "some updated adress"
      assert worker.dob == ~N[2022-06-28 08:46:00]
      assert worker.name == "some updated name"
      assert worker.phone_number == 43
      assert worker.report_date == ~N[2022-06-28 08:46:00]
    end

    test "update_worker/2 with invalid data returns error changeset" do
      worker = worker_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_worker(worker, @invalid_attrs)
      assert worker == HR.get_worker!(worker.id)
    end

    test "delete_worker/1 deletes the worker" do
      worker = worker_fixture()
      assert {:ok, %Worker{}} = HR.delete_worker(worker)
      assert_raise Ecto.NoResultsError, fn -> HR.get_worker!(worker.id) end
    end

    test "change_worker/1 returns a worker changeset" do
      worker = worker_fixture()
      assert %Ecto.Changeset{} = HR.change_worker(worker)
    end
  end

  describe "duties" do
    alias Farm.HR.Duty

    import Farm.HRFixtures

    @invalid_attrs %{day: nil, description: nil, name: nil}

    test "list_duties/0 returns all duties" do
      duty = duty_fixture()
      assert HR.list_duties() == [duty]
    end

    test "get_duty!/1 returns the duty with given id" do
      duty = duty_fixture()
      assert HR.get_duty!(duty.id) == duty
    end

    test "create_duty/1 with valid data creates a duty" do
      valid_attrs = %{
        day: ~N[2022-06-27 08:49:00],
        description: "some description",
        name: "some name"
      }

      assert {:ok, %Duty{} = duty} = HR.create_duty(valid_attrs)
      assert duty.day == ~N[2022-06-27 08:49:00]
      assert duty.description == "some description"
      assert duty.name == "some name"
    end

    test "create_duty/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HR.create_duty(@invalid_attrs)
    end

    test "update_duty/2 with valid data updates the duty" do
      duty = duty_fixture()

      update_attrs = %{
        day: ~N[2022-06-28 08:49:00],
        description: "some updated description",
        name: "some updated name"
      }

      assert {:ok, %Duty{} = duty} = HR.update_duty(duty, update_attrs)
      assert duty.day == ~N[2022-06-28 08:49:00]
      assert duty.description == "some updated description"
      assert duty.name == "some updated name"
    end

    test "update_duty/2 with invalid data returns error changeset" do
      duty = duty_fixture()
      assert {:error, %Ecto.Changeset{}} = HR.update_duty(duty, @invalid_attrs)
      assert duty == HR.get_duty!(duty.id)
    end

    test "delete_duty/1 deletes the duty" do
      duty = duty_fixture()
      assert {:ok, %Duty{}} = HR.delete_duty(duty)
      assert_raise Ecto.NoResultsError, fn -> HR.get_duty!(duty.id) end
    end

    test "change_duty/1 returns a duty changeset" do
      duty = duty_fixture()
      assert %Ecto.Changeset{} = HR.change_duty(duty)
    end
  end
end
