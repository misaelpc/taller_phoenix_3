defmodule CryptoMonitor.BTC do
  @moduledoc """
  Exchange Rate Worker Monitor for Bit Coin
  """
  use GenServer
  
  def start_link(time) do
    GenServer.start_link(__MODULE__, time, [name: __MODULE__])
  end

  def init(time) do
    refresh(time)
    {:ok, %{time: time, value: 0}} 
  end

  def handle_info(:refresh, state) do
    %{time: time, value: value} = state
    new_value = update_data(value)
    refresh(time)
    {:noreply, %{time: time, value: new_value}}
  end

  defp refresh(time_in_seconds) do
    Process.send_after(self(), :refresh, (time_in_seconds * 1000))
  end

  defp update_data(current_value) do
    response = HTTPotion.get "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,MXN"
     %{"MXN" => mxn, "USD" => usd} = Poison.decode!(response.body)
    CryptoMonitor.Bank.update("btc", usd)
    now = Ecto.DateTime.from_erl(:erlang.localtime)                      
    #Crypto.Metrics.create(%{date: now, value: usd, currency: "btc"})
    GenServer.call(:crypto_listener, {:update, "btc_usd", usd})
    cond do
      usd > current_value ->
        GenServer.call(:crypto_listener, {:update, "btc_img", "/images/up_arrow.png"})
      usd < current_value -> 
        GenServer.call(:crypto_listener, {:update, "btc_img", "/images/down_arrow.png"})
      true ->
        GenServer.call(:crypto_listener, {:update, "btc_img", "/images/even.png"})
    end    
    usd
  end

end