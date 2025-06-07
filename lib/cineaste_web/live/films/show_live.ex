defmodule CineasteWeb.Films.ShowLive do
  use CineasteWeb, :live_view

  alias Cineaste.Films

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, film: nil)}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _uri, socket) do
    {:ok, film} = Films.get_film(slug)
    {:noreply, assign(socket, film: film)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>{@film["title"]}</h1>
    <p>Release Date: {@film["release_date"]}</p>
    <p>Runtime: {@film["runtime"]} minutes</p>
    <p>Japanese Title: {@film["japanese_title"]}</p>
    <p>Transliteration: {@film["transliteration"]}</p>
    <p>Translation: {@film["translation"]}</p>
    <%= for work <- @film["original_works"] do %>
      <div>
        <h2>Original Work</h2>
        <p>Title: {work["title"]}</p>
        <p>Format: {work["format"]}</p>
        <h3>Authors</h3>
        <ul>
          <%= for author <- work["authors"] do %>
            <li>{author["name"]}</li>
          <% end %>
        </ul>
      </div>
    <% end %>
    <h2>Aliases</h2>
    <ul>
      <%= for alias <- @film["aliases"] do %>
        <li>{alias["alias"]} ({alias["context"]})</li>
      <% end %>
    </ul>
    <h2>Studios</h2>
    <ul>
      <%= for studio <- @film["studios"] do %>
        <li>{studio}</li>
      <% end %>
    </ul>
    <h2>Series</h2>
    <%= if @film["series"] do %>
      <div>
        <p>Title: {@film["series"]["title"]}</p>
        <p>Entry Number: {@film["series"]["entry_number"]}</p>
        <p>Next Entry: {@film["series"]["next_entry"]}</p>
        <p>Previous Entry: {@film["series"]["previous_entry"]}</p>
      </div>
    <% end %>
    <h2>Staff</h2>
    <ul>
      <%= for staff <- @film["staff"] do %>
        <li>
          {staff["role"]} - {staff["people"] |> Enum.map(& &1["name"]) |> Enum.join(", ")}
        </li>
      <% end %>
    </ul>
    <h2>Top Billed Cast</h2>
    <ul>
      <%= for person <- @film["top_billed_cast"] do %>
        <li>{person["name"]} as {person["role"]}</li>
      <% end %>
    </ul>
    <h2>Supporting Cast</h2>
    <ul>
      <%= for person <- @film["supporting_cast"] do %>
        <li>{person["name"]} as {person["role"]}</li>
      <% end %>
    </ul>
    <h2>Kaiju</h2>
    <ul>
      <%= for kaiju <- @film["kaiju"] do %>
        <li>{kaiju["name"]}</li>
      <% end %>
    </ul>
    """
  end
end
