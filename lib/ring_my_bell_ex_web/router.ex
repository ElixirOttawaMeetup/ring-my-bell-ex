defmodule RingMyBellExWeb.Router do
  use RingMyBellExWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RingMyBellExWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/doors/:id", DoorsController, :show
    get "/bells/new", BellsController, :new
    get "/bells/:id", BellsController, :show
    post "/bells", BellsController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", RingMyBellExWeb do
  #   pipe_through :api
  # end
end
