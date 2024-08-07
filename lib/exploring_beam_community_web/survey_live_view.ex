defmodule ExploringBeamCommunityWeb.SurveyLiveView do
  use ExploringBeamCommunityWeb, :live_view

  def mount(_params, _session, socket) do
    # Ensure the forms list is correctly initialized
    forms = [
      %{
        id: "form1",
        name: "Companies",
        src: "https://tally.so/embed/w7Z8BP?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1"
      },
      %{
        id: "form2",
        name: "Developers GI",
        src: "https://tally.so/embed/nrVaKl?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1"
      },
      %{
        id: "form3",
        name: "Developers SD",
        src: ""
      },
      %{
        id: "form4",
        name: "Academia",
        src: "https://tally.so/embed/n0LB8j?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1"
      }
    ]

    IO.inspect(forms, label: "Forms List")  # Debugging output

    {:ok, assign(socket, forms: forms, active_form_id: "")}
  end

  def render(assigns) do
    IO.inspect(assigns, label: "Render Assigns")  # Debugging output

    ~H"""
    <div class="container mx-auto py-12 px-6">
       <p>Choose a survey:</p>
      <div class="flex justify-center mb-6 space-x-4">

        <%= for form <- @forms do %>
          <button phx-click="show_form" phx-value-id={form.id} class={
            "border border-2 border-white toggle-btn py-2 px-4 rounded shadow transition duration-200 " <>
            if form.id == @active_form_id, do: "bg-main-900 text-white", else: "bg-white dark:bg-main-800 text-black dark:text-white"
          }>
            <%= form.name %>
          </button>
        <% end %>
      </div>

      <%= for form <- @forms do %>
        <div id={form.id} class={"form-iframe " <> if form.id != @active_form_id, do: "hidden", else: ""}>
          <iframe data-tally-src={form.src} loading="lazy" width="100%" height="800" frameborder="0" marginheight="0" marginwidth="0" title={form.name}></iframe>
        </div>
      <% end %>

      <script>
        var d = document, w = "https://tally.so/widgets/embed.js", v = function() {
          "undefined" != typeof Tally ? Tally.loadEmbeds() : d.querySelectorAll("iframe[data-tally-src]:not([src])").forEach(function(e) {
            e.src = e.dataset.tallySrc;
          });
        };
        if ("undefined" != typeof Tally) v();
        else if (d.querySelector('script[src="' + w + '"]') == null) {
          var s = d.createElement("script");
          s.src = w, s.onload = v, s.onerror = v, d.body.appendChild(s);
        }
      </script>
    </div>
    """
  end

  def handle_event("show_form", %{"id" => form_id}, socket) do
    {:noreply, assign(socket, active_form_id: form_id)}
  end
end
