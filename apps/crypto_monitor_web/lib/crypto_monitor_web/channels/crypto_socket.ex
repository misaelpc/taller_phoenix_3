defmodule CryptoMonitorWeb.CryptoSocket do
  use Phoenix.Socket

  ## Channels
  channel "ex_monitor:*", CryptoMonitorWeb.CryptoChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end