defmodule FarmWeb.Api.SalesView do
  use FarmWeb, :view
  alias FarmWeb.Api.SalesView

  def render("index.json", %{sales: sales}) do
    %{data: render_many(sales, SalesView, "sales.json")}
  end

  def render("show.json", %{sales: sales}) do
    %{data: render_one(sales, SalesView, "sales.json")}
  end

  def render("sales.json", %{sales: sales}) do
    %{
      id: sales.id,
      day: sales.day,
      customer_name: sales.customer_name,
      unit: sales.unit,
      quantity: sales.quantity,
      price: sales.price
    }
  end
end
