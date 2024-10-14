defmodule ExploringBeamCommunityWeb.HomeHTML do
  use ExploringBeamCommunityWeb, :html

  import ExploringBeamCommunityWeb.ComplexLogo, only: [complex_logo: 1]

  @doc """
  Renders a subscription form.
  """

  def index(assigns) do
    ~H"""
    <section class="py-8 px-4 md:px-8">
      <div class="flex flex-col md:flex-row items-center mx-auto py-3 px-3 space-y-4 md:space-y-0 md:space-x-4 max-w-4xl">
        <div class="flex-1">
          <h1 class="text-3xl dark:text-main-400 font-bold my-6">
            Welcome to our 2024 research on the European BEAM Community!
          </h1>
          <h2 class="text-lg mb-4">
            We invite you to explore and participate in our surveys to help us understand the adoption, diversity, and challenges of BEAM languages across Europe.
          </h2>
        </div>
        <div class="flex-1 flex justify-center w-2/3 md:w-1/3">
      <.complex_logo width={260} height={260}/>
      </div>
      </div>
      <div class="flex justify-center pt-8">
        <form action={~p"/results"} method="get">
          <.button type="submit">Take a look to the results!</.button>
        </form>
      </div>
    </section>

    <section class="py-8 px-4 md:px-8 ">
      <div class="container mx-auto px-6">
        <div style="position: relative; width: 100%; padding-bottom: 85%; height: 0; overflow: hidden;">
          <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSfAAThFH-sgoIv7BZhsZTIghqDOac_ysUODKzqaNP47-Kep8w/viewform?embedded=true"
                  style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;"
                  frameborder="0" marginheight="0" marginwidth="0">
            Loading...
          </iframe>
        </div>
      </div>
    </section>

    <section class="py-8 px-4 md:px-8">
      <div class="container mx-auto px-6">
        <h1 class="text-3xl font-semibold mb-6 text-center">About the Project</h1>
        <p class="text-lg mb-4">
          Our research analyzes the adoption, diversity, and challenges faced by developers, companies, and academia in
          Europe in using BEAM languages (Erlang, Elixir, Gleam). We aim to provide actionable insights for stakeholders involved
          in the BEAM ecosystem by evaluating the impact of these technologies in their specific contexts and enhancing the use
          of BEAM technologies.
        </p>
        <p class="text-lg font-medium my-3">
          Objectives:
        </p>
        <ul class="text-lg list-disc pl-5 space-y-2 text-gray-800 dark:text-gray-200">
          <li>
            <a class="font-semibold">Identify</a>
            the demographic and professional profiles of BEAM developers in Europe.
          </li>
          <li>
            <a class="font-semibold">Evaluate</a>
            the diversity and inclusivity within the BEAM developer community, considering gender, cultural background, socio-economic status, and community engagement.
          </li>
          <li>
            <a class="font-semibold">Analyze</a>
            the motivations and challenges of companies and academia in adopting BEAM languages.
          </li>
          <li>
            <a class="font-semibold">Assess</a>
            the impact of adopting BEAM languages on organizations' productivity, software quality, and scalability.
          </li>
        </ul>
      </div>
    </section>
    """
  end
end
