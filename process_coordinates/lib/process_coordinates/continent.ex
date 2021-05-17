defmodule ProcessCoordinates.Continent do
  use Ecto.Schema

  schema "continents" do
    field :name, :string
    field :polygon, Geo.PostGIS.Geometry

    timestamps()
  end
end