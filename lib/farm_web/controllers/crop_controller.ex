defmodule FarmWeb.CropController do
  use FarmWeb, :controller

  alias Farm.Production
  alias Farm.Production.Crop
  alias Farm.Land.Paddock
  import Ecto.Query


  def index(conn, _params) do

    preloads = [:paddock, ]
    crops = Production.list_crops(preloads: preloads)
    render(conn, "index.html", crops: crops)
  end

  def new(conn, _params) do
    changeset = Production.change_crop(%Crop{})
    paddock_query = from(p in Paddock, select: {p.number, p.id})
    all_paddocks = Farm.Repo.all(paddock_query)
    render(conn, "new.html", changeset: changeset, all_paddocks: all_paddocks)
  end

  def create(conn, %{"crop" => crop_params}) do
    case Production.create_crop(crop_params) do
      {:ok, crop} ->
        conn
        |> put_flash(:info, "Crop created successfully.")
        |> redirect(to: Routes.crop_path(conn, :show, crop))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crop = Production.get_crop!(id)
    render(conn, "show.html", crop: crop)
  end

  def edit(conn, %{"id" => id}) do
    crop = Production.get_crop!(id)
    changeset = Production.change_crop(crop)
    paddock_query = from(p in Paddock, select: {p.number, p.id})
    all_paddocks = Farm.Repo.all(paddock_query)
    render(conn, "edit.html", crop: crop, changeset: changeset, all_paddocks: all_paddocks)
  end

  def update(conn, %{"id" => id, "crop" => crop_params}) do
    crop = Production.get_crop!(id)

    case Production.update_crop(crop, crop_params) do
      {:ok, crop} ->
        conn
        |> put_flash(:info, "Crop updated successfully.")
        |> redirect(to: Routes.crop_path(conn, :show, crop))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", crop: crop, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    crop = Production.get_crop!(id)
    {:ok, _crop} = Production.delete_crop(crop)

    conn
    |> put_flash(:info, "Crop deleted successfully.")
    |> redirect(to: Routes.crop_path(conn, :index))
  end
end
