# Jobs Search Test Task

* [Task description](./markdown/task.md)

# Usage / Installation

This project uses `Docker` to handle its dependencies and run tasks, make sure you have it installed - it also relies on Linux kernel, so host machine should have Linux/MacOS distribution installed.

* On the first run use `docker-compose up db_setup` and `docker-compose up process_coordinates`, - those commands will prepare database solution apps relies on
* `docker-compose up process_coordinates` will also print a table with the count of job offers per profession category per continent on each run

# Task Solutions

## Preparation step

```
docker-compose up db_setup
```

> ***[How does it work?](./.docker/README.md)***

## [01 / 03 . Exercise: Continents grouping](./markdown/task.md#01-/-03-.-Exercise:-Continents-grouping)

> As said in `Usage` section above - `docker-compose up db_setup` should be run once before using the command below

```
docker-compose up process_coordinates
```

That command will print result table in host console (stdin)

> ***[How does it work?](./process_coordinates/README.md)***

## [02 / 03 . Question: Scaling ?](./markdown/task.md#02-/-03-.-Question:-Scaling?)

[Solution text for scaling question](./markdown/solution_scaling.md)

## [03 / 03 . Exercise: API implementation](./markdown/task.md#03-/-03-.-Exercise:-API-implementation)

> As said in `Usage` section above - `docker-compose up db_setup` and `docker-compose up process_coordinates` should be run once before using the command below

```
docker-compose up api
```

That command will start solution api at host machine on `localhost:80`.

The path to send requests to is `/api/jobs?latitude=46.2276&longitude=2.2137&radius=40`.

As in example above api will accept `latitude`, `longitude` and `radius` query parameters.

> ***[How does it work?](./job_offers_api/README.md)***
