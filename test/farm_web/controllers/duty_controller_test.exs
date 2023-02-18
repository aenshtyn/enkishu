defmodule FarmWeb.DutyControllerTest do
  use FarmWeb.ConnCase

  import Farm.HRFixtures

  @create_attrs %{
    day: ~N[2022-06-27 08:35:00],
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    day: ~N[2022-06-28 08:35:00],
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{day: nil, description: nil, name: nil}

  describe "index" do
    test "lists all duties", %{conn: conn} do
      conn = get(conn, Routes.duty_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Duties"
    end
  end

  describe "new duty" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.duty_path(conn, :new))
      assert html_response(conn, 200) =~ "New Duty"
    end
  end

  describe "create duty" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.duty_path(conn, :create), duty: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.duty_path(conn, :show, id)

      conn = get(conn, Routes.duty_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Duty"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.duty_path(conn, :create), duty: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Duty"
    end
  end

  describe "edit duty" do
    setup [:create_duty]

    test "renders form for editing chosen duty", %{conn: conn, duty: duty} do
      conn = get(conn, Routes.duty_path(conn, :edit, duty))
      assert html_response(conn, 200) =~ "Edit Duty"
    end
  end

  describe "update duty" do
    setup [:create_duty]

    test "redirects when data is valid", %{conn: conn, duty: duty} do
      conn = put(conn, Routes.duty_path(conn, :update, duty), duty: @update_attrs)
      assert redirected_to(conn) == Routes.duty_path(conn, :show, duty)

      conn = get(conn, Routes.duty_path(conn, :show, duty))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, duty: duty} do
      conn = put(conn, Routes.duty_path(conn, :update, duty), duty: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Duty"
    end
  end

  describe "delete duty" do
    setup [:create_duty]

    test "deletes chosen duty", %{conn: conn, duty: duty} do
      conn = delete(conn, Routes.duty_path(conn, :delete, duty))
      assert redirected_to(conn) == Routes.duty_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.duty_path(conn, :show, duty))
      end
    end
  end

  defp create_duty(_) do
    duty = duty_fixture()
    %{duty: duty}
  end
end
