defmodule HacksawTv.Authentication.Invite do
  alias Ecto.UUID
  use Ecto.Schema
  import Ecto.Changeset

  # Default Invite lifetime is 7 days.
  @default_ttl 7 * 86400

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invites" do
    field :expires_at, :utc_datetime_usec
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:token, :expires_at])
    |> validate_required([:token, :expires_at])
    |> unique_constraint(:token)
  end

  @spec generate(number()) :: %HacksawTv.Authentication.Invite{}
  def generate(ttl) do
    expires = DateTime.add(DateTime.utc_now(), ttl)

    %HacksawTv.Authentication.Invite{
      token: generate_token(),
      expires_at: expires
    }
  end

  @spec generate() :: %HacksawTv.Authentication.Invite{}
  def generate() do
    generate @default_ttl
  end

  @spec generate_token() :: String.t()
  def generate_token() do
    SecureRandom.hex 4
  end
end
