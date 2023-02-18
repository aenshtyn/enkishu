defmodule FarmWeb.SalaryController do
  use FarmWeb, :controller

  alias Farm.Finance
  alias Farm.Finance.Salary

  def index(conn, _params) do
    salarys = Finance.list_salarys()
    render(conn, "index.html", salarys: salarys)
  end

  def new(conn, _params) do
    changeset = Finance.change_salary(%Salary{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"salary" => salary_params}) do
    case Finance.create_salary(salary_params) do
      {:ok, salary} ->
        conn
        |> put_flash(:info, "Salary created successfully.")
        |> redirect(to: Routes.salary_path(conn, :show, salary))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    salary = Finance.get_salary!(id)
    render(conn, "show.html", salary: salary)
  end

  def edit(conn, %{"id" => id}) do
    salary = Finance.get_salary!(id)
    changeset = Finance.change_salary(salary)
    render(conn, "edit.html", salary: salary, changeset: changeset)
  end

  def update(conn, %{"id" => id, "salary" => salary_params}) do
    salary = Finance.get_salary!(id)

    case Finance.update_salary(salary, salary_params) do
      {:ok, salary} ->
        conn
        |> put_flash(:info, "Salary updated successfully.")
        |> redirect(to: Routes.salary_path(conn, :show, salary))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", salary: salary, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    salary = Finance.get_salary!(id)
    {:ok, _salary} = Finance.delete_salary(salary)

    conn
    |> put_flash(:info, "Salary deleted successfully.")
    |> redirect(to: Routes.salary_path(conn, :index))
  end
end
