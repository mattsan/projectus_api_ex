defmodule ProjectusApiWeb.TaskControllerTest do
  use ProjectusApiWeb.ConnCase

  alias ProjectusApi.Missions
  alias ProjectusApi.Missions.Task

  @create_attrs %{description: "some description", title: "some title", status: 0}
  @update_attrs %{description: "some updated description", title: "some updated title", status: 0}
  @invalid_attrs %{description: nil, title: nil, status: nil}

  def fixture(:task) do
    {:ok, task} = Missions.create_task(@create_attrs)
    task
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get conn, task_path(conn, :index)
      assert json_response(conn, 200) == []
    end
  end

  describe "create task" do
    test "renders task when data is valid", %{conn: conn} do
      conn = post conn, task_path(conn, :create), @create_attrs
      assert %{"id" => id} = json_response(conn, 201)

      conn = get conn, task_path(conn, :show, id)
      assert json_response(conn, 200) == %{
        "id" => id,
        "description" => "some description",
        "title" => "some title",
        "status" => "todo"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, task_path(conn, :create), task: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task" do
    setup [:create_task]

    test "renders task when data is valid", %{conn: conn, task: %Task{id: id} = task} do
      conn = put conn, task_path(conn, :update, task), task: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get conn, task_path(conn, :show, id)
      assert json_response(conn, 200) == %{
        "id" => id,
        "description" => "some updated description",
        "title" => "some updated title",
        "status" => "todo"}
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put conn, task_path(conn, :update, task), task: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: task} do
      conn = delete conn, task_path(conn, :delete, task)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, task_path(conn, :show, task)
      end
    end
  end

  defp create_task(_) do
    task = fixture(:task)
    {:ok, task: task}
  end
end
