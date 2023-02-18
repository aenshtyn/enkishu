defmodule FarmWeb.Api.MachineryController do
  use FarmWeb, :controller

  alias Farm.Inventory
  alias Farm.Inventory.Machinery

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    machinerys = Inventory.list_machinerys()
    render(conn, "index.json", machinerys: machinerys)
  end

  def create(conn, %{"machinery" => machinery_params}) do
    with {:ok, %Machinery{} = machinery} <- Inventory.create_machinery(machinery_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_machinery_path(conn, :show, machinery))
      |> render("show.json", machinery: machinery)
    end
  end

  def show(conn, %{"id" => id}) do
    machinery = Inventory.get_machinery!(id)
    render(conn, "show.json", machinery: machinery)
  end

  def update(conn, %{"id" => id, "machinery" => machinery_params}) do
    machinery = Inventory.get_machinery!(id)

    with {:ok, %Machinery{} = machinery} <-
           Inventory.update_machinery(machinery, machinery_params) do
      render(conn, "show.json", machinery: machinery)
    end
  end

  def delete(conn, %{"id" => id}) do
    machinery = Inventory.get_machinery!(id)

    with {:ok, %Machinery{}} <- Inventory.delete_machinery(machinery) do
      send_resp(conn, :no_content, "")
    end
  end
end
