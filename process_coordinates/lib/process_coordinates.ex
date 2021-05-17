defmodule ProcessCoordinates do
  alias Jason
  @moduledoc """
  Documentation for `ProcessCoordinates`.
  """

  @doc """
  Processes continents json lat/lon separate fields into correspondent {lat, lon} pairs

  ## Examples

      iex> ProcessCoordinates.process()

  """

  def process do
    read_continents_json()
    |> lat_lon_into_polygons()
  end

  defp read_continents_json do
    {:ok, json} = File.read("continents_polygons.json")
    Jason.decode!(json)
  end

  defp lat_lon_into_polygons(continents_map) do
    continents_map
    |> Enum.map(fn ({name, polygons}) ->
      polygons = polygons
        |> Enum.map(fn %{"lat" => lat_str, "lon" => lon_str} ->
          coordinates = Enum.map([lat_str, lon_str], fn str ->
            String.split(str, ~r{\s+})
            |> Enum.map(fn str ->
              {res, _} = Float.parse(str)
              res
            end)
          end)

          List.zip(coordinates)
          |> connect_extreme_points()
        end)

      {String.to_atom(name), polygons}
    end)
  end

  defp connect_extreme_points(list) do
    first_point = List.first(list)
    list ++ [first_point]
  end
end
