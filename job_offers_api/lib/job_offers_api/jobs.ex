defmodule JobOffersApi.Jobs do
  import Ecto.Query
  import Geo.PostGIS

  alias JobOffersApi.Repo
  alias JobOffersApi.Continent
  alias JobOffersApi.Jobs.Job

  def find_jobs_in_radius(jobs) do
    search_point = %Geo.Point{
      coordinates: {jobs.latitude, jobs.longitude}
    }

    continent_id = from(
      continent in Continent,
      select: continent.id,
      where: st_within(^search_point, continent.polygon),
    )
    |> Repo.one()

    jobs_near_target_location = from(
      job in Job,
      select: %{
        job_name: job.name,
        contract_type: job.contract_type,
        distance: st_distance(^search_point, job.location),
      },
      where: job.continent_id == ^continent_id
        and st_distance(^search_point, job.location) <= ^jobs.radius,
      order_by: [asc: st_distance(^search_point, job.location)]
    )
    |> Repo.all()
    |> Enum.map(fn job ->
      dist = job.distance
      |> Decimal.from_float()
      |> Decimal.round(2)
      Map.put(job, :distance, "#{dist} (km)")
    end)

    jobs_near_target_location
  end
end