defmodule JobOffersApi.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset
  alias JobOffersApi.Continent

  schema "jobs" do
    field :profession_id, :integer
    field :contract_type, :string
    field :name, :string
    field :office_latitude, :float
    field :office_longitude, :float
    field :location, Geo.PostGIS.Geometry
    belongs_to :continent, Continent
  end
end