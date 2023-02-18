defmodule FarmWeb.Api.ArableController do
  use FarmWeb, :controller

  alias Farm.Land
  alias Farm.Land.Arable

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    arable = Land.list_arable()
    render(conn, "index.json", arable: arable)
  end

  def create(conn, %{"arable" => arable_params}) do
    with {:ok, %Arable{} = arable} <- Land.create_arable(arable_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_arable_path(conn, :show, arable))
      |> render("show.json", arable: arable)
    end
  end

  def show(conn, %{"id" => id}) do
    arable = Land.get_arable!(id)
    render(conn, "show.json", arable: arable)
  end

  def update(conn, %{"id" => id, "arable" => arable_params}) do
    arable = Land.get_arable!(id)

    with {:ok, %Arable{} = arable} <- Land.update_arable(arable, arable_params) do
      render(conn, "show.json", arable: arable)
    end
  end

  def delete(conn, %{"id" => id}) do
    arable = Land.get_arable!(id)

    with {:ok, %Arable{}} <- Land.delete_arable(arable) do
      send_resp(conn, :no_content, "")
    end
  end
end
