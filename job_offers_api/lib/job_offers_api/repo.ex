defmodule JobOffersApi.Repo do
  use Ecto.Repo,
    otp_app: :job_offers_api,
    adapter: Ecto.Adapters.Postgres
end
