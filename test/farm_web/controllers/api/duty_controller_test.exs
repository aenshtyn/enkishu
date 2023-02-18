defmodule FarmWeb.Api.DutyControllerTest do
  use FarmWeb.ConnCase

  import Farm.HRFixtures

  alias Farm.HR.Duty

  @create_attrs %{
    day: ~N[2022-06-27 08:49:00],
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    day: ~N[2022-06-28 08:49:00],
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{day: nil, description: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all duties", %{conn: conn} do
      conn = get(conn, Routes.api_duty_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create duty" do
    test "renders duty when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_duty_path(conn, :create), duty: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_duty_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "2022-06-27T08:49:00",
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_duty_path(conn, :create), duty: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update duty" do
    setup [:create_duty]

    test "renders duty when data is valid", %{conn: conn, duty: %Duty{id: id} = duty} do
      conn = put(conn, Routes.api_duty_path(conn, :update, duty), duty: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_duty_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "day" => "2022-06-28T08:49:00",
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, duty: duty} do
      conn = put(conn, Routes.api_duty_path(conn, :update, duty), duty: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete duty" do
    setup [:create_duty]

    test "deletes chosen duty", %{conn: conn, duty: duty} do
      conn = delete(conn, Routes.api_duty_path(conn, :delete, duty))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_duty_path(conn, :show, duty))
      end
    end
  end

  defp create_duty(_) do
    duty = duty_fixture()
    %{duty: duty}
  end
end
