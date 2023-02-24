defmodule FarmWeb.Api.CowController do
  use FarmWeb, :controller
  
  alias Farm.Repo
  alias Farm.Animals
  alias Farm.Animals.Cow
  import Ecto.Query

  action_fallback FarmWeb.FallbackController

  def index(conn, patron) do
    cows = Animals.list_cows(patron)
    render(conn, "index.json", cows: cows, patron: patron)
  end

  def create(conn, %{"cow" => cow_params}) do
    with {:ok, %Cow{} = cow} <- Animals.create_cow(cow_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_cow_path(conn, :show, cow))
      |> render("show.json", cow: cow)
    end
  end

  def show(conn, %{"id" => id}) do
    cow = Animals.get_cow!(id)
    render(conn, "show.json", cow: cow)
  end

  def update(conn, %{"id" => id, "cow" => cow_params}) do
    cow = Animals.get_cow!(id)

    with {:ok, %Cow{} = cow} <- Animals.update_cow(cow, cow_params) do
      render(conn, "show.json", cow: cow)
    end
  end

  def delete(conn, %{"id" => id}) do
    cow = Animals.get_cow!(id)

    with {:ok, %Cow{}} <- Animals.delete_cow(cow) do
      send_resp(conn, :no_content, "")
    end
  end

  # def total_number(conn, %{"id" => id}) do
  #   cow = Animals.get_cow!(id)
  #   Enum.Count(cow)

  #   render(conn, "show.json", cow: cow)
  # end
end
