defmodule ExploringBeamCommunityWeb.ProfileCard do
  use Phoenix.Component

  attr(:name, :string, required: true)
  attr(:role, :string, required: false, default: "")
  attr(:company, :string, required: false)
  attr(:image, :string, required: false, default: "")
  attr(:description, :string, required: false, default: "")

  def profile_card(assigns) do
    ~H"""
      <div class="max-w-2xl mx-auto bg-zinc-200 dark:bg-main-700 rounded-lg shadow-lg overflow-hidden">
          <div class="flex items-center">
            <img class="w-32 h-32 object-cover rounded-full mx-4 my-4" src={@image} alt="Profile Image">
            <div class="p-6">
              <h2 class="text-xl font-bold"> <%= @name %></h2>
              <p class="text-gray-600 dark:text-gray-300"><%= @role %></p>
              <p class="text-gray-600 dark:text-gray-300">@ <%= @company %></p>
            </div>
          </div>
          <div class="px-6 pb-4">
            <h3 class="text-lg font-semibold mb-2">Description</h3>
            <p class="text-gray-700 dark:text-gray-400">
              <%= @description %>
            </p>
          </div>
        </div>
    """
  end
end
