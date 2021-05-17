#!/bin/bash

createdb \
  -U "$PGUSER" \
  -O "$PGUSER" \
  -E UTF8 \
  -T template0 \
  -h "$PGHOST" \
  "$PGDATABASE"

read -r -d '' CREATE_JOBS_TABLE_QUERY <<'EOSQL'
  create table jobs (
    profession_id bigint,
    contract_type character varying(255),
    name character varying(255),
    office_latitude double precision,
    office_longitude double precision
  );
EOSQL

read -r -d '' CREATE_PROFESSIONS_TABLE_QUERY <<'EOSQL'
  create table professions (
    id bigint,
    name character varying(255),
    category_name character varying(255)
  );
EOSQL

psql \
  -U postgres \
  -h "$PGHOST" \
  -d  "$PGDATABASE" \
  -c "$CREATE_JOBS_TABLE_QUERY"

psql \
  -U postgres \
  -h "$PGHOST" \
  -d  "$PGDATABASE" \
  -c "$CREATE_PROFESSIONS_TABLE_QUERY"

psql \
  -U postgres \
  -c "\copy jobs from '/tmp/$JOBS_CSV_FILENAME.csv' delimiter ',' csv header;" \
  -d "$PGDATABASE"

psql \
  -U postgres \
  -c "\copy professions from '/tmp/$PROFESSIONS_CSV_FILENAME.csv' delimiter ',' csv header;" \
  -d "$PGDATABASE"
