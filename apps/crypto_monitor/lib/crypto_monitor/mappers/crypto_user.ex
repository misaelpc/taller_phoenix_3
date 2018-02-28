defmodule Crypto.User do
  @moduledoc """
  User for crypto currencies
  """
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias CryptoMonitor.Repo
  alias Crypto.User

  @required_fields ~w(name pin)
  @optional_fields ~w(confirm_pin)

  schema "users" do
    field :name
    field :pin
    field :usd, :decimal
    field :eth, :decimal
    field :btc, :decimal
    field :confirm_pin, :string, virtual: true
  end

  def changeset(user, params \\ :empty) do
    user
      |> cast(params, [:pin, :name, :confirm_pin, :usd, :btc, :eth])
  end
  @doc """
  Sign up changeset.

  ## Examples

      iex> Crypto.User.signup_changeset(%Crypto.User{}, %{name: "Misael", pin: "1234", confirm_pin: "1234"})
      #Ecto.Changeset<action: nil, changes: %{confirm_pin: \"1234\", name: \"Misael\", pin: \"1234\"}, errors: [], data: #Crypto.User<>, valid?: true>

  """
  def signup_changeset(user, params) do
    user
      |> cast(params, @required_fields)
      |> cast(params, @optional_fields)
      |> validate_unique_user
      #|> validate_pin_match
  end
  
  def validate_unique_user(changeset) do
    user_name = get_field(changeset, :name)
    case User.get_info(user_name) do
      nil ->
        changeset
      _ ->
        add_error(changeset, :found, "#{user_name} has been already taken")
    end
  end

  def validate_pin_match(changeset) do
    if changeset.valid? do
      pin = get_field(changeset, :pin)
      confirm_pin = get_field(changeset, :confirm_pin)
      case pin == confirm_pin do
        true ->
          changeset
        false ->
          add_error(changeset, :wrong_pin, "Pins does not match")
      end
    else
      changeset
    end
  end

  def get_info(user) do
    query = from u in User,
          where: u.name == ^user,
          select: u
    Repo.one(query)
  end
end
