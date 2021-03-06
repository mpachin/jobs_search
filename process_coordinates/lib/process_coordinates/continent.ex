defmodule ProcessCoordinates.Continent do
  use Ecto.Schema
  alias ProcessCoordinates.Jobs

  schema "continents" do
    field :name, :string
    field :polygon, Geo.PostGIS.Geometry
    has_many :jobs, Jobs

    timestamps()
  end
end