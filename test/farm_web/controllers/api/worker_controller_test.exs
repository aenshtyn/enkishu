defmodule FarmWeb.Api.WorkerControllerTest do
  use FarmWeb.ConnCase

  import Farm.HRFixtures

  alias Farm.HR.Worker

  @create_attrs %{
    adress: "some adress",
    dob: ~N[2022-06-27 08:46:00],
    name: "some name",
    phone_number: 42,
    report_date: ~N[2022-06-27 08:46:00]
  }
  @update_attrs %{
    adress: "some updated adress",
    dob: ~N[2022-06-28 08:46:00],
    name: "some updated name",
    phone_number: 43,
    report_date: ~N[2022-06-28 08:46:00]
  }
  @invalid_attrs %{adress: nil, dob: nil, name: nil, phone_number: nil, report_date: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workers", %{conn: conn} do
      conn = get(conn, Routes.api_worker_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create worker" do
    test "renders worker when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_worker_path(conn, :create), worker: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_worker_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "adress" => "some adress",
               "dob" => "2022-06-27T08:46:00",
               "name" => "some name",
               "phone_number" => 42,
               "report_date" => "2022-06-27T08:46:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_worker_path(conn, :create), worker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update worker" do
    setup [:create_worker]

    test "renders worker when data is valid", %{conn: conn, worker: %Worker{id: id} = worker} do
      conn = put(conn, Routes.api_worker_path(conn, :update, worker), worker: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_worker_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "adress" => "some updated adress",
               "dob" => "2022-06-28T08:46:00",
               "name" => "some updated name",
               "phone_number" => 43,
               "report_date" => "2022-06-28T08:46:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, worker: worker} do
      conn = put(conn, Routes.api_worker_path(conn, :update, worker), worker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete worker" do
    setup [:create_worker]

    test "deletes chosen worker", %{conn: conn, worker: worker} do
      conn = delete(conn, Routes.api_worker_path(conn, :delete, worker))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_worker_path(conn, :show, worker))
      end
    end
  end

  defp create_worker(_) do
    worker = worker_fixture()
    %{worker: worker}
  end
end
