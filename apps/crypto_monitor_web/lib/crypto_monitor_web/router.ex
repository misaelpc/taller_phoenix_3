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

  pipeline :auth do
    plug :authenticate
  end

  scope "/", CryptoMonitorWeb do
    pipe_through :browser # Use the default browser stack
    get "/", CryptoController, :index
    get "/bussines", CryptoController, :bussines
    post "/signup", UserController, :signup
    get "/charts", CryptoController, :charts
  end

  scope "/", CryptoMonitorWeb do
    pipe_through :browser # Use the default browser stack
    pipe_through :auth # Use the autenticated stack
    get "/balance", CryptoController, :balance
  end
  
  alias Crypto.Authentication
  defp authenticate(conn, _params) do
    if Authentication.authenticated?(conn) do
      conn
    else
      conn
      |> redirect(to: "/bussines")
      |> halt
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CryptoMonitorWeb do
  #   pipe_through :api
  # end
end
