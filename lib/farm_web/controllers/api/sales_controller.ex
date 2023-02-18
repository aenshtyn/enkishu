defmodule FarmWeb.Api.SalesController do
  use FarmWeb, :controller

  alias Farm.Finance
  alias Farm.Finance.Sales

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    sales = Finance.list_sales()
    render(conn, "index.json", sales: sales)
  end

  def create(conn, %{"sales" => sales_params}) do
    with {:ok, %Sales{} = sales} <- Finance.create_sales(sales_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_sales_path(conn, :show, sales))
      |> render("show.json", sales: sales)
    end
  end

  def show(conn, %{"id" => id}) do
    sales = Finance.get_sales!(id)
    render(conn, "show.json", sales: sales)
  end

  def update(conn, %{"id" => id, "sales" => sales_params}) do
    sales = Finance.get_sales!(id)

    with {:ok, %Sales{} = sales} <- Finance.update_sales(sales, sales_params) do
      render(conn, "show.json", sales: sales)
    end
  end

  def delete(conn, %{"id" => id}) do
    sales = Finance.get_sales!(id)

    with {:ok, %Sales{}} <- Finance.delete_sales(sales) do
      send_resp(conn, :no_content, "")
    end
  end
end
