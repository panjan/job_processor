defmodule JobProcessorWeb.JobController do
  use JobProcessorWeb, :controller

  def process(conn, %{"tasks" => tasks}) do
    tasks_map = Enum.into(tasks, %{}, fn task -> {task["name"], task} end)
    sorted_task_names = topological_sort(tasks_map)
    result = hydrate_tasks(sorted_task_names, tasks_map)
    json(conn, %{tasks: result})
  end

  defp topological_sort(tasks_map) do
    graph = :digraph.new()

    Enum.each(tasks_map, fn {task_name, _task} ->
      :digraph.add_vertex(graph, task_name)
    end)

    Enum.each(tasks_map, fn {task_name, task} ->
      Enum.each(task["requires"] || [], fn req ->
        :digraph.add_edge(graph, req, task_name)
      end)
    end)

    sorted = :digraph_utils.topsort(graph)
    :digraph.delete(graph)
    sorted
  end

  defp hydrate_tasks(sorted_task_names, tasks_map) do
    Enum.map(sorted_task_names, fn task_name ->
      task = tasks_map[task_name]
      %{name: task["name"], command: task["command"]}
    end)
  end
end
