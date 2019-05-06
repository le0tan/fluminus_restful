defmodule LumiapiWeb.Router do
  use LumiapiWeb, :router

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

  # scope "/", LumiapiWeb do
  #   pipe_through :browser

  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api/v1", LumiapiWeb do
    pipe_through :api

    get "/username/:username/password/:password/path/:path", UserController, :index
  end
end
