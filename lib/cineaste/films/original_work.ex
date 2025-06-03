defmodule Cineaste.Films.OriginalWork do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cineaste.Films.Author

  embedded_schema do
    field :title, :string
    field :format, Ecto.Enum, values: [:serial]

    embeds_many :authors, Author
  end

  def changeset(original_work, attrs) do
    original_work
    |> cast(attrs, [:title, :format])
    |> cast_embed(:authors, with: &Author.changeset/2)
  end
end
