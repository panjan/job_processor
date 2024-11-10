defmodule JobProcessorWeb.JobController do
  use JobProcessorWeb, :controller

  def process(conn, %{"tasks" => tasks}) do
    sorted_task_names = topological_sort(tasks)
    result = task_names_to_tasks(sorted_task_names, tasks)
    json(conn, %{tasks: result})
  end

  def process_script(conn, %{"tasks" => tasks}) do
    sorted_task_names = topological_sort(tasks)
    result = task_names_to_script(sorted_task_names, tasks)
    json(conn, %{script: result})
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
      task_value = tasks_map[task_name]
      %{
        "name" => task_value["name"],
        "command" => task_value["command"]
      }
    end)
  end

  defp task_names_to_script(task_names, tasks) do
    tasks_map = Enum.into(tasks, %{}, fn task -> {task["name"], task} end)
    commands = Enum.map(task_names, fn task_name ->
      tasks_map[task_name]["command"]
    end)
    ["#!/usr/bin/env bash" | commands] |> Enum.join("\n")
  end
end
