defmodule ProcessCoordinates.Professions do
  use Ecto.Schema

  schema "professions" do
    field :name, :string
    field :category_name, :string
  end
end