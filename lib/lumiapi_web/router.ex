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

    get "/username/:username/password/:password/profile", UserController, :profile
    get "/username/:username/password/:password/current_term", UserController, :current_term
    get "/username/:username/password/:password/modules", UserController, :modules
    get "/username/:username/password/:password/module", UserController, :modules
    get "/username/:username/password/:password/announcements/:id", UserController, :announcements

    # Fluminus.API.api(auth, "/files/?ParentID=0b4a75e2-1ab2-49a7-a3ed-1e612dd42880")
    # returns all the directories under MA1101R
    get "/username/:username/password/:password/files/parentID/:parentID", UserController, :getDirectoryChildren
    # Fluminus.API.api(auth, "/files/3b2cab93-db24-4d13-9f1b-fcb79700ecad/file")
    # returns all the files under Exam Solutions
    # Since this folder has no sub-folders, calling the ID using the API above would result in an empty response
    get "/username/:username/password/:password/files/directoryID/:directoryID/allowUpload/:allowUpload", UserController, :getFileChildren
    # http://localhost:4000/api/v1/username/[hidden]/password/[hidden]/files/download/id/27c18529-0505-4eb4-94aa-f0a4c4ce8601
    get "/username/:username/password/:password/files/download/id/:id", UserController, :getDownloadUrl

    get "/test/:path", UserController, :test
  end
end
