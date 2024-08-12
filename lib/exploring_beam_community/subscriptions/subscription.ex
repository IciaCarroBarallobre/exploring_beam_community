defmodule ExploringBeamCommunity.Subscriptions.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field(:email, :string)
    field(:activated, :boolean, default: false)
    field(:activation_token, :string)
    field(:unsubscribe_token, :string)

    timestamps()
  end

  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, email_regex())
    |> unique_constraint(:email)
    |> put_tokens_on_create(subscription)
  end

  defp email_regex do
    ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
  end

  defp put_tokens_on_create(changeset, %__MODULE__{id: nil}),
    do:
      changeset
      |> put_change(:unsubscribe_token, generate_token())
      |> put_change(:activation_token, generate_token())

  defp put_tokens_on_create(changeset, %__MODULE__{id: _id}),
    do: changeset

  defp generate_token do
    :crypto.strong_rand_bytes(16) |> Base.url_encode64() |> binary_part(0, 16)
  end
end
