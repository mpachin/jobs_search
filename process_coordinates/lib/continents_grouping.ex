defmodule ProcessCoordinates.ContinentsGrouping do
  import Ecto.Query
  import Geo.PostGIS

  alias ProcessCoordinates.{Professions, Jobs, Repo, Continent}

  def test_query do
    from(
      job in Jobs,
      join: continent in Continent,
      on: st_within(job.location, continent.polygon),
      where: continent.name == "Asia",
      select: %{
        name: job.name,
      },
    )
    |> Repo.all()
  end
end