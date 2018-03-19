defmodule ProjectusApiWeb.Router do
  use ProjectusApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ProjectusApiWeb do
    pipe_through :api

    resources "/tasks", TaskController, except: [:new, :edit]
  end
end
