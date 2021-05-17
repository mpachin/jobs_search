defmodule ProcessCoordinates.Repo.Migrations.PopulateContinentsPolygons do
  use Ecto.Migration

  alias ProcessCoordinates
  alias ProcessCoordinates.{Repo, Continent}

  def change do
    continents_polygons = ProcessCoordinates.process()
    for continent_name <- Keyword.keys(continents_polygons) do
      polygon_coordinates = Keyword.get(continents_polygons, continent_name)
      polygon = %Geo.Polygon{coordinates: polygon_coordinates}
      Repo.insert!(%Continent{name: Atom.to_string(continent_name), polygon: polygon})
    end
  end
end
