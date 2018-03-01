defmodule Crypto.Currency do
  @moduledoc """
  Place holder for currency
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(quantity)

  schema "currency" do
    field :name
    field :quantity
  end

  def changeset(currency, params \\ :empty) do
    currency
      |> cast(params, [:quantity, :name])
  end
end