# ProcessCoordinates

## Installation

On the first use make sure to install project dependencies with:

```
mix deps.get
```

And then run migrations:

```
mix ecto.migrate
```

## How it works

* This app uses [continent coordinates from this StackOverflow answer](https://stackoverflow.com/questions/13905646/get-the-continent-given-the-latitude-and-longitude) as `continent_polygons.json` file and processes it to be used as [PostgreSQL compatible geometric data (polygons)](https://www.postgresql.org/docs/9.2/functions-geometry.html)
* Creates `continents` table in database and populates it with continent name and correspondent polygon
* To be able to work with spatial data and to do it efficiently this project relies on [PostgreSQL's extension PostGIS](https://postgis.net/) which is designed to work as spatial database extender

## Note on performance

While using `PostGIS` this project relies on geometric data instead of geographic:

> [Postgis - why not to use geography](https://postgis.net/workshops/postgis-intro/geography.html#why-not-use-geography): "Second, the calculations on a sphere are computationally far more expensive than Cartesian calculations. For example, the Cartesian formula for distance (Pythagoras) involves one call to sqrt(). ***The spherical formula for distance (Haversine) involves two sqrt() calls, an arctan() call, four sin() calls and two cos() calls. Trigonometric functions are very costly, and spherical calculations involve a lot of them.***"