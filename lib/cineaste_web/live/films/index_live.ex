defmodule CineasteWeb.Films.IndexLive do
  use CineasteWeb, :live_view

  alias Cineaste.Films

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, films: Films.all_films())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>Films</h1>
    <ul>
      <%= for film <- @films do %>
        <li>
          <a href={~p"/films/#{film.slug}"}>{film.title}</a>
        </li>
      <% end %>
    </ul>
    """
  end
end
