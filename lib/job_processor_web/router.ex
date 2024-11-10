defmodule JobProcessorWeb.Router do
  use JobProcessorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JobProcessorWeb do
    pipe_through :api

    post "/job", JobController, :process
    post "/job_script", JobController, :process_script
  end
end
