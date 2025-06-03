defmodule Cineaste.Films.Film do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cineaste.Films.{Alias, OriginalWork}

  embedded_schema do
    field :title, :string
    field :slug, :string
    field :release_date, :date
    field :runtime, :integer

    field :japanese_title, :string, default: nil
    field :transliteration, :string, default: nil
    field :translation, :string, default: nil

    field :studios, {:array, :string}, default: []

    embeds_many :original_works, OriginalWork
    embeds_many :aliases, Alias
  end

  def build(_filename, attrs, _body) do
    %__MODULE__{}
    |> cast(attrs, [
      :title,
      :slug,
      :release_date,
      :runtime,
      :japanese_title,
      :transliteration,
      :translation,
      :studios
    ])
    |> cast_embed(:original_works, with: &OriginalWork.changeset/2)
    |> cast_embed(:aliases, with: &Alias.changeset/2)
    |> apply_action!(:insert)
  end
end
