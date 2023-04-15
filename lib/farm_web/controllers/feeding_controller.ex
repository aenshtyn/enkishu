defmodule FarmWeb.FeedingController do
  use FarmWeb, :controller

  alias Farm.Production
  alias Farm.Production.Feeding

  def index(conn, _params) do
    feedings = Production.list_feedings()
    render(conn, "index.html", feedings: feedings)
  end

  def new(conn, _params) do
    changeset = Production.change_feeding(%Feeding{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feeding" => feeding_params}) do
    case Production.create_feeding(feeding_params) do
      {:ok, feeding} ->
        conn
        |> put_flash(:info, "Feeding created successfully.")
        |> redirect(to: Routes.feeding_path(conn, :show, feeding))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feeding = Production.get_feeding!(id)
    render(conn, "show.html", feeding: feeding)
  end

  def edit(conn, %{"id" => id}) do
    feeding = Production.get_feeding!(id)
    changeset = Production.change_feeding(feeding)
    render(conn, "edit.html", feeding: feeding, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feeding" => feeding_params}) do
    feeding = Production.get_feeding!(id)

    case Production.update_feeding(feeding, feeding_params) do
      {:ok, feeding} ->
        conn
        |> put_flash(:info, "Feeding updated successfully.")
        |> redirect(to: Routes.feeding_path(conn, :show, feeding))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feeding: feeding, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feeding = Production.get_feeding!(id)
    {:ok, _feeding} = Production.delete_feeding(feeding)

    conn
    |> put_flash(:info, "Feeding deleted successfully.")
    |> redirect(to: Routes.feeding_path(conn, :index))
  end
end
