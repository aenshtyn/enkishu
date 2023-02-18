defmodule FarmWeb.SalaryControllerTest do
  use FarmWeb.ConnCase

  import Farm.FinanceFixtures

  @create_attrs %{amount: 120.5, grade: 42}
  @update_attrs %{amount: 456.7, grade: 43}
  @invalid_attrs %{amount: nil, grade: nil}

  describe "index" do
    test "lists all salarys", %{conn: conn} do
      conn = get(conn, Routes.salary_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Salarys"
    end
  end

  describe "new salary" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.salary_path(conn, :new))
      assert html_response(conn, 200) =~ "New Salary"
    end
  end

  describe "create salary" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.salary_path(conn, :create), salary: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.salary_path(conn, :show, id)

      conn = get(conn, Routes.salary_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Salary"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.salary_path(conn, :create), salary: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Salary"
    end
  end

  describe "edit salary" do
    setup [:create_salary]

    test "renders form for editing chosen salary", %{conn: conn, salary: salary} do
      conn = get(conn, Routes.salary_path(conn, :edit, salary))
      assert html_response(conn, 200) =~ "Edit Salary"
    end
  end

  describe "update salary" do
    setup [:create_salary]

    test "redirects when data is valid", %{conn: conn, salary: salary} do
      conn = put(conn, Routes.salary_path(conn, :update, salary), salary: @update_attrs)
      assert redirected_to(conn) == Routes.salary_path(conn, :show, salary)

      conn = get(conn, Routes.salary_path(conn, :show, salary))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, salary: salary} do
      conn = put(conn, Routes.salary_path(conn, :update, salary), salary: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Salary"
    end
  end

  describe "delete salary" do
    setup [:create_salary]

    test "deletes chosen salary", %{conn: conn, salary: salary} do
      conn = delete(conn, Routes.salary_path(conn, :delete, salary))
      assert redirected_to(conn) == Routes.salary_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.salary_path(conn, :show, salary))
      end
    end
  end

  defp create_salary(_) do
    salary = salary_fixture()
    %{salary: salary}
  end
end
