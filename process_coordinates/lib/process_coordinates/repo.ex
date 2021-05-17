defmodule ProcessCoordinates.Repo do
  use Ecto.Repo,
    otp_app: :process_coordinates,
    adapter: Ecto.Adapters.Postgres
end
