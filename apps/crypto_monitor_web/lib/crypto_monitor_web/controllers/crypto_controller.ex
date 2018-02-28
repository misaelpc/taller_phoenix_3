defmodule CryptoMonitorWeb.CryptoController do
  use CryptoMonitorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  alias Crypto.User
  def bussines(conn, _params) do
    case get_session(conn, :user) do
      nil ->
        changeset = User.changeset(%User{}, %{})
        render conn, "bussines.html", changeset: changeset
      _ ->
        conn
          |> redirect(to: "/balance")
    end
  end
end