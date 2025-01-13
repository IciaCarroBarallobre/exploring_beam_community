defmodule ExploringBeamCommunityWeb.ResultsLive do
  use ExploringBeamCommunityWeb, :live_view
  alias ExploringBeamCommunityWeb.Components.{Question}

  def mount(_params, _session, socket) do
    priv_dir = Application.app_dir(:exploring_beam_community, "priv/static")

    surveys = [
      %{
        id: "dev_gi",
        name: "👩‍💻 Developers GI",
        path: Path.join(priv_dir, "results/dev_gi.json")
      },
      %{
        id: "companies",
        name: "🏢 Companies",
        path: Path.join(priv_dir, "results/companies.json")
      },
      %{
        id: "academia",
        name: "🎓 Academia",
        path: Path.join(priv_dir, "results/academia.json")
      }
    ]

    {:ok,
     assign(socket,
       surveys: surveys,
       page_title: "Results",
       active_survey_id: nil,
       results: %{}
     )}
  end

  def render(assigns) do
    ~H"""
      <!-- Header -->
      <div class="py-4">
        <div class="text-center mb-8">
          <h1 class="text-4xl md:text-5xl font-extralight my-4">BEAM <%= @results["Name"]%> Survey <%= @results["Year"]%></h1>
          <p class="text-lg mt-2 font-light ">
          Explore the trends, challenges, and strengths of the BEAM ecosystem from <%= @results["TotalResponses"]%> participants.
          </p>
        </div>

        <!-- Buttons to choose the survey -->
        <div class="grid gap-4 md:grid-cols-3 grid-cols-1 text-center md:w-4/5 w-2/3 mx-auto">
          <%= for survey <- @surveys do %>
            <div class="flex flex-col h-fit">
              <button
                phx-click="show_survey_results"
                phx-value-id={survey.id}
                aria-controls={survey.id}
                aria-expanded={survey.id == @active_survey_id}
                class={
                "toggle-btn py-2 px-4 transition duration-300 rounded-lg hover:bg-main-700 text-white mt-auto " <>
                if survey.id == @active_survey_id, do: "text-white bg-main-700", else: "bg-main-400"
              }
              >
                <%= survey.name %>
              </button>
            </div>
          <% end %>
        </div>
      </div>

      <%= if @active_survey_id != nil do%>
        <!-- Survey Content -->
        <div class="md:w-full w-5/6 mx-auto">
          <!-- Categories Section -->
          <div class="text-center font-light my-8 py-8 border-y border-gray-500">
            <div class="flex flex-wrap gap-6 justify-center">
              <%= for {section, section_index} <- Enum.with_index(@results["Sections"]) do %>
                <%= button_to_section(%{index: section_index, name: section["Name"], active_survey_id: @active_survey_id}) %>
              <% end %>
            </div>
          </div>

          <!-- Sections & Questions-->
          <div class="results-container space-y-8">
            <%= for {section, section_index} <- Enum.with_index(@results["Sections"]) do %>
            <div class={" p-6"} id={"#{@active_survey_id}-section-#{section_index}"}>
                <h3 class="text-2xl text-center font-semibold  pb-3 mb-4">
                    <%= section["Name"] %>
                </h3>

                <%= for {question, question_index} <- Enum.with_index(section["Questions"]) do %>
                  <.live_component
                    module={Question}
                    question={question}
                    id={"#{@active_survey_id}-section_#{section_index}_question_#{question_index}"
                    }/>
                <% end %>
              </div>
            <% end %>
          </div>
        </div>
        <button
          id="scrollToTopBtn"
          class="fixed bottom-4 md:bottom-8 right-4 md:right-8 bg-main-500 text-white p-4 md:p-6 rounded-full shadow-lg hover:bg-main-700 focus:outline-none"
          aria-label="Scroll to top"
          phx-hook="ScrollToTop"
        >
          ↑
        </button>
      <%else%>
        <!-- Thxs -->
        <div class="m-8 bg-main-100 border-l-4 border-main-400 text-main-800 p-4 rounded-md shadow-sm">
          <p>
            <strong>Thank you 🙏</strong> - We want to extend our heartfelt gratitude to every one of you for taking the time and effort of fill the suverys.
              We keep working to make the next ones better. ❤️💜💗
          </p>
        </div>
      <%end%>

    """
  end

  def button_to_section(assigns) do
    ~H"""
    <a href={"##{@active_survey_id}-section-#{@index}"} class="bg-main-500 text-white py-2 px-4 rounded-md hover:bg-main-700 focus:outline-none focus:ring-2 focus:ring-main-400">
      <%= @name %>
    </a>
    """
  end

  def handle_event("show_survey_results", %{"id" => survey_id, "value" => _value}, socket) do
    surveys = socket.assigns.surveys

    # Find the survey with the matching ID
    case Enum.find(surveys, fn s -> s.id == survey_id end) do
      nil ->
        # Survey not found
        {:noreply,
         socket
         |> assign(results: nil, active_survey_id: nil)
         |> put_flash(:error, "Survey not found.")}

      survey ->
        # Attempt to read and decode the survey file
        case File.read(survey.path) do
          {:ok, file_content} ->
            case Jason.decode(file_content) do
              {:ok, data} ->
                {:noreply, assign(socket, results: data, active_survey_id: survey_id)}

              {:error, _} ->
                {:noreply,
                 socket
                 |> assign(results: nil, active_survey_id: nil)
                 |> put_flash(:error, "Failed to display the survey data.")}
            end

          {:error, _} ->
            {:noreply,
             socket
             |> assign(results: nil, active_survey_id: nil)
             |> put_flash(:error, "Failed to display the survey data.")}
        end
    end
  end
end
