defmodule ProcessCoordinates.Jobs do
  use Ecto.Schema
  import Ecto.Changeset
  alias ProcessCoordinates.Continent

  schema "jobs" do
    field :profession_id, :integer
    field :contract_type, :string
    field :name, :string
    field :office_latitude, :float
    field :office_longitude, :float
    field :location, Geo.PostGIS.Geometry
    belongs_to :continent, Continent
  end

  def changeset(job, attrs) do
    job
    |> cast(attrs, [:profession_id, :contract_type, :name, :office_latitude, :office_longitude, :location])
  end
end