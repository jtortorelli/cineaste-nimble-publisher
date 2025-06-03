defmodule Cineaste.Films do
  alias Cineaste.Films.{Film, FilmParser}

  use NimblePublisher,
    build: Film,
    from: "./films/**/*.yml",
    as: :films,
    parser: FilmParser

  def all_films, do: @films

  def get_film!(slug) do
    Enum.find(@films, &(&1.slug == slug)) ||
      raise "Film with slug '#{slug}' not found"
  end
end
