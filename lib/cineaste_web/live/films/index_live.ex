defmodule CineasteWeb.Films.IndexLive do
  use CineasteWeb, :live_view

  alias Cineaste.Films

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, films: Films.list_films())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1 class="w-full text-center text-2xl font-display uppercase font-normal tracking-widest text-gray-600">
        Films
      </h1>
      <ul class="font-content">
        <%= for film <- @films do %>
          <li>
            <a href={~p"/films/#{film["slug"]}"}>{film["title"]}</a>
          </li>
        <% end %>
      </ul>
    </Layouts.app>
    """
  end
end
