defmodule CryptoMonitor.UserTest do
  @moduledoc """
    Test File for user data layer
  """
  use CryptoMonitor.DataCase

  doctest Crypto.User
  
  setup do
    user = %Crypto.User{name: "Mauricio", pin: "1234"}
    CryptoMonitor.Repo.insert!(user)
    {:ok, user: user}
  end

  test "Test user name", %{user: user} do
    assert user.name == "Mauricio"
  end
  

end