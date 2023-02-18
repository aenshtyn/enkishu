defmodule FarmWeb.ProcurementsController do
  use FarmWeb, :controller

  alias Farm.Finance
  alias Farm.Finance.Procurement

  def index(conn, _params) do
    procurements = Finance.list_procurements()
    render(conn, "index.html", procurements: procurements)
  end

  def new(conn, _params) do
    changeset = Finance.change_procurements(%Procurement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"procurements" => procurements_params}) do
    case Finance.create_procurements(procurements_params) do
      {:ok, procurements} ->
        conn
        |> put_flash(:info, "Procurements created successfully.")
        |> redirect(to: Routes.procurements_path(conn, :show, procurements))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    procurements = Finance.get_procurements!(id)
    render(conn, "show.html", procurements: procurements)
  end

  def edit(conn, %{"id" => id}) do
    procurements = Finance.get_procurements!(id)
    changeset = Finance.change_procurements(procurements)
    render(conn, "edit.html", procurements: procurements, changeset: changeset)
  end

  def update(conn, %{"id" => id, "procurements" => procurements_params}) do
    procurements = Finance.get_procurements!(id)

    case Finance.update_procurements(procurements, procurements_params) do
      {:ok, procurements} ->
        conn
        |> put_flash(:info, "Procurements updated successfully.")
        |> redirect(to: Routes.procurements_path(conn, :show, procurements))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", procurements: procurements, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    procurements = Finance.get_procurements!(id)
    {:ok, _procurements} = Finance.delete_procurements(procurements)

    conn
    |> put_flash(:info, "Procurements deleted successfully.")
    |> redirect(to: Routes.procurements_path(conn, :index))
  end
end
