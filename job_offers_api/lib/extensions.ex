Postgrex.Types.define(
  JobOffersApi.PostgresTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Jason
)
