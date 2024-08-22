defmodule ExploringBeamCommunityWeb.Footer do
  use Phoenix.Component

  attr(:navigation_pages, :list, required: true)
  attr(:text, :string, required: false, default: "")
  attr(:emails, :list, required: false, default: [])

  def footer(assigns) do
    ~H"""
    <footer class={
      "text-xs md:text-sm bottom-0 left-0 w-full md:px-10 " <>
      "border-t border-main-900/30 dark:border-white/30  p-2 " <>
      "flex justify-between items-center"
    }>
      <div class="max-w-[30%] mr-5"><%= @text %></div>
      <div class="flex flex-row items-center space-x-4">
        <%= for %{route: route, name: name} <- @navigation_pages do %>
          <a href={route} class="hover:text-main-700 dark:hover:text-main-400">
            <%= name %>
          </a>
        <% end %>

        <%= if @emails != [] do %>
          <a class="hover:text-main-700 dark:hover:text-main-400"
             href={"mailto:" <> Enum.join(@emails, ",") <>
                   "?subject=Hello&body=I%20wanted%20to%20reach%20out%20to%20you"}>
             Contact us!
          </a>
        <% end %>
      </div>
    </footer>
    """
  end
end
