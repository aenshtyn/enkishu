defmodule FarmWeb.WorkerController do
  use FarmWeb, :controller

  alias Farm.HR
  alias Farm.HR.Worker
  alias Farm.HR.Role
  import Ecto.Query

  def index(conn, role) do
    workers = HR.list_workers(role)
    render(conn, "index.html", workers: workers, role: role)
  end

  def new(conn, _params) do
    changeset = HR.change_worker(%Worker{})
    role_query = from(r in Role, select: {r.name, r.id})
    all_roles = Farm.Repo.all(role_query)
    render(conn, "new.html", changeset: changeset, all_roles: all_roles)
  end

  def create(conn, %{"worker" => worker_params}) do
    case HR.create_worker(worker_params) do
      {:ok, worker} ->
        conn
        |> put_flash(:info, "Worker created successfully.")
        |> redirect(to: Routes.worker_path(conn, :show, worker))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    worker = HR.get_worker!(id)
    role_query = from(r in Role, select: {r.name, r.id})
    all_roles = Farm.Repo.all(role_query)
    render(conn, "show.html", worker: worker, all_roles: all_roles)
  end

  def edit(conn, %{"id" => id}) do
    worker = HR.get_worker!(id)
    changeset = HR.change_worker(worker)
    render(conn, "edit.html", worker: worker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "worker" => worker_params}) do
    worker = HR.get_worker!(id)

    case HR.update_worker(worker, worker_params) do
      {:ok, worker} ->
        conn
        |> put_flash(:info, "Worker updated successfully.")
        |> redirect(to: Routes.worker_path(conn, :show, worker))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", worker: worker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    worker = HR.get_worker!(id)
    {:ok, _worker} = HR.delete_worker(worker)

    conn
    |> put_flash(:info, "Worker deleted successfully.")
    |> redirect(to: Routes.worker_path(conn, :index))
  end
end
