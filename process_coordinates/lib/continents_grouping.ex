defmodule ProcessCoordinates.ContinentsGrouping do
  import Ecto.Query
  import Geo.PostGIS

  alias ProcessCoordinates.{Professions, Jobs, Repo, Continent}
  alias TableRex.Table

  def group_jobs_by_continents do
    get_continents_jobs()
    |> assemble_continent_jobs_table()
    |> IO.puts()
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

  defp assemble_continent_jobs_table(%{
    categories: categories,
    continents_jobs: continents_jobs
  }) do
    jobs_values = Map.values(continents_jobs)

    categories_total = categories
    |> Enum.map(fn category ->
      jobs_values
      |> Enum.reduce(0, fn continent_jobs_counts, acc ->
        acc + (Keyword.get(continent_jobs_counts, category) || 0)
      end)
    end)

    sorted_categories = Enum.zip(categories, categories_total)
    |> Enum.sort(fn {_, sum1}, {_, sum2} -> sum1 > sum2 end)

    categories_total = Keyword.values(sorted_categories)
    categories = Keyword.keys(sorted_categories)

    rows = [
      ["", "Total" | categories],
      ["Total", Enum.sum(categories_total) | categories_total],
    ] ++ Enum.map(continents_jobs, fn {continent_name, continent_categories} ->
      [continent_name, Keyword.get(continent_categories, :Total)] ++ Enum.map(categories, fn category ->
        Keyword.get(continent_categories, category) || 0
      end)
    end)
    |> Enum.sort(&(Enum.at(&1, 1) > Enum.at(&2, 1)))

    Table.new(rows)
    |> Table.put_column_meta(:all, align: :center)
    |> Table.render!(horizontal_style: :all)
  end
end