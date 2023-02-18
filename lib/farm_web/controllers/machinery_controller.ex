defmodule FarmWeb.MachineryController do
  use FarmWeb, :controller

  alias Farm.Inventory
  alias Farm.Inventory.Machinery

  def index(conn, _params) do
    machinerys = Inventory.list_machinerys()
    render(conn, "index.html", machinerys: machinerys)
  end

  def new(conn, _params) do
    changeset = Inventory.change_machinery(%Machinery{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"machinery" => machinery_params}) do
    case Inventory.create_machinery(machinery_params) do
      {:ok, machinery} ->
        conn
        |> put_flash(:info, "Machinery created successfully.")
        |> redirect(to: Routes.machinery_path(conn, :show, machinery))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    machinery = Inventory.get_machinery!(id)
    render(conn, "show.html", machinery: machinery)
  end

  def edit(conn, %{"id" => id}) do
    machinery = Inventory.get_machinery!(id)
    changeset = Inventory.change_machinery(machinery)
    render(conn, "edit.html", machinery: machinery, changeset: changeset)
  end

  def update(conn, %{"id" => id, "machinery" => machinery_params}) do
    machinery = Inventory.get_machinery!(id)

    case Inventory.update_machinery(machinery, machinery_params) do
      {:ok, machinery} ->
        conn
        |> put_flash(:info, "Machinery updated successfully.")
        |> redirect(to: Routes.machinery_path(conn, :show, machinery))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", machinery: machinery, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    machinery = Inventory.get_machinery!(id)
    {:ok, _machinery} = Inventory.delete_machinery(machinery)

    conn
    |> put_flash(:info, "Machinery deleted successfully.")
    |> redirect(to: Routes.machinery_path(conn, :index))
  end
end
