defmodule Cineaste.Films.Film do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cineaste.Films.{Alias, CastPerson, OriginalWork, Series, Staff}

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
    embeds_many :staff, Staff
    embeds_many :top_billed_cast, CastPerson

    embeds_one :series, Series
  end

  def build(filename, attrs, _body) do
    slug = Path.basename(filename, ".yml")
    attrs = Map.put(attrs, "slug", slug)

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
    |> cast_embed(:series, with: &Series.changeset/2)
    |> cast_embed(:staff, with: &Staff.changeset/2)
    |> cast_embed(:top_billed_cast, with: &CastPerson.changeset/2)
    |> apply_action!(:insert)
  end
end
