defmodule FarmWeb.CowController do
  use FarmWeb, :controller

  alias Farm.Animals
  alias Farm.Animals.Cow
  alias Farm.HR.Patron
  import Ecto.Query

  def index(conn, _params) do

    preloads = [:patron, ]
    cows = Animals.list_cows(preloads: preloads)
    render(conn, "index.html", cows: cows)

  end

  def new(conn, _params) do
    changeset = Animals.change_cow(%Cow{})
    patron_query = from(p in Patron, select: {p.name, p.id})
    all_patrons = Farm.Repo.all(patron_query)
    render(conn, "new.html", changeset: changeset, all_patrons: all_patrons)
  end

  def create(conn, %{"cow" => cow_params}) do
    case Animals.create_cow(cow_params) do
      {:ok, cow} ->
        conn
        |> put_flash(:info, "Cow created successfully.")
        |> redirect(to: Routes.cow_path(conn, :show, cow))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cow = Animals.get_cow!(id)
    render(conn, "show.html", cow: cow)
  end

  def edit(conn, %{"id" => id}) do
    cow = Animals.get_cow!(id)
    changeset = Animals.change_cow(cow)
    render(conn, "edit.html", cow: cow, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cow" => cow_params}) do
    cow = Animals.get_cow!(id)

    case Animals.update_cow(cow, cow_params) do
      {:ok, cow} ->
        conn
        |> put_flash(:info, "Cow updated successfully.")
        |> redirect(to: Routes.cow_path(conn, :show, cow))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cow: cow, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cow = Animals.get_cow!(id)
    {:ok, _cow} = Animals.delete_cow(cow)

    conn
    |> put_flash(:info, "Cow deleted successfully.")
    |> redirect(to: Routes.cow_path(conn, :index))
  end
end
