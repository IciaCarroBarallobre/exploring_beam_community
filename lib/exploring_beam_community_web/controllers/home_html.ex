defmodule ExploringBeamCommunityWeb.HomeHTML do
  use ExploringBeamCommunityWeb, :html

  def index(assigns) do
    ~H"""
    <!-- Hero Section -->
    <section class="bg-gray-50 dark:bg-main-900">
      <div class="container mx-auto py-6 px-6 text-center">
        <h1 class="text-4xl font-bold mb-4">Exploring the BEAM Developer Community in Europe</h1>
        <h2 class="text-2xl font-semibold text-main-700 dark:text-main-100 mb-4">|> In(2024)</h2>
        <p class="text-lg mb-6">Insights into adoption, diversity, and challenges within the BEAM ecosystem.</p>
        <a href="/survey" class="inline-block bg-main-900 dark:bg-main-500 text-white text-xl px-6 py-2 rounded hover:bg-main-400">Contribute to the survey</a>
        <div class="flex justify-center mt-5">
          <img src="/images/logo_complex.svg" class="block dark:hidden" width="300" alt="Logo Light Mode" />
          <img src="/images/logo_complex_dark.svg" class="hidden dark:block" width="300" alt="Logo Dark Mode" />
        </div>
      </div>
    </section>

    <!-- About the Study -->
    <section id="about" class="py-6">
      <div class="container mx-auto px-6 text-center">
        <h2 class="text-3xl font-semibold mb-4">About the Study</h2>
        <p class="text-lg mb-4">
          This comprehensive analysis examines the adoption, diversity, and challenges faced by developers,
          companies, and academia using BEAM languages in Europe.
        </p>
        <p class="text-lg">
          Our goal is to understand the impact of BEAM technologies and provide actionable insights for stakeholders in the tech industry.
        </p>
      </div>
    </section>

    <!-- About us Highlights -->
      <section id="about" class="py-12">
      <div class="container mx-auto px-6 text-center">
        <h2 class="text-3xl font-semibold mb-4">About us</h2>
        <p class="text-lg mb-4">
          Why we do this? Our goal is to understand the impact of BEAM technologies and provide actionable insights for stakeholders in the tech industry.
        </p>

        <a href="/about-us" class="inline-block bg-main-900 dark:bg-main-700  px-6 py-2 rounded hover:bg-main-600">More about us</a>

      </div>
    </section>
    """
  end
end
