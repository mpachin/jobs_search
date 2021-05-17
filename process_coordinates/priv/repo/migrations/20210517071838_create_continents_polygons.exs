defmodule ProcessCoordinates.Repo.Migrations.CreateContinentsPolygons do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"

    create table(:continents) do
      add :name, :string, null: false
      add :polygon, :geometry
      timestamps()
    end
    create unique_index(:continents, [:name])
  end
end
