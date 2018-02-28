defmodule CryptoMonitorWeb.Router do
  use CryptoMonitorWeb, :router

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

  scope "/", CryptoMonitorWeb do
    pipe_through :browser # Use the default browser stack
    get "/", CryptoController, :index
    get "/bussines", CryptoController, :bussines
    post "/signup", UserController, :signup
  end

  # Other scopes may use custom stacks.
  # scope "/api", CryptoMonitorWeb do
  #   pipe_through :api
  # end
end
