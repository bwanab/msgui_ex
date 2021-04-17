defmodule MsguiWeb.Router do
  use MsguiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CORSPlug, origin: "http://localhost:8000"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MsguiWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/play/:example", PlayController, :play
    get "/examples_list", PlayController, :list
    get "/stop", PlayController, :stop
    get "/bus_vals/:bus_ids", PlayController, :bus_vals
    # resources "/play", PlayController
    # options "/play", PlayController, :options
  end

  # Other scopes may use custom stacks.
  # scope "/api", MsguiWeb do
  #   pipe_through :api
  # end
end
