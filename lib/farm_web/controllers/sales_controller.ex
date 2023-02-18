defmodule FarmWeb.SalesController do
  use FarmWeb, :controller

  alias Farm.Finance
  alias Farm.Finance.Sales

  def index(conn, _params) do
    sales = Finance.list_sales()
    render(conn, "index.html", sales: sales)
  end

  def new(conn, _params) do
    changeset = Finance.change_sales(%Sales{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sales" => sales_params}) do
    case Finance.create_sales(sales_params) do
      {:ok, sales} ->
        conn
        |> put_flash(:info, "Sales created successfully.")
        |> redirect(to: Routes.sales_path(conn, :show, sales))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sales = Finance.get_sales!(id)
    render(conn, "show.html", sales: sales)
  end

  def edit(conn, %{"id" => id}) do
    sales = Finance.get_sales!(id)
    changeset = Finance.change_sales(sales)
    render(conn, "edit.html", sales: sales, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sales" => sales_params}) do
    sales = Finance.get_sales!(id)

    case Finance.update_sales(sales, sales_params) do
      {:ok, sales} ->
        conn
        |> put_flash(:info, "Sales updated successfully.")
        |> redirect(to: Routes.sales_path(conn, :show, sales))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sales: sales, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sales = Finance.get_sales!(id)
    {:ok, _sales} = Finance.delete_sales(sales)

    conn
    |> put_flash(:info, "Sales deleted successfully.")
    |> redirect(to: Routes.sales_path(conn, :index))
  end
end
