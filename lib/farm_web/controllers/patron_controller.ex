defmodule FarmWeb.PatronController do
  use FarmWeb, :controller

  alias Farm.HR
  alias Farm.HR.Patron
  alias Farm.HR.Role
  import Ecto.Query

  def index(conn, _params) do

    preloads = [:role, :cows]
    patrons = HR.list_patrons(preloads: preloads)
    render(conn, "index.html", patrons: patrons)

  end

  def new(conn, _params) do
    changeset = HR.change_patron(%Patron{})
    role_query = from(r in Role, select: {r.name, r.id})
    all_roles = Farm.Repo.all(role_query)
    render(conn, "new.html", changeset: changeset, all_roles: all_roles)
  end

  def create(conn, %{"patron" => patron_params}) do
    case HR.create_patron(patron_params) do
      {:ok, patron} ->
        conn
        |> put_flash(:info, "Patron created successfully.")
        |> redirect(to: Routes.patron_path(conn, :show, patron))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patron = HR.get_patron!(id)
    render(conn, "show.html", patron: patron)
  end
  # def show(conn, %{"id" => id}) do
  #   patron = HR.get_patron!(id)
  #   role_query = from(r in Role, select: {r.name, r.id})
  #   all_roles = Farm.Repo.all(role_query)
  #   render(conn, "show.html", patron: patron, all_roles: all_roles)
  # end

  # def show_patrons_details(opts \\ []) do
  #   roles =

  #     Patron
  #     |> Repo.all(Patron)
  #     |> Repo.preload(roles)
  #   end

  def edit(conn, %{"id" => id}) do
    patron = HR.get_patron!(id)
    changeset = HR.change_patron(patron)
    render(conn, "edit.html", patron: patron, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patron" => patron_params}) do
    patron = HR.get_patron!(id)

    case HR.update_patron(patron, patron_params) do
      {:ok, patron} ->
        conn
        |> put_flash(:info, "Patron updated successfully.")
        |> redirect(to: Routes.patron_path(conn, :show, patron))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", patron: patron, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patron = HR.get_patron!(id)
    {:ok, _patron} = HR.delete_patron(patron)

    conn
    |> put_flash(:info, "Patron deleted successfully.")
    |> redirect(to: Routes.patron_path(conn, :index))
  end
end
