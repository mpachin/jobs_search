#!/bin/bash

mix deps.get

mix ecto.migrate

mix group_jobs