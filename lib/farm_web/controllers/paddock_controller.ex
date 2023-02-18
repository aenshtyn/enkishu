defmodule FarmWeb.PaddockController do
  use FarmWeb, :controller

  alias Farm.Land
  alias Farm.Land.Paddock

  def index(conn, _params) do
    paddocks = Land.list_paddocks()
    render(conn, "index.html", paddocks: paddocks)
  end

  def new(conn, _params) do
    changeset = Land.change_paddock(%Paddock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"paddock" => paddock_params}) do
    case Land.create_paddock(paddock_params) do
      {:ok, paddock} ->
        conn
        |> put_flash(:info, "Paddock created successfully.")
        |> redirect(to: Routes.paddock_path(conn, :show, paddock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    paddock = Land.get_paddock!(id)
    render(conn, "show.html", paddock: paddock)
  end

  def edit(conn, %{"id" => id}) do
    paddock = Land.get_paddock!(id)
    changeset = Land.change_paddock(paddock)
    render(conn, "edit.html", paddock: paddock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "paddock" => paddock_params}) do
    paddock = Land.get_paddock!(id)

    case Land.update_paddock(paddock, paddock_params) do
      {:ok, paddock} ->
        conn
        |> put_flash(:info, "Paddock updated successfully.")
        |> redirect(to: Routes.paddock_path(conn, :show, paddock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", paddock: paddock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    paddock = Land.get_paddock!(id)
    {:ok, _paddock} = Land.delete_paddock(paddock)

    conn
    |> put_flash(:info, "Paddock deleted successfully.")
    |> redirect(to: Routes.paddock_path(conn, :index))
  end
end
