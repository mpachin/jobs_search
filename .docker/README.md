## [Back to project README](../README.md)

That subproject is an image container designed to be used by `docker-compose` which job is to prepare PostgreSQL database (in `postgres` docker volume). All other solutions relies on it to be run once.

## How it works

First it sets up and uses [gdown](https://github.com/wkentaro/gdown) utility to download actual `.csv` files from google drive [which was given as exercise solutions dependency](../markdown/task.md). That way we can automatically download fresh files if they would ever be changed.

Then it connects to `postgres` docker where PostgreSQL instance is started up common for all containers in this project. After that it uses downloaded `.csv` files to populate related tables.