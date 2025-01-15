defmodule ExploringBeamCommunityWeb.VegaLiteComponent do
  use ExploringBeamCommunityWeb, :live_component

  @impl true
  def update(assigns, socket) do
    socket = assign(socket, id: assigns.id)
    {:ok, push_event(socket, "vega_lite:#{socket.assigns.id}:init", %{"spec" => assigns.spec})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-center items-center ">
      <div id={"vega-lite-#{@id}"} phx-hook="VegaLite" phx-update="ignore" data-id={@id}>
      </div>
    </div>
    """
  end
end
