defmodule JobOffersApi.Continent do
  use Ecto.Schema
  alias JobOffersApi.Jobs.Job

  schema "continents" do
    field :name, :string
    field :polygon, Geo.PostGIS.Geometry
    has_many :jobs, Job

    timestamps()
  end
end