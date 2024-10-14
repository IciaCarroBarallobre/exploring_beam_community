defmodule ExploringBeamCommunityWeb.Router do
  use ExploringBeamCommunityWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {ExploringBeamCommunityWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(ExploringBeamCommunityWeb.Plugs.Locale, "en")
  end

  scope "/", ExploringBeamCommunityWeb do
    pipe_through(:browser)

    get("/", HomeController, :index)
    live("/results", ResultsView)
    get("/about-us", AboutUsController, :index)
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through([:browser])
    end
  end
end
