defmodule FarmWeb.Api.SalaryView do
  use FarmWeb, :view
  alias FarmWeb.Api.SalaryView

  def render("index.json", %{salarys: salarys}) do
    %{data: render_many(salarys, SalaryView, "salary.json")}
  end

  def render("show.json", %{salary: salary}) do
    %{data: render_one(salary, SalaryView, "salary.json")}
  end

  def render("salary.json", %{salary: salary}) do
    %{
      id: salary.id,
      grade: salary.grade,
      amount: salary.amount
    }
  end
end
