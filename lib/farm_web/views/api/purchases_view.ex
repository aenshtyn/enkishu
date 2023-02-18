defmodule FarmWeb.Api.ProcurementsView do
  use FarmWeb, :view
  alias FarmWeb.Api.ProcurementsView

  def render("index.json", %{procurements: procurements}) do
    %{data: render_many(procurements, ProcurementsView, "procurements.json")}
  end

  def render("show.json", %{procurements: procurements}) do
    %{data: render_one(procurements, ProcurementsView, "procurements.json")}
  end

  def render("procurements.json", %{procurements: procurements}) do
    %{
      id: procurements.id,
      day: procurements.day,
      vendor_name: procurements.vendor_name,
      unit: procurements.unit,
      quantity: procurements.quantity
    }
  end
end
