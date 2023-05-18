defmodule HacksawTv.Authentication.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :last_sign_in_at, :utc_datetime_usec
    field :password_hash, :binary, redact: true
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :last_sign_in_at])
    |> validate_required([:username])
    |> validate_length(:username, min: 3, max: 32)
    |> put_password_hash()
    |> unique_constraint(:username)
  end

  ##
  # When the password hash
  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password_hash: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset

  @doc """
    Check a given password is the correct password for the given user.
  """
  @spec check_password(User.t, String.t) :: {:ok, term} | {:error, term}
  def check_password(user, given_password) do
    Argon2.check_pass(user, given_password)
  end
end
