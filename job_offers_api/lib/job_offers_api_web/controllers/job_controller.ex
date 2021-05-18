defmodule JobOffersApiWeb.JobController do
  use JobOffersApiWeb, :controller

  alias JobOffersApi.Jobs

  @error_message """
Please check passed parameters. This endpoint works with 'latitude', 'longitude' and 'radius' query parameters; \
those parameters should be numbers: integers or floats\
  """

  @field_error_message """
Please check the value you've send: this field should be a number: integer or float\
  """

  def index(conn, params) do
    jobs_params = %{
      latitude: retrieve_float_param(params, "latitude"),
      longitude: retrieve_float_param(params, "longitude"),
      radius: retrieve_float_param(params, "radius"),
    }

    response = if Enum.any?(Map.values(jobs_params), &is_nil/1) do
      %{
        error: %{
          message: @error_message,
          details: process_error_details(jobs_params)
        }
      }
    else
      Jobs.find_jobs_in_radius(jobs_params)
    end

    render conn, "index.json", json: response
  end

  defp retrieve_float_param(params, param_name) do
    parsed_param = params
    |> Map.get(param_name)
    |> Float.parse()

    case parsed_param do
      :error ->
        nil
      {parsed, _} ->
        parsed
    end
  end

  defp process_error_details(jobs_params) do
    jobs_params
    |> Enum.reduce(%{}, fn {key, val}, acc ->
      if is_nil(val) do
        Map.put(acc, key, @field_error_message)
      else
        acc
      end
    end)
  end
end