defmodule FarmWeb.Api.MedicationController do
  use FarmWeb, :controller

  alias Farm.Inventory
  alias Farm.Inventory.Medication

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    medications = Inventory.list_medications()
    render(conn, "index.json", medications: medications)
  end

  def create(conn, %{"medication" => medication_params}) do
    with {:ok, %Medication{} = medication} <- Inventory.create_medication(medication_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_medication_path(conn, :show, medication))
      |> render("show.json", medication: medication)
    end
  end

  def show(conn, %{"id" => id}) do
    medication = Inventory.get_medication!(id)
    render(conn, "show.json", medication: medication)
  end

  def update(conn, %{"id" => id, "medication" => medication_params}) do
    medication = Inventory.get_medication!(id)

    with {:ok, %Medication{} = medication} <-
           Inventory.update_medication(medication, medication_params) do
      render(conn, "show.json", medication: medication)
    end
  end

  def delete(conn, %{"id" => id}) do
    medication = Inventory.get_medication!(id)

    with {:ok, %Medication{}} <- Inventory.delete_medication(medication) do
      send_resp(conn, :no_content, "")
    end
  end
end
