defmodule ExploringBeamCommunity.Workers.BiWeeklyNewsletter do
  use Oban.Worker, queue: :scheduled, max_attempts: 2

  alias ExploringBeamCommunity.Mailer
  alias ExploringBeamCommunity.Emails
  alias ExploringBeamCommunity.PredefEmail

  def schedule_biweekly_newsletter(email, unsubscribe_token) do
    job_changeset =
      Oban.Job.new(
        %{"email" => email, "unsubscribe_token" => unsubscribe_token},
        worker: __MODULE__,
        scheduled_at: calculate_next_date(),
        unique: [period: :infinity, states: [:available, :scheduled]]
      )

    Oban.insert(job_changeset)
  end

  @impl true
  def perform(%Oban.Job{
        args: %{"email" => email, "unsubscribe_token" => unsubscribe_token} = _args,
        attempt: 1
      }) do
    schedule_biweekly_newsletter(email, unsubscribe_token)
    deliver_mail(email, unsubscribe_token)
  end

  def perform(%Oban.Job{args: %{"email" => email, "unsubscribe_token" => unsubscribe_token}}),
    do: deliver_mail(email, unsubscribe_token)

  def perform(%Oban.Job{args: %{}} = job),
    do: {:error, "Job has empty args: #{inspect(job)}"}

  defp deliver_mail(email, unsubscribe_token) do
    newsletter_content =
      case Emails.get_current_email() do
        nil ->
          "Here are the latest updates on the European BEAM Community project..."

        email_record ->
          email_record.content
      end

    PredefEmail.newsletter(email, unsubscribe_token, newsletter_content)
    |> Mailer.deliver()
  end

  defp calculate_next_date() do
    now = DateTime.utc_now()
    day = now.day

    cond do
      day < 20 ->
        NaiveDateTime.new!(now.year, now.month, 20, 9, 0, 0, 0)
        |> DateTime.from_naive!("Etc/UTC")

      day >= 20 ->
        next_month = if now.month == 12, do: 1, else: now.month + 1
        next_year = if next_month == 1, do: now.year + 1, else: now.year

        NaiveDateTime.new!(next_year, next_month, 1, 9, 0, 0, 0)
        |> DateTime.from_naive!("Etc/UTC")
    end
  end
end
