defmodule FarmWeb.SheepController do
  use FarmWeb, :controller

  alias Farm.Animals
  alias Farm.Animals.Sheep

  def index(conn, _params) do
    sheeps = Animals.list_sheeps()
    render(conn, "index.html", sheeps: sheeps)
  end

  def new(conn, _params) do
    changeset = Animals.change_sheep(%Sheep{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sheep" => sheep_params}) do
    case Animals.create_sheep(sheep_params) do
      {:ok, sheep} ->
        conn
        |> put_flash(:info, "Sheep created successfully.")
        |> redirect(to: Routes.sheep_path(conn, :show, sheep))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sheep = Animals.get_sheep!(id)
    render(conn, "show.html", sheep: sheep)
  end

  def edit(conn, %{"id" => id}) do
    sheep = Animals.get_sheep!(id)
    changeset = Animals.change_sheep(sheep)
    render(conn, "edit.html", sheep: sheep, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sheep" => sheep_params}) do
    sheep = Animals.get_sheep!(id)

    case Animals.update_sheep(sheep, sheep_params) do
      {:ok, sheep} ->
        conn
        |> put_flash(:info, "Sheep updated successfully.")
        |> redirect(to: Routes.sheep_path(conn, :show, sheep))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sheep: sheep, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sheep = Animals.get_sheep!(id)
    {:ok, _sheep} = Animals.delete_sheep(sheep)

    conn
    |> put_flash(:info, "Sheep deleted successfully.")
    |> redirect(to: Routes.sheep_path(conn, :index))
  end
end
