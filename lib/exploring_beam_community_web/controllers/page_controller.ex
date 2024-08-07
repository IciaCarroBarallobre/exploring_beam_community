defmodule ExploringBeamCommunityWeb.PageController do
  use ExploringBeamCommunityWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def survey(conn, _params) do
    render(conn, :survey, layout: false)
  end

  def about_us(conn, _params) do
    render(conn, :about_us, layout: false)
  end

end
