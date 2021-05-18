defmodule ProcessCoordinates.Repo.Migrations.PopulateJobsLocations do
  use Ecto.Migration
  import Ecto.Query
  import Geo.PostGIS

  alias ProcessCoordinates.{Repo, Jobs, Continent}

  def change do
    for job <- Repo.all(Jobs) do
      if !(is_nil(job.office_latitude) or is_nil(job.office_longitude)) do
        point = %Geo.Point{
          coordinates: {job.office_latitude, job.office_longitude}
        }

        continent_id = from(
          continent in Continent,
          select: continent.id,
          where: st_within(^point, continent.polygon),
        )
        |> Repo.one()

        job = Ecto.Changeset.change(job,
          location: point,
          continent_id: continent_id
        )
        |> Repo.update()
      end
    end
  end
end
