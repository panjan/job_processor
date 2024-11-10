defmodule JobProcessorWeb.JobController do
  use JobProcessorWeb, :controller

  def process(conn, %{"tasks" => tasks}) do
    results = Enum.map(tasks, fn task ->
      task
    end)

    json(conn, %{results: results})
  end
end
