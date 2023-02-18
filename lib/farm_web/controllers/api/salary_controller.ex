defmodule FarmWeb.Api.SalaryController do
  use FarmWeb, :controller

  alias Farm.Finance
  alias Farm.Finance.Salary

  action_fallback FarmWeb.FallbackController

  def index(conn, _params) do
    salarys = Finance.list_salarys()
    render(conn, "index.json", salarys: salarys)
  end

  def create(conn, %{"salary" => salary_params}) do
    with {:ok, %Salary{} = salary} <- Finance.create_salary(salary_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_salary_path(conn, :show, salary))
      |> render("show.json", salary: salary)
    end
  end

  def show(conn, %{"id" => id}) do
    salary = Finance.get_salary!(id)
    render(conn, "show.json", salary: salary)
  end

  def update(conn, %{"id" => id, "salary" => salary_params}) do
    salary = Finance.get_salary!(id)

    with {:ok, %Salary{} = salary} <- Finance.update_salary(salary, salary_params) do
      render(conn, "show.json", salary: salary)
    end
  end

  def delete(conn, %{"id" => id}) do
    salary = Finance.get_salary!(id)

    with {:ok, %Salary{}} <- Finance.delete_salary(salary) do
      send_resp(conn, :no_content, "")
    end
  end
end
