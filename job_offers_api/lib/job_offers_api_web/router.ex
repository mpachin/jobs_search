defmodule JobOffersApiWeb.Router do
  use JobOffersApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JobOffersApiWeb do
    pipe_through :api

    get "/jobs", JobController, :index
  end
end
