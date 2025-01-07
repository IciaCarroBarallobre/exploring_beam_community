defmodule ExploringBeamCommunityWeb.AboutUsHTML do
  use ExploringBeamCommunityWeb, :html
  import ExploringBeamCommunityWeb.ProfileCard, only: [profile_card: 1]

  def index(assigns) do
    ~H"""
    <h1 class="mx-auto text-center text-3xl dark:text-main-400 font-bold my-6">
      About us!
    </h1>
    <p class="mx-auto text-center my-4 font-semibold text-lg my-6">
      Feel free to contact us with any feedback ✉️, issues 🛠️, or questions.
    </p>

    <div class="grid md:grid-cols-2 grid-cols-1 gap-4 max-w-6xl w-full">
      <.profile_card
        name="Icia Carro Barallobre"
        role="Software Engenieer"
        company="Peer Stritzinger"
        image="images/profiles/icia.png"
        description="I am a Software Engineer and a Psychology student.
         I began my career in backend development at 2021 and then, I
         transitioned into data analysis. During this journey, I discovered
         Elixir and the BEAM languages through university studies and the Stack
         Overflow survey, where Elixir and Phoenix were highlighted as beloved
         language / framework. Currently, I work at Peer Stritzinger GmbH, a
         company deeply committed to the BEAM ecosystem. It specialize in
         developing embedded systems (GRiSP), cloud-to-edge distributed
         platforms (GRiSP.io), European projects like RESCALE, and also
         provides consultancy services.
         "
        github="IciaCarroBarallobre"
        gmail="iciacarrobarallobre@gmail.com"
        linkedin="icia-carro-barallobre"
        twitter="IciaCB"
      />
      <.profile_card
        name="Maria Jose Gavilan"
        role="Researcher / Project Manager"
        company="Peer Stritzinger"
        image="images/profiles/mariajo.jpg"
        description="Passionate about people, their organizational methods,
        creative processes, and the need for communication and community.
        I run a private practice in San José, providing therapy and developing
        treatment plans. My journey into psychology began with a Licentiate
        from UCACIS and a diploma in Art Therapy from UAM, sparking my interest
        in connecting psychoanalysis with art. In 2015, I co-founded Kunsthilft
        in Berlin, offering therapeutic art workshops for refugee children. I
        combine my expertise in psychology with project management, bringing
        a unique perspective to my work."
        gmail="mariajose.gavilan@gmail.com"
        linkedin="mariajosegavilan"
        twitter="galateadunkel"
      />
    </div>

    """
  end
end
