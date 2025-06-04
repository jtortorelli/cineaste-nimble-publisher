defmodule Cineaste.Films.Staff do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cineaste.Films.StaffPerson

  embedded_schema do
    field :role, :string

    embeds_many :people, Cineaste.Films.StaffPerson
  end

  def changeset(staff, attrs) do
    staff
    |> cast(attrs, [:role])
    |> validate_required([:role])
    |> cast_embed(:people, with: &StaffPerson.changeset/2)
  end
end
