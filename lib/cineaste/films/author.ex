defmodule Cineaste.Films.Author do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
    field :slug, :string
  end

  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
  end
end
