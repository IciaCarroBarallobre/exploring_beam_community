defmodule ExploringBeamCommunityWeb.SurveyController do
  use ExploringBeamCommunityWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

end
