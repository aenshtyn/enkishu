defmodule FarmWeb.Api.ProcurementsController do
  use FarmWeb, :controller

  alias Farm.Finance
  alias Farm.Finance.Procurement

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    procurements = Finance.list_procurements()
    render(conn, "index.json", procurements: procurements)
  end

  def create(conn, %{"procurements" => procurements_params}) do
    with {:ok, %Procurement{} = procurements} <- Finance.create_procurements(procurements_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_procurements_path(conn, :show, procurements))
      |> render("show.json", procurements: procurements)
    end
  end

  def show(conn, %{"id" => id}) do
    procurements = Finance.get_procurements!(id)
    render(conn, "show.json", procurements: procurements)
  end

  def update(conn, %{"id" => id, "procurements" => procurements_params}) do
    procurements = Finance.get_procurements!(id)

    with {:ok, %Procurement{} = procurements} <- Finance.update_procurements(procurements, procurements_params) do
      render(conn, "show.json", procurements: procurements)
    end
  end

  def delete(conn, %{"id" => id}) do
    procurements = Finance.get_procurements!(id)

    with {:ok, %Procurement{}} <- Finance.delete_procurements(procurements) do
      send_resp(conn, :no_content, "")
    end
  end
end
