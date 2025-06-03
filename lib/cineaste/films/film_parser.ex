defmodule Cineaste.Films.FilmParser do
  def parse(_path, contents) do
    attrs = YamlElixir.read_from_string!(contents)
    {attrs, ""}
  end
end
