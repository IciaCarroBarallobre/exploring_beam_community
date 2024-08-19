defmodule ExploringBeamCommunityWeb.ErrorHTML do
  use ExploringBeamCommunityWeb, :html

  # If you want to customize your error pages,
  # uncomment the embed_templates/1 call below
  # and add pages to the error directory:
  #
  #   * lib/hello_web/controllers/error_html/404.html.heex
  #   * lib/hello_web/controllers/error_html/500.html.heex
  #
  embed_templates("error_html/*")
end
