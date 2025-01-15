defmodule ExploringBeamCommunityWeb.Components.TypeOfQuestion do
  use Phoenix.Component

  attr(:options, :list, required: true)
  attr(:total_answers, :integer, required: true)
  attr(:top, :integer, default: 5)
  attr(:shown_all, :boolean, default: true)

  def multiple_choice_question(assigns) do
    assigns = assign(assigns, :options, assigns.options |> Enum.sort_by(& &1["Responses"], :desc))

    ~H"""
    <div class="mt-4 space-y-3">
      <%= for option <- if @shown_all, do: @options, else: Enum.take(@options, @top) do %>
        <div class="relative">
          <span class="block text-right font-semibold my-2 flex justify-between items-center">
            <span class="text-sm font-bold mb-1"><%= option["Label"] %></span>
            <span class="text-right font-semibold my-2">
              <span class="text-xs mx-3"><%= option["Responses"] %> resp.</span>
              <span class="text-sm"><%= calculate_percentage_formated(option["Responses"], @total_answers) || "N/A" %></span>
            </span>
          </span>
          <div class="h-6 rounded-md bg-main-100 relative">
            <div class="bg-main-500 h-full rounded-md"
                 style={"width: #{calculate_percentage(option["Responses"], @total_answers)}%;"}></div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  attr(:options, :list, required: true)

  def range_question(assigns) do
    ~H"""
    <div class="mermaid" class="w-full">
      xychart-beta
        x-axis <%= list_to_text(for option <- @options, do: option["Label"]) %>
        y-axis "Responses" 0 --> <%= Enum.max(for option <- @options, do: option["Responses"])%>
        bar  <%= inspect(for option <- @options, do: option["Responses"])%>
        line <%= inspect(for option <- @options, do: option["Responses"])%>
    </div>
    """
  end

  defp calculate_percentage(responses, total_answers) do
    responses / total_answers * 100
  end

  defp calculate_percentage_formated(responses, total_answers) do
    percentage = calculate_percentage(responses, total_answers)
    formatted = :io_lib.format("~.1f", [percentage])
    "#{formatted}%"
  end

  def list_to_text(list) do
    "[" <>
      Enum.join(
        for item <- list do
          "\"#{item}\""
        end,
        ", "
      ) <> "]"
  end

  defimpl Jason.Encoder, for: VegaLite do
    def encode(value, opts) do
      value
      |> VegaLite.to_spec()
      |> Jason.Encode.map(opts)
    end
  end
end
