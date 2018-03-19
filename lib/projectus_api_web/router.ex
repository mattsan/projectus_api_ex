defmodule ProjectusApiWeb.Router do
  use ProjectusApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ProjectusApiWeb do
    pipe_through :api
  end
end
