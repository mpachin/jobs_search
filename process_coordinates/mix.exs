defmodule ProcessCoordinates.MixProject do
  use Mix.Project

  def project do
    [
      app: :process_coordinates,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ProcessCoordinates.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:jason, "~> 1.2"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:geo_postgis, "~> 3.4"},
      {:table_rex, "~> 3.1.1"},
    ]
  end

  defp aliases do
    [
      group_jobs: ["run -e ProcessCoordinates.ContinentsGrouping.group_jobs_by_continents"],
    ]
  end
end
