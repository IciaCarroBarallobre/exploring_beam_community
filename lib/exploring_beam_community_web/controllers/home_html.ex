defmodule ExploringBeamCommunityWeb.HomeHTML do
  use ExploringBeamCommunityWeb, :html

  def index(assigns) do
    ~H"""
    <section class="py-8 px-4 md:px-8">
      <div class="flex flex-col md:flex-row items-center mx-auto py-3 px-3 space-y-4 md:space-y-0 md:space-x-4 max-w-4xl">
        <div class="flex-1">
          <h1 class="text-3xl dark:text-main-100 font-bold my-6">
            Welcome to our 2024 research on the European BEAM Community!
          </h1>
          <h2 class="text-lg mb-4">
            We invite you to explore and participate in our surveys to help us understand the adoption, diversity, and challenges of BEAM languages across Europe.
          </h2>
        </div>
        <div class="flex-1 flex justify-center">
          <img
            src="/images/logo_complex.svg"
            class="w-2/3 md:w-4/5 block dark:hidden"
            alt="Logo Light Mode"
          />
          <img
            src="/images/logo_complex_dark.svg"
            class="w-2/3 md:w-4/5 hidden dark:block"
            alt="Logo Dark Mode"
          />
        </div>
      </div>
      <div class="flex justify-center pt-8">
        <a href="/survey" class="inline-block bg-main-900 dark:bg-main-500 text-white text-xl px-6 py-4 rounded hover:bg-main-400">
          Contribute to the survey
        </a>
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
            <a class="font-semibold">Identify</a> the demographic and professional profiles of BEAM developers in Europe.
          </li>
          <li>
            <a class="font-semibold">Evaluate</a> the diversity and inclusivity within the BEAM developer community, considering gender, cultural background, socio-economic status, and community engagement.
          </li>
          <li>
            <a class="font-semibold">Analyze</a> the motivations and challenges of companies and academia in adopting BEAM languages.
          </li>
          <li>
            <a class="font-semibold">Assess</a> the impact of adopting BEAM languages on organizations' productivity, software quality, and scalability.
          </li>
        </ul>
      </div>
    </section>
    """
  end
end
