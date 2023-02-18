defmodule FarmWeb.MilkController do
  use FarmWeb, :controller

  alias Farm.Products
  alias Farm.Products.Milk
  alias Farm.Animals.Cow
  import Ecto.Query

  def index(conn, cow) do
    milks = Products.list_milks(cow)
    render(conn, "index.html", milks: milks, cow: cow)
  end

  def new(conn, _params) do
    changeset = Products.change_milk(%Milk{})
    cow_query = from(c in Cow, select: {c.name, c.id})
    all_cows = Farm.Repo.all(cow_query)
    render(conn, "new.html", changeset: changeset, all_cows: all_cows)
  end

  def create(conn, %{"milk" => milk_params}) do
    case Products.create_milk(milk_params) do
      {:ok, milk} ->
        conn
        |> put_flash(:info, "Milk created successfully.")
        |> redirect(to: Routes.milk_path(conn, :show, milk))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    milk = Products.get_milk!(id)
    cow_query = from(c in Cow, select: {c.name, c.id})
    all_cows = Farm.Repo.all(cow_query)
    render(conn, "show.html", milk: milk, all_cows: all_cows)
  end

  def show_by_date(conn, %{"day" => day}) do
    milk = Products.get_milk!(day)
    cow_query = from(c in Cow, select: {c.name, c.id})
    all_cows = Farm.Repo.all(cow_query)
    render(conn, "show.html", milk: milk, all_cows: all_cows)
  end

  def edit(conn, %{"id" => id}) do
    milk = Products.get_milk!(id)
    changeset = Products.change_milk(milk)
    render(conn, "edit.html", milk: milk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "milk" => milk_params}) do
    milk = Products.get_milk!(id)

    case Products.update_milk(milk, milk_params) do
      {:ok, milk} ->
        conn
        |> put_flash(:info, "Milk updated successfully.")
        |> redirect(to: Routes.milk_path(conn, :show, milk))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", milk: milk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    milk = Products.get_milk!(id)
    {:ok, _milk} = Products.delete_milk(milk)

    conn
    |> put_flash(:info, "Milk deleted successfully.")
    |> redirect(to: Routes.milk_path(conn, :index))
  end
end
