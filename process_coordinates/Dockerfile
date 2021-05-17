FROM elixir:1.12.0-rc.1-slim

ARG PROFESSIONS_CSV_ID
ARG JOBS_CSV_ID

# Install postgres
RUN apt-get update \
  && apt-get install -y \
    postgresql \
    postgis*

RUN mix local.hex --force

RUN mkdir -p /app

WORKDIR /app