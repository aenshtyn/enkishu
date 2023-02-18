defmodule FarmWeb.Api.WorkerView do
  use FarmWeb, :view
  alias FarmWeb.Api.WorkerView

  def render("index.json", %{workers: workers}) do
    %{data: render_many(workers, WorkerView, "worker.json")}
  end

  def render("show.json", %{worker: worker}) do
    %{data: render_one(worker, WorkerView, "worker.json")}
  end

  def render("worker.json", %{worker: worker}) do
    %{
      id: worker.id,
      dob: worker.dob,
      name: worker.name,
      phone_number: worker.phone_number,
      report_date: worker.report_date,
      address: worker.address,
      role_id: worker.role_id
    }
  end
end
