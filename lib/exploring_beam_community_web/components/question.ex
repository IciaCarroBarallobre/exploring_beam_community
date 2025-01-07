defmodule ExploringBeamCommunityWeb.Components.Question do
  import ExploringBeamCommunityWeb.Components.TypeOfQuestion,
    only: [multiple_choice_question: 1, single_choice_question: 1, range_question: 1]

  import ExploringBeamCommunityWeb.CoreComponents, only: [icon: 1]

  use ExploringBeamCommunityWeb, :live_component

  @impl true
  def mount(socket) do
    base_url = ExploringBeamCommunityWeb.Endpoint.url()
    {:ok, assign(socket, shown_all: false, top: 5, base_url: base_url)}
  end

  @impl true
  def handle_event("toggle_shown_all", _params, socket) do
    {:noreply, update(socket, :shown_all, fn shown -> not shown end)}
  end

  @impl true
  def handle_event("copy_link", %{"question_id" => question_id}, socket) do
    base_url = socket.assigns.base_url
    shareable_link = "#{base_url}/results##{question_id}"

    {:noreply, push_event(socket, "clipboard_copy", %{text: shareable_link})}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div class="py-12 border-b border-gray-500" id={"q-#{@id}"}>
        <div class="flex">
          <button
              type="button"
              phx-target={@myself}
              phx-click={JS.push("copy_link", value: %{question_id: "q-#{@id}"})}
              class="text-gray-400 hover:text-blue-700 flex items-center gap-1"
              title="Copy link to this question"
            >
              <.icon name="hero-link" class=" mb-3 w-5 h-5 text-gray-400 hover:text-blue-700 "/>
            </button>
            <p class="ml-2 text-xl mb-3 font-light">
              <strong><%= @question["QuestionText"] %></strong>
            </p>
        </div>


        <p class="text-sm text-right mr-4"><%= @question["TotalAnswers"] %> answered</p>

        <%= case @question["QuestionType"] do %>
          <% "Multiple-choice" -> %>
            <%= if (length(@question["Options"]) > @top) do%>
              <button
                type="button"
                phx-click="toggle_shown_all"
                phx-target={@myself}
                class="text-main-400 hover:text-main-500 flex items-center gap-2"
              >
                <span>
                  <%= if @shown_all do %>
                    Show the top-<%=@top%>
                    <.icon name="hero-chevron-up" class="w-5 h-5 text-main-500" />
                  <% else %>
                    Show all
                    <.icon name="hero-chevron-down" class="w-5 h-5 text-main-500" />
                  <% end %>
                </span>
              </button>
          <%end%>

            <.multiple_choice_question options={@question["Options"]} shown_all={@shown_all} top={@top} />
          <% "Range" -> %>
            <.range_question options={@question["Options"]} />
          <% "Single-choice" -> %>
            <.single_choice_question options={@question["Options"]} />
          <% _ -> %>
            <p>An error occurred while rendering this question.</p>
        <% end %>

        <%= if @question["Observation"] do %>
          <p class="mt-8 bg-main-100 border-l-4 border-main-400 text-main-800 p-4 rounded-md shadow-sm">
            <strong>Observation:</strong> <%= @question["Observation"] %>
          </p>
        <% end %>
      </div>
    """
  end
end
