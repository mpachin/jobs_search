defmodule ProcessCoordinates.ContinentsGrouping do
  import Ecto.Query
  import Geo.PostGIS

  alias ProcessCoordinates.{Professions, Jobs, Repo, Continent}

  def group_jobs_by_continents do
    get_continents_jobs()
    |> assemble_continent_jobs_table()
  end

  defp get_continents_jobs do
    continents_jobs_data = from(continent in Continent, select: continent.name)
    |> Repo.all()
    |> Enum.reduce(%{
      categories: [],
      continents_jobs: %{}
    }, fn continent, acc ->
      IO.inspect(continent)
      continent_jobs = from(
        job in Jobs,
        join: continent in Continent, on: st_within(job.location, continent.polygon),
        join: profession in Professions, on: profession.id == job.profession_id,
        group_by: profession.category_name,
        where: continent.name == ^continent,
        select: {profession.category_name, count()},
      )
      |> Repo.all()
      |> Enum.map(fn {key, val} -> {String.to_atom(key), val} end)

      jobs_categories = Keyword.keys(continent_jobs)
      total = Keyword.values(continent_jobs) |> Enum.sum()

      acc = put_in(
        acc,
        Enum.map(
          [:continents_jobs, continent],
          &Access.key(&1, %{})
        ),
        [{:Total, total}|continent_jobs]
      )

      %{acc | categories: acc.categories ++ jobs_categories}
    end)

    %{continents_jobs_data | categories: Enum.uniq(continents_jobs_data.categories)}
  end

  defp assemble_continent_jobs_table(%{categories: categories, continents_jobs: continents_jobs}) do
    {categories, continents_jobs}
  end
end