defmodule FarmWeb.Api.PatronController do
  use FarmWeb, :controller

  alias Farm.HR
  alias Farm.HR.Patron

  action_fallback FarmWeb.FallbackController

  def index(conn, role) do
    patrons = HR.list_patrons(role)
    render(conn, "index.json", patrons: patrons, role: role)
  end

  def create(conn, %{"patron" => patron_params}) do
    with {:ok, %Patron{} = patron} <- HR.create_patron(patron_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_patron_path(conn, :show, patron))
      |> render("show.json", patron: patron)
    end
  end

  def show(conn, %{"id" => id}) do
    patron = HR.get_patron!(id)
    render(conn, "show.json", patron: patron)
  end

  def update(conn, %{"id" => id, "patron" => patron_params}) do
    patron = HR.get_patron!(id)

    with {:ok, %Patron{} = patron} <- HR.update_patron(patron, patron_params) do
      render(conn, "show.json", patron: patron)
    end
  end

  def delete(conn, %{"id" => id}) do
    patron = HR.get_patron!(id)

    with {:ok, %Patron{}} <- HR.delete_patron(patron) do
      send_resp(conn, :no_content, "")
    end
  end
end
