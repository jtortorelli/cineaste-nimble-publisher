defmodule Cineaste.Films do
  def get_film(slug) do
    Cineaste.Library.get_film(slug)
  end

  def list_films do
    Cineaste.Library.list_films()
  end
end
