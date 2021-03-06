defmodule ProjectusApiWeb.TaskView do
  use ProjectusApiWeb, :view
  alias ProjectusApiWeb.TaskView
  alias ProjectusApi.Missions.Task

  def render("index.json", %{tasks: tasks}) do
    render_many(tasks, TaskView, "task.json")
  end

  def render("show.json", %{task: task}) do
    render_one(task, TaskView, "task.json")
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.id,
      title: task.title,
      description: task.description,
      status: Task.status_to_string(task).status
    }
  end
end
