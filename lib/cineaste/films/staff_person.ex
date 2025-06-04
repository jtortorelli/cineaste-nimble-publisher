defmodule Cineaste.Films.StaffPerson do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
    field :slug, :string
    field :alias, :string
  end

  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :slug, :alias])
    |> validate_required([:name])
  end
end
