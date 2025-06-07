defmodule Cineaste.Library do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_film(slug) do
    case :ets.lookup(:films, slug) do
      [{_, film}] -> {:ok, film}
      [] -> {:error, :not_found}
    end
  end

  def list_films() do
    :films
    |> :ets.tab2list()
    |> Enum.sort_by(fn {slug, _} -> slug end)
    |> Enum.map(fn {slug, film} -> Map.put(film, "slug", slug) end)
  end

  def init(_) do
    initialize_film_cache()
    {:ok, []}
  end

  defp initialize_film_cache do
    :ets.new(:films, [:set, :protected, :named_table])

    "./films/**/*.yml"
    |> Path.wildcard()
    |> Enum.sort()
    |> Enum.map(fn path ->
      :ets.insert(:films, {Path.basename(path, ".yml"), YamlElixir.read_from_file!(path)})
    end)
  end
end
