defmodule FarmWeb.Api.DutyController do
  use FarmWeb, :controller

  alias Farm.HR
  alias Farm.HR.Duty

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    duties = HR.list_duties()
    render(conn, "index.json", duties: duties)
  end

  def create(conn, %{"duty" => duty_params}) do
    with {:ok, %Duty{} = duty} <- HR.create_duty(duty_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_duty_path(conn, :show, duty))
      |> render("show.json", duty: duty)
    end
  end

  def show(conn, %{"id" => id}) do
    duty = HR.get_duty!(id)
    render(conn, "show.json", duty: duty)
  end

  def update(conn, %{"id" => id, "duty" => duty_params}) do
    duty = HR.get_duty!(id)

    with {:ok, %Duty{} = duty} <- HR.update_duty(duty, duty_params) do
      render(conn, "show.json", duty: duty)
    end
  end

  def delete(conn, %{"id" => id}) do
    duty = HR.get_duty!(id)

    with {:ok, %Duty{}} <- HR.delete_duty(duty) do
      send_resp(conn, :no_content, "")
    end
  end
end
