defmodule JobProcessorWeb.JobController do
  use JobProcessorWeb, :controller

  def process(conn, _params) do
    json(conn, %{message: "Hello, World!"})
  end
end
