defmodule ExploringBeamCommunityWeb.Layouts do
  use ExploringBeamCommunityWeb, :html
  import ExploringBeamCommunityWeb.CoreComponents
  import ExploringBeamCommunityWeb.Navbar, only: [navbar: 1]
  import ExploringBeamCommunityWeb.Footer, only: [footer: 1]

  embed_templates "layouts/*"

end
