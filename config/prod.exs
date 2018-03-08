use Mix.Config

# Do not print debug messages in production
config :logger, level: :info

config :mnesia, :dir, [__DIR__, "..", "priv", "data"]
  |> Path.join()
  |> Path.expand()
  |> to_charlist()