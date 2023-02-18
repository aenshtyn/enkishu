defmodule FarmWeb.DutyController do
  use FarmWeb, :controller

  alias Farm.HR
  alias Farm.HR.Duty

  def index(conn, _params) do
    duties = HR.list_duties()
    render(conn, "index.html", duties: duties)
  end

  def new(conn, _params) do
    changeset = HR.change_duty(%Duty{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"duty" => duty_params}) do
    case HR.create_duty(duty_params) do
      {:ok, duty} ->
        conn
        |> put_flash(:info, "Duty created successfully.")
        |> redirect(to: Routes.duty_path(conn, :show, duty))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    duty = HR.get_duty!(id)
    render(conn, "show.html", duty: duty)
  end

  def edit(conn, %{"id" => id}) do
    duty = HR.get_duty!(id)
    changeset = HR.change_duty(duty)
    render(conn, "edit.html", duty: duty, changeset: changeset)
  end

  def update(conn, %{"id" => id, "duty" => duty_params}) do
    duty = HR.get_duty!(id)

    case HR.update_duty(duty, duty_params) do
      {:ok, duty} ->
        conn
        |> put_flash(:info, "Duty updated successfully.")
        |> redirect(to: Routes.duty_path(conn, :show, duty))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", duty: duty, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    duty = HR.get_duty!(id)
    {:ok, _duty} = HR.delete_duty(duty)

    conn
    |> put_flash(:info, "Duty deleted successfully.")
    |> redirect(to: Routes.duty_path(conn, :index))
  end
end
