defmodule ProcessCoordinates.Repo.Migrations.AlterJobsAddLocation do
  use Ecto.Migration
  alias ProcessCoordinates.{Repo, Jobs}

  def change do
    alter table(:jobs) do
      add :location, :geometry
      add :continent_id, references(:continents, on_delete: :nothing)
    end
  end
end
