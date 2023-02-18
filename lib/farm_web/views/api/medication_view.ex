defmodule FarmWeb.Api.MedicationView do
  use FarmWeb, :view
  alias FarmWeb.Api.MedicationView

  def render("index.json", %{medications: medications}) do
    %{data: render_many(medications, MedicationView, "medication.json")}
  end

  def render("show.json", %{medication: medication}) do
    %{data: render_one(medication, MedicationView, "medication.json")}
  end

  def render("medication.json", %{medication: medication}) do
    %{
      id: medication.id,
      brand: medication.brand,
      type: medication.type,
      patient: medication.patient
    }
  end
end
