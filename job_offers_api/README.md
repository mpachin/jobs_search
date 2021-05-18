## [Back to project README](../README.md)

# JobOffersApi

That app starts Phoenix server with single api endpoint at `/api/jobs?latitude=46.2276&longitude=2.2137&radius=40`.

As in example above this api will accept `latitude`, `longitude` and `radius` query parameters.

## How it works

That app relies on pre-configured PostgreSQL database (which is done by previous steps) which uses [PostGIS](https://postgis.net/) extension. With the help of [geo_postgis](https://github.com/bryanjos/geo_postgis) it provides an api to search for nearest jobs in given radius and calculates distance to that locations.