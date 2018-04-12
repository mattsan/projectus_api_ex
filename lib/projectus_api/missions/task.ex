defmodule ProjectusApi.Missions.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(status_to_number(attrs), [:title, :description, :status])
    |> validate_required([:title, :description])
    |> validate_number(:status, greater_than_or_equal_to: 0, less_than_or_equal_to: 2)
  end

  def status_to_string(%{status: status} = task)
    when is_integer(status) or is_nil(status),
    do: %{task | status: conviert_status_to_string(status)}

  def status_to_string(%{"status" => status} = task)
    when is_integer(status) or is_nil(status),
    do: %{task | "status" => conviert_status_to_string(status)}

  def status_to_string(%{} = task), do: task

  def status_to_number(%{status: status} = task)
    when is_binary(status) or is_nil(status),
    do: %{task | status: conviert_status_to_number(status)}

  def status_to_number(%{"status" => status} = task)
    when is_binary(status) or is_nil(status),
    do: %{task | "status" => conviert_status_to_number(status)}

  def status_to_number(%{} = task), do: task

  defp conviert_status_to_string(status) do
    case status do
      nil -> "todo"
      0 -> "todo"
      1 -> "doing"
      2 -> "done"
      _ -> status
    end
  end

  defp conviert_status_to_number(status) do
    case status do
      nil -> 0
      "todo" -> 0
      "doing" -> 1
      "done" -> 2
      _ -> status
    end
  end
end
