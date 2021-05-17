defmodule ProcessCoordinates.Repo.Migrations.AlterJobsAddLocation do
  use Ecto.Migration
  alias ProcessCoordinates.{Repo, Jobs}

  def change do
    alter table(:jobs) do
      add :location, :geometry
    end
  end
end
