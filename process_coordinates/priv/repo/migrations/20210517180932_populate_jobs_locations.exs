defmodule ProcessCoordinates.Repo.Migrations.PopulateJobsLocations do
  use Ecto.Migration
  alias ProcessCoordinates.{Repo, Jobs}

  def change do
    for job <- Repo.all(Jobs) do
      if !(is_nil(job.office_latitude) or is_nil(job.office_longitude)) do
        job = Ecto.Changeset.change(job, location: %Geo.Point{
          coordinates: {job.office_latitude, job.office_longitude}
        })
        Repo.update(job)
      end
    end
  end
end
