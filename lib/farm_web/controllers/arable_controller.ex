defmodule FarmWeb.ArableController do
  use FarmWeb, :controller

  alias Farm.Land
  alias Farm.Land.Arable

  def index(conn, _params) do
    arable = Land.list_arable()
    render(conn, "index.html", arable: arable)
  end

  def new(conn, _params) do
    changeset = Land.change_arable(%Arable{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"arable" => arable_params}) do
    case Land.create_arable(arable_params) do
      {:ok, arable} ->
        conn
        |> put_flash(:info, "Arable created successfully.")
        |> redirect(to: Routes.arable_path(conn, :show, arable))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    arable = Land.get_arable!(id)
    render(conn, "show.html", arable: arable)
  end

  def edit(conn, %{"id" => id}) do
    arable = Land.get_arable!(id)
    changeset = Land.change_arable(arable)
    render(conn, "edit.html", arable: arable, changeset: changeset)
  end

  def update(conn, %{"id" => id, "arable" => arable_params}) do
    arable = Land.get_arable!(id)

    case Land.update_arable(arable, arable_params) do
      {:ok, arable} ->
        conn
        |> put_flash(:info, "Arable updated successfully.")
        |> redirect(to: Routes.arable_path(conn, :show, arable))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", arable: arable, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    arable = Land.get_arable!(id)
    {:ok, _arable} = Land.delete_arable(arable)

    conn
    |> put_flash(:info, "Arable deleted successfully.")
    |> redirect(to: Routes.arable_path(conn, :index))
  end
end
