defmodule ExploringBeamCommunityWeb.Router do
  use ExploringBeamCommunityWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ExploringBeamCommunityWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ExploringBeamCommunityWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/about-us", AboutUsController, :index

    live "/survey", SurveyLiveView

  end

end
