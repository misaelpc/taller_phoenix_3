defmodule CryptoMonitor.Bank do
  @moduledoc """
  Bank for crypto currencies
  """
  use Agent

  def start_link do
    Agent.start_link(fn -> %{"eth" => 0,
                             "eth_qty" => 100_000,
                             "btc_qty" => 100_000,
                             "btc" => 0} end, name: __MODULE__)
  end

  @doc """
  Updates a value for currency
  """
  def update(key, value) do
    Agent.update(__MODULE__, &Map.put(&1, key, value))
    #Agent.update(__MODULE__, fn map -> Map.put(map, key, value) end)
  end
end