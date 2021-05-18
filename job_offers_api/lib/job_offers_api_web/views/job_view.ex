defmodule JobOffersApiWeb.JobView do
  use JobOffersApiWeb, :view

  def render("index.json", %{json: json}) do
    json
  end
end
