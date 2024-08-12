defmodule ExploringBeamCommunityWeb.Footer do
  use Phoenix.Component

  attr(:navigation_pages, :list, required: true)
  attr(:text, :string, required: false, default: "")
  def footer(assigns) do
    ~H"""
    <footer class={
      "text-sm bottom-0 left-0 w-full md:px-10 " <>
      "border-t border-main-900/30 dark:border-white/30  p-2 " <>
      "flex justify-between items-center"
    }>
      <div><%= @text %></div>
      <div class="flex items-center space-x-4">
        <%= for %{route: route, name: name} <- @navigation_pages do %>
          <a href={route} class="hover:text-main-700 dark:hover:text-main-100">
            <%= name %>
          </a>
        <% end %>
      </div>
    </footer>
    """
  end
end
