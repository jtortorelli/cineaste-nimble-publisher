defmodule Cineaste.Films.Alias do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :alias, :string
    field :context, :string
  end

  def changeset(alias, attrs) do
    alias
    |> cast(attrs, [:alias, :context])
  end
end
