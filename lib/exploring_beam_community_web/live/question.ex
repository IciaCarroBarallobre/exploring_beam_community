defmodule ExploringBeamCommunityWeb.Components.Question do
  use ExploringBeamCommunityWeb, :live_component

  import ExploringBeamCommunityWeb.Components.TypeOfQuestion,
    only: [multiple_choice_question: 1]

  import ExploringBeamCommunityWeb.CoreComponents, only: [icon: 1]

  @impl true
  def mount(socket) do
    {:ok, assign(socket, shown_all: false, top: 5)}
  end

  @impl true
  def handle_event("toggle_shown_all", _params, socket) do
    {:noreply, update(socket, :shown_all, fn shown -> not shown end)}
  end

  @impl true
  def render(assigns) do
    ~H"""

      <div class="py-12 border-b border-gray-500" id={"q-#{@id}"}>
        <div class="flex">
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
                    Show the top-<%=@top%> <.icon name="hero-chevron-up" class="w-5 h-5 text-main-500" />
                  <% else %>
                    Show all <.icon name="hero-chevron-down" class="w-5 h-5 text-main-500" />
                  <% end %>
                </span>
              </button>
            <%end%>
            <.multiple_choice_question
              options={@question["Options"]}
              total_answers={@question["TotalAnswers"]}
              shown_all={@shown_all}
              top={@top} />

          <% "Range" -> %>
            <.live_component
                module={ExploringBeamCommunityWeb.VegaLiteComponent}
                id={"graph_#{@id}"}
                spec={range_choice_spec(@question["Options"])}
              />

          <% "Single-choice" -> %>
            <.live_component
              module={ExploringBeamCommunityWeb.VegaLiteComponent}
              id={"graph_#{@id}"}
              spec={single_choice_spec(@question["Options"])}
            />

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

  defp single_choice_spec(unformatted_data) do
    data =
      for %{"Label" => label, "Responses" => responses} <- unformatted_data,
          do: %{"category" => label, "value" => responses}

    Tucan.donut(data, "value", "category", tooltip: :encoding)
    |> Tucan.set_theme(:dark)
    |> Tucan.View.set_background("#2A2F43")
    |> Tucan.Scale.set_color_scheme(:accent)
    |> Tucan.Legend.put_options(:color, label_font_size: 16)
    |> Tucan.Legend.set_title(:color, "")
  end

  defp range_choice_spec(unformatted_data) do
    data =
      for %{"Label" => label, "Responses" => responses} <- unformatted_data,
          do: %{"category" => label, "value" => responses}

    Tucan.lollipop(data, "category", "value", orient: :horizontal)
    |> Tucan.set_theme(:dark)
    |> Tucan.View.set_background("#2A2F43")
    |> Tucan.View.set_view_background(:white)
    |> Tucan.Axes.put_options(:y, label_font_size: 16)
    |> Tucan.Axes.set_xy_titles("", "")
  end
end
