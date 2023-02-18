defmodule FarmWeb.MedicationController do
  use FarmWeb, :controller

  alias Farm.Inventory
  alias Farm.Inventory.Medication

  def index(conn, _params) do
    medications = Inventory.list_medications()
    render(conn, "index.html", medications: medications)
  end

  def new(conn, _params) do
    changeset = Inventory.change_medication(%Medication{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"medication" => medication_params}) do
    case Inventory.create_medication(medication_params) do
      {:ok, medication} ->
        conn
        |> put_flash(:info, "Medication created successfully.")
        |> redirect(to: Routes.medication_path(conn, :show, medication))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    medication = Inventory.get_medication!(id)
    render(conn, "show.html", medication: medication)
  end

  def edit(conn, %{"id" => id}) do
    medication = Inventory.get_medication!(id)
    changeset = Inventory.change_medication(medication)
    render(conn, "edit.html", medication: medication, changeset: changeset)
  end

  def update(conn, %{"id" => id, "medication" => medication_params}) do
    medication = Inventory.get_medication!(id)

    case Inventory.update_medication(medication, medication_params) do
      {:ok, medication} ->
        conn
        |> put_flash(:info, "Medication updated successfully.")
        |> redirect(to: Routes.medication_path(conn, :show, medication))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", medication: medication, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    medication = Inventory.get_medication!(id)
    {:ok, _medication} = Inventory.delete_medication(medication)

    conn
    |> put_flash(:info, "Medication deleted successfully.")
    |> redirect(to: Routes.medication_path(conn, :index))
  end
end
