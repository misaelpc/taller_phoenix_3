defmodule CryptoMonitorWeb.PageController do
  use CryptoMonitorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
