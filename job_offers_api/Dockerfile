FROM elixir:1.12.0-rc.1-slim

# Install postgres
RUN apt-get update \
  && apt-get install -y postgresql

RUN mix local.hex --force

RUN mkdir -p /app

WORKDIR /app

ENTRYPOINT ["bash", "entrypoint.sh"]
