defmodule ExploringBeamCommunityWeb.HomeController do
  use ExploringBeamCommunityWeb, :controller

  alias ExploringBeamCommunity.Subscriptions
  alias ExploringBeamCommunity.Subscriptions.Subscription
  # Mail (Deactived - TODO)
  #alias ExploringBeamCommunity.Workers.BiWeeklyNewsletter
  #alias ExploringBeamCommunity.Mailer
  #alias ExploringBeamCommunity.PredefEmail
  #alias ExploringBeamCommunity.JobManager

  def index(conn, _params) do
    changeset = Subscriptions.change_subscription(%Subscription{})
    render(conn, :index, page_title: "Home", changeset: changeset)
  end

  def create(conn, %{"subscription" => subscription_params}) do
    case Subscriptions.create_subscription(subscription_params) do
      {:ok, _subscription} ->
        # Send the welcome email
        # Mail (Deactived - TODO)
        # PredefEmail.welcome_email(
        #   subscription.email,
        #   subscription.activation_token,
        #   subscription.unsubscribe_token)
        # |> Mailer.deliver()

        conn
        |> put_flash(:info, "Email saved successfully! ")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :index, changeset: changeset, page_title: "Failed to save email")
    end
  end

  def validate_subs(conn, %{"token" => token}) do
    case Subscriptions.activate_by_token(token) do
      {:ok, _subscription} ->
        # Mail (Deactived - TODO)
        # BiWeeklyNewsletter.schedule_biweekly_newsletter(
        #  subscription.email,
        #  subscription.unsubscribe_token)

        conn
        |> put_flash(:info, "Confirmation of the subscription successfully! ")
        |> redirect(to: ~p"/")

      {:error, info} ->
        conn
        |> put_flash(:error, info)
        |> redirect(to: ~p"/")
    end
  end

  def unsubscribe(conn, %{"token" => token}) do
    case Subscriptions.unsubscribe_by_token(token) do
      {:ok, _subscription} ->
        # Mail (Deactived - TODO)
        #  JobManager.cancel_jobs_by_token(token)

        conn
        |> put_flash(:info, "You have successfully unsubscribed.")
        |> redirect(to: ~p"/")

      {:error, :not_found} ->
        conn
        |> put_flash(:error, "Invalid or expired unsubscribe link.")
        |> redirect(to: ~p"/")
    end
  end
end
