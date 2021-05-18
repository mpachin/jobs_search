# Noveo Test Task

* [Task description](./markdown/task.md)

# Usage

This project uses `Docker` to handle its dependencies and run tasks, make sure you have it installed - it also relies on Linux kernel, so host machine should have Linux distribution installed.

* On the first run use `docker-compose up db_setup` and `docker-compose up process_coordinates`, - those commands will prepare database solution apps relies on
* `docker-compose up process_coordinates` will also print a table with the count of job offers per profession category per continent on each run