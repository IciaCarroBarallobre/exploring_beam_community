defmodule ExploringBeamCommunityWeb.AboutUsHTML do
  use ExploringBeamCommunityWeb, :html
  import ExploringBeamCommunityWeb.ProfileCard, only: [profile_card: 1]

  def index(assigns) do
    ~H"""
    <h1>About Us!</h1>

    <div>
    <.profile_card
      name="Icia Carro Barallobre"
      role="Software Engenieer"
      company ="Peer Stritzinger"
      image="images/profiles/icia.png"
      description = {"Im a Software Engenieer and a studient of psycology. Inspired by the kindness and collaboration spirit of the Elixir community, I’m dedicated to cultivating that same culture of kindness and cooperation into every thing I do. Starting with backend development in Kotlin & SpringBoot at a pet health insurance startup, I then transitioned to data analysis. Along the way, I discovered Elixir and the BEAM languages through university and the Stack Overflow survey, where Elixir/Phoenix stood out as beloved frameworks. Now, I’m in the world of BEAM languages at Peer Stritzinger GmbH, specializing in Erlang solutions for embedded systems."}

    />
    <.profile_card
      name="Maria Jose Gavilan"
      role="Researcher / Project Manager"
      company ="Peer Stritzinger"
      image="images/profiles/mariajo.jpg"
      description = {"Passionate about people, their organizational methods, creative processes, and the need for communication and community. I run a private practice in San José, providing therapy and developing treatment plans. My journey into psychology began with a Licentiate from UCACIS and a diploma in Art Therapy from UAM, sparking my interest in connecting psychoanalysis with art. In 2015, I co-founded Kunsthilft in Berlin, offering therapeutic art workshops for refugee children. I combine my expertise in psychology with project management, bringing a unique perspective to my work."}/>
    </div>

    """
  end
end
