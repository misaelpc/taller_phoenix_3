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
  alias Crypto.Currency
  def balance(conn, _params) do
    user = get_session(conn, :user)
    user_info = User.get_info(user)
    changeset = Currency.changeset(%Currency{}, %{})
    render conn, "balance.html", user_info: user_info, changeset: changeset
  end
end