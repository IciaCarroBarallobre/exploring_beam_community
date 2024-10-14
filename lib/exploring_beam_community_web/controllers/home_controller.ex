defmodule ExploringBeamCommunityWeb.HomeController do
  use ExploringBeamCommunityWeb, :controller

  def index(conn, _params) do
    render(conn, :index, page_title: "Home")
  end
end
