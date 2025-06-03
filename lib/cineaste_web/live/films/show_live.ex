defmodule CineasteWeb.Films.ShowLive do
  use CineasteWeb, :live_view

  alias Cineaste.Films

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, film: nil)}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _uri, socket) do
    film = Films.get_film!(slug)
    {:noreply, assign(socket, film: film)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>{@film.title}</h1>
    <p>Release Date: {@film.release_date}</p>
    <p>Runtime: {@film.runtime} minutes</p>
    <%= for work <- @film.original_works do %>
      <div>
        <h2>Original Work</h2>
        <p>Title: {work.title}</p>
        <p>Format: {work.format}</p>
        <h3>Authors</h3>
        <ul>
          <%= for author <- work.authors do %>
            <li>{author.name}</li>
          <% end %>
        </ul>
      </div>
    <% end %>
    <h2>Aliases</h2>
    <ul>
      <%= for alias <- @film.aliases do %>
        <li>{alias.alias} ({alias.context})</li>
      <% end %>
    </ul>
    <h2>Studios</h2>
    <ul>
      <%= for studio <- @film.studios do %>
        <li>{studio}</li>
      <% end %>
    </ul>
    """
  end
end
