defmodule CryptoMonitor.Listener do
  @moduledoc """
  Module for receive updates from monitor
  """
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, [name: name])
  end

  alias CryptoMonitorWeb.Endpoint, as: CryptoSocket

  def handle_call({:update, currency, value}, _from, state) do
    CryptoSocket.broadcast("ex_monitor:rates", currency, %{"body": value})
    {:reply, :ok, state}
  end


end