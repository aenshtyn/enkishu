defmodule FarmWeb.Api.ArableView do
  use FarmWeb, :view
  alias FarmWeb.Api.ArableView

  def render("index.json", %{arable: arable}) do
    %{data: render_many(arable, ArableView, "arable.json")}
  end

  def render("show.json", %{arable: arable}) do
    %{data: render_one(arable, ArableView, "arable.json")}
  end

  def render("arable.json", %{arable: arable}) do
    %{
      id: arable.id,
      number: arable.number,
      size: arable.size,
      description: arable.description
    }
  end
end
