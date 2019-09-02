defmodule ConferencePlannerWeb.Router do
  use ConferencePlannerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ConferencePlannerWeb do
    pipe_through :api
  end
end
