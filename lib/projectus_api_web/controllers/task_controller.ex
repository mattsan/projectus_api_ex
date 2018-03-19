defmodule ProjectusApiWeb.TaskController do
  use ProjectusApiWeb, :controller

  alias ProjectusApi.Missions
  alias ProjectusApi.Missions.Task

  action_fallback ProjectusApiWeb.FallbackController

  def index(conn, _params) do
    tasks = Missions.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, task_params) do
    with {:ok, %Task{} = task} <- Missions.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Missions.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Missions.get_task!(id)

    with {:ok, %Task{} = task} <- Missions.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Missions.get_task!(id)
    with {:ok, %Task{}} <- Missions.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
