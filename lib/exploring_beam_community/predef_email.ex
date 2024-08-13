defmodule ExploringBeamCommunity.PredefEmail do
  import Swoosh.Email

  @from_name "Icia & Mariajo"
  @from_email "iciacarrobarallobre@gmail.com"
  @cc "mariajose.gavilan@gmail.com"

  # Import the necessary helpers for path and URL generation
  alias ExploringBeamCommunityWeb.Endpoint

  def welcome_email(to_email, activation_token, unsubscribe_token) do
    base_url = Endpoint.url()
    unsubscribe_url = "#{base_url}/unsubscribe/#{unsubscribe_token}"
    activate_url = "#{base_url}/subscriptions/#{activation_token}"

    new()
    |> to(to_email)
    |> cc(@cc)
    |> from({@from_name, @from_email})
    |> subject("Welcome to our 2024 research on the European BEAM Community!")
    |> text_body("""
    Hi beamer,

    Welcome to our 2024 research on the European BEAM Community!

    Next step - Confirm your subscription: #{activate_url}

    If you confirmed it, every fifteen days, you will receive updates on our
    progress as long as the project continues.

    We invite you to explore and participate in our surveys (and share them)
    to help us understand the adoption, diversity, and challenges of BEAM
    languages across Europe.

    If you no longer wish to receive these emails, you can unsubscribe at any
    time by clicking the link below:
    #{unsubscribe_url}

    Best regards,
    #{@from_name}
    """)
  end

  def newsletter(to_email, unsubscribe_token, text) do
    base_url = Endpoint.url()
    unsubscribe_url = "#{base_url}/unsubscribe/#{unsubscribe_token}"

    new()
    |> to(to_email)
    |> cc(@cc)
    |> from({@from_name, @from_email})
    |> subject("2024 research on the European BEAM Community Status!")
    |> text_body("""
    Hi beamer,

    #{text}


    If you no longer wish to receive these emails, you can unsubscribe at any
    time by clicking the link below:
    #{unsubscribe_url}

    Best regards,
    #{@from_name}
    """)
  end
end
