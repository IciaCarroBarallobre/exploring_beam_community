defmodule ExploringBeamCommunityWeb.ResultsView do
  use ExploringBeamCommunityWeb, :live_view

  def mount(_params, _session, socket) do
    slides =
      %{
        id: "form1",
        path: "/pdf/slides.pdf"
      }

    {:ok, assign(socket, slides: slides, page_title: "Results")}
  end

  def render(assigns) do
    ~H"""
    <div class="p-3 text-center mx-auto ">
    <div class="m-6">
    <.button phx-click={JS.navigate("/pdf/slides.pdf")}>
      Download PDF <.icon name="hero-arrow-down-on-square" class="h-6 w-6" />
    </.button>
    </div>
    <div style="position: relative; padding-bottom: 80%; height: 0; overflow: hidden;">
    <iframe src="/pdf/slides.pdf" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" frameborder="0" allowfullscreen>
      This browser does not support PDFs. Please download the PDF to view it: <a href="/pdf/slides.pdf">Download PDF</a>.
    </iframe>
    </div>

    </div>
    """
  end
end
