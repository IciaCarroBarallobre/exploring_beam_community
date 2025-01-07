defmodule ExploringBeamCommunityWeb.ResultsView do
  use ExploringBeamCommunityWeb, :live_view
  alias ExploringBeamCommunityWeb.Components.{Question}

  def mount(_params, _session, socket) do
    results =
      case File.read("priv/static/results/dev_gi.json") do
        {:ok, file_content} ->
          case Jason.decode(file_content) do
            {:ok, data} -> data
            {:error, _} -> %{"Questions" => []}
          end

        {:error, _} ->
          %{"Questions" => []}
      end

    {:ok, assign(socket, results: results, page_title: "Results")}
  end

  def render(assigns) do
    ~H"""
      <!-- Header -->
      <div>
        <div class="text-center mb-8">
          <h1 class="text-4xl md:text-5xl font-extralight  my-4">BEAM <%= @results["Name"]%> Survey <%= @results["Year"]%></h1>
          <p class="text-lg mt-2 font-light ">
          Explore the trends, challenges, and strengths of the BEAM ecosystem from <%= @results["TotalResponses"]%> participants.
          </p>
        </div>

        <!-- Categories Section -->
        <div class="text-center font-light  my-8">

          <div class="flex flex-wrap gap-6 justify-center">
            <%= for {section, section_index} <- Enum.with_index(@results["Sections"]) do %>
              <%= button_to_section(%{index: section_index, name: section["Name"]}) %>
            <% end %>
          </div>
        </div>
      </div>

      <!-- Sections & Questions-->
      <div class="results-container space-y-8">
        <%= for {section, section_index} <- Enum.with_index(@results["Sections"]) do %>
        <div id={"section-#{section_index}"} class={"section-#{section_index}  p-6"}>
            <h3 class="text-2xl text-center font-semibold  pb-3 mb-4">
              <a href={"#section-#{section_index}"}>
                <%= section["Name"] %>
              </a>
            </h3>

            <%= for {question, question_index} <- Enum.with_index(section["Questions"]) do %>

              <.live_component
                module={Question}
                question={question}
                id={"section_#{section_index}_question_#{question_index}"
                }/>
            <% end %>
          </div>
        <% end %>
      </div>

      <!-- Final -->
      <div class="m-4">
        <h3 class="text-center text-light text-2xl m-4"> ✨ A Big Thank You to All Participants! 💌</h3>

        <p class="text-center">
          We want to extend our heartfelt gratitude to each and every one of you for your invaluable input.
          🙏 Your feedback is not just appreciated—it’s truly instrumental in guiding us as we continue to improve and evolve.
          We are incredibly grateful for the time and effort you’ve invested. We keep working to make the next ones better. ❤️💜💗
        </p>
      </div>
    """
  end

  def button_to_section(assigns) do
    ~H"""
    <a href={"#section-#{@index}"} class="bg-main-500 text-white py-2 px-4 rounded-md hover:bg-main-700 focus:outline-none focus:ring-2 focus:ring-main-400">
      <%= @name %>
    </a>
    """
  end
end
