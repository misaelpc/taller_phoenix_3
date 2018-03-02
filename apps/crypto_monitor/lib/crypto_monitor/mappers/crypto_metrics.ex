defmodule Crypto.Metrics do
  use Ecto.Schema

  schema "metrics" do
    field :date, Ecto.DateTime
    field :value, :decimal
    field :currency, :string
  end
  
end