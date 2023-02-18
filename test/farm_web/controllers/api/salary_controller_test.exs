defmodule FarmWeb.Api.SalaryControllerTest do
  use FarmWeb.ConnCase

  import Farm.FinanceFixtures

  alias Farm.Finance.Salary

  @create_attrs %{
    amount: 120.5,
    grade: 42
  }
  @update_attrs %{
    amount: 456.7,
    grade: 43
  }
  @invalid_attrs %{amount: nil, grade: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all salarys", %{conn: conn} do
      conn = get(conn, Routes.api_salary_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create salary" do
    test "renders salary when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_salary_path(conn, :create), salary: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_salary_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => 120.5,
               "grade" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_salary_path(conn, :create), salary: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update salary" do
    setup [:create_salary]

    test "renders salary when data is valid", %{conn: conn, salary: %Salary{id: id} = salary} do
      conn = put(conn, Routes.api_salary_path(conn, :update, salary), salary: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_salary_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => 456.7,
               "grade" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, salary: salary} do
      conn = put(conn, Routes.api_salary_path(conn, :update, salary), salary: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete salary" do
    setup [:create_salary]

    test "deletes chosen salary", %{conn: conn, salary: salary} do
      conn = delete(conn, Routes.api_salary_path(conn, :delete, salary))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_salary_path(conn, :show, salary))
      end
    end
  end

  defp create_salary(_) do
    salary = salary_fixture()
    %{salary: salary}
  end
end
