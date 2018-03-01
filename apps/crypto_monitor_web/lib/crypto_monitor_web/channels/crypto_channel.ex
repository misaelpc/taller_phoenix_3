defmodule CryptoMonitorWeb.CryptoChannel do
  @moduledoc """
  Channel for handling update rates events
  """
  use Phoenix.Channel

  def join("ex_monitor:rates", _message, socket) do
    {:ok, socket}
  end

  def join("ex_monitor:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_out(_, payload, socket) do
    push socket, "", payload
    {:noreply, socket}
  end
end