defmodule FarmWeb.Api.MilkController do
  use FarmWeb, :controller

  alias Farm.Repo
  alias Farm.Products
  alias Farm.Products.Milk

  action_fallback FarmWeb.FallbackController

  def index(conn, cow) do
    milks = Products.list_milks(cow)
    # Repo.preload(Farm.Animals.Cow, :patron)
    render(conn, "index.json", milks: milks, cow: cow)
  end

  def create(conn, %{"milk" => milk_params}) do
    with {:ok, %Milk{} = milk} <- Products.create_milk(milk_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_milk_path(conn, :show, milk))
      |> render("show.json", milk: milk)
    end
  end

  def show(conn, %{"cow_id" => cow_id}) do
    milk = Products.get_milk!(cow_id)
    render(conn, "show.json", milk: milk)
  end

  def production_by_date(conn, %{"day" => day}) do
    milk = Products.get_milk!(day)
    render(conn, "show.json", milk: milk)
  end

  # def production_by_animal_name(conn, %{"name" => name}) do
  #   milk = Products.get_milk!(name)
  #   render(conn, "show.json", milk: milk)
  # end

  # def production_by_milking_time(conn, %{"milking_time" => milking_time}) do
  #   milk = Products.get_milk!(milking_time)
  #   render(conn, "show.json", milk: milk)
  # end

  def update(conn, %{"id" => id, "milk" => milk_params}) do
    milk = Products.get_milk!(id)

    with {:ok, %Milk{} = milk} <- Products.update_milk(milk, milk_params) do
      render(conn, "show.json", milk: milk)
    end
  end

  def delete(conn, %{"id" => id}) do
    milk = Products.get_milk!(id)

    with {:ok, %Milk{}} <- Products.delete_milk(milk) do
      send_resp(conn, :no_content, "")
    end
  end
end
