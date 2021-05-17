use Mix.Config

config :process_coordinates,
  ecto_repos: [ProcessCoordinates.Repo]

config :process_coordinates, ProcessCoordinates.Repo,
  username: System.get_env("PGUSER"),
  password: System.get_env("PGPASSWORD"),
  database: System.get_env("PGDATABASE"),
  hostname: "postgres",
  adapter: Ecto.Adapters.Postgres,
  types: ProcessCoordinates.PostgresTypes
