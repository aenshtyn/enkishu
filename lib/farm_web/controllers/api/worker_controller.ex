defmodule FarmWeb.Api.WorkerController do
  use FarmWeb, :controller

  alias Farm.HR
  alias Farm.HR.Worker

  action_fallback FarmWeb.FallbackController

  def index(conn, role) do
    workers = HR.list_workers(role)
    render(conn, "index.json", workers: workers, role: role)
  end

  def create(conn, %{"worker" => worker_params}) do
    with {:ok, %Worker{} = worker} <- HR.create_worker(worker_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_worker_path(conn, :show, worker))
      |> render("show.json", worker: worker)
    end
  end

  def show(conn, %{"id" => id}) do
    worker = HR.get_worker!(id)
    render(conn, "show.json", worker: worker)
  end

  def update(conn, %{"id" => id, "worker" => worker_params}) do
    worker = HR.get_worker!(id)

    with {:ok, %Worker{} = worker} <- HR.update_worker(worker, worker_params) do
      render(conn, "show.json", worker: worker)
    end
  end

  def delete(conn, %{"id" => id}) do
    worker = HR.get_worker!(id)

    with {:ok, %Worker{}} <- HR.delete_worker(worker) do
      send_resp(conn, :no_content, "")
    end
  end
end
