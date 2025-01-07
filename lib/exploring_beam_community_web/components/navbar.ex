defmodule ExploringBeamCommunityWeb.Components.Navbar do
  import ExploringBeamCommunityWeb.CoreComponents, only: [icon: 1]

  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: ExploringBeamCommunityWeb.Endpoint,
    router: ExploringBeamCommunityWeb.Router

  alias Phoenix.LiveView.JS

  attr(:navigation_pages, :list, required: true)
  attr(:logo, :string, default: "")
  attr(:dark_logo, :string, default: "")
  slot(:banner, default: nil)

  def navbar(assigns) do
    ~H"""
    <header class="sticky top-0 px-4 md:px-6 lg:px-8 bg-white dark:bg-main-900 shadow z-50">
      <div class="flex items-center justify-between py-3">
        <div>
          <a href="/" class="flex items-center gap-4">
            <img src={@logo} class="block dark:hidden" width="50" />
            <img src={@dark_logo} class="hidden dark:block" width="50" />
            <p class="font-bold">Exploring Beam Community</p>
          </a>
        </div>
        <div class="md:hidden">
          <button phx-click={show_hamburger()}>
            <.icon name="hero-ellipsis-vertical-mini" />
          </button>
        </div>

        <div class="hidden md:flex md:items-center md:gap-4 font-semibold leading-6 text-main-900 dark:text-white">
          <%= for %{route: route, name: name} <- @navigation_pages do %>
            <a href={route} class="hover:text-main-400">
              <%= name %>
            </a>
          <% end %>
        </div>
      </div>

      <div id="hamburger-container" class="hidden relative z-50">
        <div
          id="hamburger-backdrop"
          class="fixed inset-0 bg-zinc-50/90 dark:bg-main-700/90 transition-opacity"
        ></div>
        <nav
          id="hamburger-content"
          class={
            "fixed top-0 left-0 bottom-0 " <>
            "flex flex-col grow justify-between " <>
            "w-3/4 max-w-sm py-6 " <>
            "bg-white dark:bg-main-900 overflow-y-auto"
          }
        >
          <div>
            <div class="flex items-center mb-4 place-content-between mx-4 border-b-zinc-200">
              <div class="flex items-center gap-4"></div>
              <button class="navbar-close" phx-click={hide_hamburger()}>
                <.icon name="hero-x-mark-mini" />
              </button>
            </div>
          </div>
          <div>
            <ul>
              <%= for %{route: route, name: name} <- @navigation_pages do %>
                <.hamburger_nav_link href={route} label={name} />
              <% end %>
            </ul>
          </div>
        </nav>
      </div>
    </header>
    <%= if @banner != nil and @banner != [] do%>
      <p class="text-center font-semibold bg-main-200 dark:bg-main-500 py-2">
        <%= render_slot(@banner) %>
      </p>
    <%end%>
    """
  end

  attr(:href, :string, required: true)
  attr(:label, :string, required: true)
  attr(:icon, :string, default: nil)
  attr(:icon_class, :string, default: nil)
  attr(:active, :boolean, default: false)

  defp hamburger_nav_link(assigns) do
    ~H"""
    <li
      class={[
        "block px-4 py-2 font-semibold hover:bg-slate-300 hover:dark:bg-main-600",
        @active && "bg-slate-200"
      ]}
      phx-click={JS.navigate(@href)}
    >
      <span :if={@icon != nil} class={[@icon, @icon_class, "-mt-1"]} />
      <a href={@href}><%= @label %></a>
    </li>
    """
  end

  defp show_hamburger(js \\ %JS{}) do
    js
    |> JS.show(
      to: "#hamburger-content",
      transition:
        {"transition-all transform ease-in-out duration-300", "-translate-x-3/4", "translate-x-0"},
      time: 300,
      display: "flex"
    )
    |> JS.show(
      to: "#hamburger-backdrop",
      transition:
        {"transition-all transform ease-in-out duration-300", "opacity-0", "opacity-100"}
    )
    |> JS.show(
      to: "#hamburger-container",
      time: 300
    )
    |> JS.add_class("overflow-hidden", to: "body")
  end

  defp hide_hamburger(js \\ %JS{}) do
    js
    |> JS.hide(
      to: "#hamburger-backdrop",
      transition: {"transition-all transform ease-in duration-200", "opacity-100", "opacity-0"}
    )
    |> JS.hide(
      to: "#hamburger-content",
      transition:
        {"transition-all transform ease-in duration-200", "translate-x-0", "-translate-x-3/4"}
    )
    |> JS.hide(to: "#hamburger-container", transition: {"block", "block", "hidden"})
    |> JS.remove_class("overflow-hidden", to: "body")
  end
end
