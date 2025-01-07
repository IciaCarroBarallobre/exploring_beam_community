defmodule ExploringBeamCommunityWeb.Layouts do
  use ExploringBeamCommunityWeb, :html
  import ExploringBeamCommunityWeb.CoreComponents
  import ExploringBeamCommunityWeb.Components.Navbar, only: [navbar: 1]
  import ExploringBeamCommunityWeb.Components.Footer, only: [footer: 1]

  embed_templates("layouts/*")
end
