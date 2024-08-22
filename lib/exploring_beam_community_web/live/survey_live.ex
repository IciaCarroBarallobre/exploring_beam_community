defmodule ExploringBeamCommunityWeb.SurveyView do
  use ExploringBeamCommunityWeb, :live_view

  def mount(_params, _session, socket) do
    forms = [
      %{
        id: "form1",
        title: "Company",
        subtitle: "",
        details: "Help us understand how your company adopts and utilizes BEAM languages.",
        action: %{
          src:
            "https://tally.so/embed/mOLXqa?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1",
          text: "Start Survey"
        }
      },
      %{
        id: "form2",
        title: "Developers",
        subtitle: "(General Information)",
        details: "Provide insights into your professional and technical background.",
        action: %{
          src:
            "https://tally.so/embed/waGblv?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1",
          text: "Start Survey"
        }
      },
      %{
        id: "form3",
        title: "Developers",
        subtitle: "(Sensitive Data)",
        details: "Share your experiences with diversity, inclusion, and mental health.",
        action: %{
          src:
            "https://tally.so/embed/3E0jM4?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1",
          text: "Start Survey"
        }
      },
      %{
        id: "form4",
        title: "Academia",
        subtitle: "",
        details: "Tell us about using BEAM languages in your academic work.",
        action: %{
          src:
            "https://tally.so/embed/w4LXYO?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1",
          text: "Start Survey"
        }
      }
    ]

    {:ok, assign(socket, forms: forms, active_form_id: "", page_title: "Surveys")}
  end

  def render(assigns) do
    ~H"""
    <div class="p-3 text-center mx-auto ">

      <.button phx-click={JS.dispatch("exploring_beam_community:clipcopy", to: "#share-msg")}>
        Invite others <.icon name="hero-share-solid" class="h-4 w-4" />
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
    <div class="container mx-auto py-6 px-6 mb-4">
      <h1 class="text-2xl text-center font-bold md:w-full w-4/5 mx-auto">Contribute to Our 2024 Research</h1>
      <p class="text-lg text-center py-8 md:w-full w-4/5 mx-auto">Select <strong class="underline underline-offset-8 decoration-2 text-main-500 dark:text-white">one or more</strong> surveys that fit your role and experience to share your insights.</p>
      <div class="grid gap-4 md:grid-cols-4 grid-cols-1 text-center my-8 md:w-full w-2/3 mx-auto">
        <%= for form <- @forms do %>
          <div class="flex flex-col md:h-44 h-fit">
            <span class="flex flex-col mb-1">
              <h2 class="text-lg font-black "><%= form.title %></h2>
              <h3 class="text-sm font-bold "><%= form.subtitle %></h3>
            </span>
            <p class="text-sm mb-4"><%= form.details %></p>
            <button
              phx-click="show_form"
              phx-value-id={form.id}
              aria-controls={form.id}
              aria-expanded={form.id == @active_form_id}
              class={
              "border-2 border-main-900 dark:border-white toggle-btn py-2 px-4 transition duration-300 rounded-lg hover:bg-main-400 hover:text-white mt-auto " <>
              if form.id == @active_form_id, do: "bg-main-900 text-white dark:bg-main-500", else: "bg-white dark:bg-main-800"
            }
            >
              <%= form.action.text %>
            </button>
          </div>
        <% end %>
      </div>

      <%= for form <- @forms do %>
        <%= if form.action.src != "" do %>
          <div
            phx-update="ignore"
            id={form.id}
            class={"form-iframe text-main-9000 dark:text-white " <> if form.id != @active_form_id, do: "hidden", else: ""}
          >
            <iframe
              data-tally-src={form.action.src}
              loading="lazy"
              width="100%"
              height="800"
              frameborder="0"
              marginheight="0"
              marginwidth="0"
              title={form.title}
            >
            </iframe>
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
