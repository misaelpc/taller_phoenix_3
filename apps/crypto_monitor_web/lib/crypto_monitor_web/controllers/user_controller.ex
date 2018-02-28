defmodule CryptoMonitorWeb.UserController do
  use CryptoMonitorWeb, :controller

  alias Crypto.User
  def signup(conn, params) do
    changeset = User.signup_changeset(%User{}, params["user"])
    if changeset.valid? do
      user_name = params["user"]["name"]
      pin = params["user"]["pin"]
      User.create(changeset)
      conn
        |> put_session(:user, user_name)
        |> put_session(:token, pin)
        |> redirect(to: "/balance")
    else
      changeset.errors
    end
  end
end
