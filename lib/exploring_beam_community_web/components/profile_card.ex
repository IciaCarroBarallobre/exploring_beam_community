defmodule ExploringBeamCommunityWeb.ProfileCard do
  use Phoenix.Component
  import ExploringBeamCommunityWeb.CoreComponents, only: [icon: 1]

  attr(:name, :string, required: true)
  attr(:role, :string, required: false, default: "")
  attr(:company, :string, required: false)
  attr(:image, :string, required: false, default: "")
  attr(:description, :string, required: false, default: "")

  attr(:twitter, :string, required: false, default: "")
  attr(:gmail, :string, required: false, default: "")
  attr(:linkedin, :string, required: false, default: "")
  attr(:github, :string, required: false, default: "")

  def profile_card(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto bg-zinc-200 dark:bg-main-700 rounded-lg shadow-lg overflow-hidden">
      <div class="flex items-center">
        <img class="w-32 h-32 object-cover rounded-full mx-4 my-4" src={@image} alt="Profile Image" />
        <div class="p-6">
          <h2 class="text-xl font-bold"><%= @name %></h2>
          <p class="text-gray-600 dark:text-gray-300 text-xs"><%= @role %></p>
          <p class="text-gray-600 dark:text-gray-300 text-xs">@ <%= @company %></p>
        </div>
      </div>
      <div class="px-6 pb-4">
        <h3 class="text-lg font-semibold mb-2">Description</h3>
        <p class="text-gray-700 dark:text-gray-400">
          <%= @description %>
        </p>
      </div>
      <div class="p-4 flex space-x-6 md:space-x-4 mx-auto justify-center text-center">
        <!-- Email -->
        <%= if @gmail != "" do %>
          <a href={"mailto:" <> @gmail} class="[&>svg]:h-6 [&>svg]:w-6 hover:text-red-600" target="_blank">
            <.icon name={"gmail"}/>
          </a>
        <% end %>

        <!-- LinkedIn -->
        <%= if @linkedin != "" do %>
          <a href={"https://www.linkedin.com/in/" <> @linkedin} class="[&>svg]:h-6 [&>svg]:w-6 hover:text-blue-600" target="_blank">
            <.icon name={"linkedin"}/>
          </a>
        <% end %>

        <!-- Github -->
        <%= if @github != "" do %>
          <a href={"https://www.github.com/" <> @github} class="[&>svg]:h-6 [&>svg]:w-6 hover:text-zinc-500" target="_blank">
            <.icon name={"github"}/>
          </a>
        <% end %>

        <!-- Twitter -->
        <%= if @twitter != "" do %>
          <a href={"https://twitter.com/" <> @twitter} class="[&>svg]:h-6 [&>svg]:w-6 hover:text-blue-400" target="_blank">
            <.icon name={"twitter"}/>
          </a>
        <% end %>
      </div>
    </div>
    """
  end
end
