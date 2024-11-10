defmodule JobProcessorWeb.JobController do
  use JobProcessorWeb, :controller

  def process(conn, %{"tasks" => tasks}) do
    sorted_task_names = topological_sort(tasks)
    result = task_names_to_tasks(sorted_task_names, tasks)
    json(conn, %{tasks: result})
  end

  defp topological_sort(tasks) do
    graph = :digraph.new()

    Enum.each(tasks, fn task ->
      :digraph.add_vertex(graph, task["name"])
    end)

    Enum.each(tasks, fn task ->
      Enum.each(task["requires"] || [], fn req ->
        :digraph.add_edge(graph, req, task["name"])
      end)
    end)

    sorted = :digraph_utils.topsort(graph)
    :digraph.delete(graph)
    sorted
  end

  defp task_names_to_tasks(task_names, tasks) do
    tasks_map = Enum.into(tasks, %{}, fn task -> {task["name"], task} end)
    Enum.map(task_names, fn task_name ->
      task = tasks_map[task_name]
      %{name: task["name"], command: task["command"]}
    end)
  end
end
