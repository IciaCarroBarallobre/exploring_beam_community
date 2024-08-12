defmodule ExploringBeamCommunityWeb.SurveyLiveView do
  use ExploringBeamCommunityWeb, :live_view

  def mount(_params, _session, socket) do
    forms = [
      %{
        id: "form1",
        name: "Companies",
        src:
          "https://tally.so/embed/w7Z8BP?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1"
      },
      %{
        id: "form2",
        name: "Developers GI",
        src:
          "https://tally.so/embed/nrVaKl?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1"
      },
      %{
        id: "form3",
        name: "Developers SD",
        src: ""
      },
      %{
        id: "form4",
        name: "Academia",
        src:
          "https://tally.so/embed/n0LB8j?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1"
      }
    ]

    {:ok, assign(socket, forms: forms, active_form_id: "")}
  end

  def render(assigns) do
    ~H"""

    <div class="p-3 text-center mx-auto ">
      <.button
        class="inline-block bg-main-800 dark:bg-main-500 text-white text-lg px-3 py-2 rounded hover:bg-main-300"
        phx-click={JS.dispatch("exploring_beam_community:clipcopy", to: "#share-msg")}
      >
        Invite others
        <.icon name="hero-share-solid" class="h-4 w-4" />
      </.button>
      <p class="hidden" id="share-msg">
      🌍 Join the European BEAM Community Survey! 🌟

      We’re gathering insights to understand how BEAM languages are adopted across Europe,
      focusing on diversity and the challenges faced. Your participation is vital!

      🗨️ Share your experiences and help shape the future of the BEAM community.

      👉 https://exploring-beam-community.fly.dev

      🙏 Help us reach more people by sharing this survey with your network.
      Together, we can make a big impact! #BEAMSurvey #TechDiversity #BEAMLanguages

      </p>
      <p id="clipcopyinfo" class="hidden pl-10 fixed">Copied!</p>
    </div>
    <div class="container mx-auto py-6 px-6">
      <p class="text-lg text-center pb-3"> Choose the surveys that apply to you. </p>
      <div class="flex justify-center mb-6 space-x-4">
        <%= for form <- @forms do %>
          <button phx-click="show_form" phx-value-id={form.id} aria-controls={form.id} aria-expanded={form.id == @active_form_id} class={
            "border-b-2  border-main-600 dark:border-white toggle-btn py-2 px-4 transition duration-300 " <>
            if form.id == @active_form_id, do: "bg-zinc-100 dark:bg-main-700", else: "bg-white dark:bg-main-800"
          }>
            <%= form.name %>
          </button>
        <% end %>
      </div>

      <%= for form <- @forms do %>
        <%= if form.src != "" do %>
          <div phx-update="ignore" id={form.id} class={"form-iframe " <> if form.id != @active_form_id, do: "hidden", else: ""}>
            <iframe data-tally-src={form.src} loading="lazy" width="100%" height="800" frameborder="0" marginheight="0" marginwidth="0" title={form.name}></iframe>
          </div>
        <% end %>
      <% end %>

      <script>
        document.addEventListener("phx:update", function() {
          var d = document, w = "https://tally.so/widgets/embed.js";
          var v = function() {
            if (typeof Tally !== "undefined") {
              Tally.loadEmbeds();
            } else {
              d.querySelectorAll("iframe[data-tally-src]:not([src])").forEach(function(e) {
                e.src = e.dataset.tallySrc;
              });
            }
          };

          if (typeof Tally !== "undefined") {
            v();
          } else if (!d.querySelector('script[src="' + w + '"]')) {
            var s = d.createElement("script");
            s.src = w;
            s.onload = v;
            s.onerror = v;
            d.body.appendChild(s);
          }
        });
      </script>
    </div>
    """
  end

  def handle_event("show_form", %{"id" => form_id}, socket) do
    {:noreply, assign(socket, active_form_id: form_id)}
  end
end
