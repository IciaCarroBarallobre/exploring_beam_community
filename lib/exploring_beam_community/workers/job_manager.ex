defmodule ExploringBeamCommunity.JobManager do
  import Ecto.Query, only: [from: 2]
  alias ExploringBeamCommunity.Repo
  alias Oban.Job

  def cancel_jobs_by_token(unsubscribe_token) do
    from(j in Job,
      where:
        fragment("?->>? = ?", j.args, "unsubscribe_token", ^unsubscribe_token) and
          j.state in ["scheduled", "available"]
    )
    |> Repo.update_all(set: [state: "cancelled"])
  end

  def get_scheduled_jobs do
    Repo.all(
      from(j in Job,
        where: j.state == "scheduled",
        order_by: [asc: j.scheduled_at]
      )
    )
  end
end
