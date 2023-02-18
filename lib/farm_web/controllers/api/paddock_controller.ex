defmodule FarmWeb.Api.PaddockController do
  use FarmWeb, :controller

  alias Farm.Land
  alias Farm.Land.Paddock

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    paddocks = Land.list_paddocks()
    render(conn, "index.json", paddocks: paddocks)
  end

  def create(conn, %{"paddock" => paddock_params}) do
    with {:ok, %Paddock{} = paddock} <- Land.create_paddock(paddock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_paddock_path(conn, :show, paddock))
      |> render("show.json", paddock: paddock)
    end
  end

  def show(conn, %{"id" => id}) do
    paddock = Land.get_paddock!(id)
    render(conn, "show.json", paddock: paddock)
  end

  def update(conn, %{"id" => id, "paddock" => paddock_params}) do
    paddock = Land.get_paddock!(id)

    with {:ok, %Paddock{} = paddock} <- Land.update_paddock(paddock, paddock_params) do
      render(conn, "show.json", paddock: paddock)
    end
  end

  def delete(conn, %{"id" => id}) do
    paddock = Land.get_paddock!(id)

    with {:ok, %Paddock{}} <- Land.delete_paddock(paddock) do
      send_resp(conn, :no_content, "")
    end
  end
end
