defmodule ExploringBeamCommunityWeb.AboutUsController do
  use ExploringBeamCommunityWeb, :controller

  def index(conn, _params) do
    render(conn, :index, page_title: "About us")
  end
end
