defmodule Cineaste.Films.Series do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :title, :string
    field :entry_number, :integer
    field :next_entry, :string
    field :next_entry_slug, :string
    field :previous_entry, :string
    field :previous_entry_slug, :string
  end

  def changeset(series, attrs) do
    series
    |> cast(attrs, [
      :title,
      :entry_number,
      :next_entry,
      :next_entry_slug,
      :previous_entry,
      :previous_entry_slug
    ])
    |> validate_required([:title, :entry_number])
    |> validate_number(:entry_number, greater_than: 0)
  end
end
