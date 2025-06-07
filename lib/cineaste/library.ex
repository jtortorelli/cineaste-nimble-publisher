defmodule Cineaste.Library do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_film(slug) do
    :ets.lookup(:films, slug)
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
