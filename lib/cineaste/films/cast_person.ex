defmodule Cineaste.Films.CastPerson do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :role, :string
    field :name, :string
    field :slug, :string
  end

  def changeset(cast_person, attrs) do
    cast_person
    |> cast(attrs, [:role, :name, :slug])
  end
end
