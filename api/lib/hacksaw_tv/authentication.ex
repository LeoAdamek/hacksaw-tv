defmodule HacksawTv.Authentication do
  @moduledoc """
  The Authentication context.
  """

  import Ecto.Query, warn: false
  alias HacksawTv.Repo

  alias HacksawTv.Authentication.User
  alias HacksawTv.Authentication.Invite

  alias Ecto.Multi, as: M

  @doc """
    Find an Invite by its token.
    Token must not be expired.
  """

  @spec find_invite_by_token(String.t) :: {:ok, %Invite{}} | {:error, atom()}
  def find_invite_by_token(token) do
    query =from i in Invite,
      where: i.token == ^token,
      select: i

    #now = DateTime.utc_now()

    case Repo.one(query) do
      nil -> {:error, :invalid}

      # TODO: Check token expiry and return {:error, :expired}
      token -> {:ok, token}
    end
  end


  @spec register_user_with_invite(map, %Invite{}) :: {:ok, %User{}} | {:error, :invalid, keyword()}
  def register_user_with_invite(user_params, %Invite{} = invite) do

    params = %{
      username: user_params["username"],
      password_hash: user_params["password"],
      last_sign_in_at: nil,
    }

    tasks = M.new()
      |> M.delete(:invites, invite)
      |> M.insert(:users, User.changeset(%User{}, params))

    case Repo.transaction(tasks) do
      {:ok, %{users: user} } -> {:ok, user}
      {:error, :users, %Ecto.Changeset{valid?: false, errors: errors} } -> {:error, :invalid, errors}
    end
  end

  @spec find_user_by_username(String.t) :: %User{} | nil
  def find_user_by_username(username) do
    query = from u in User,
      where: u.username == ^username,
      select: u

    Repo.one(query)
  end

  @spec find_user_by_username!(String.t) :: %User{}
  def find_user_by_username!(username) do
    case find_user_by_username(username) do
      nil -> raise Ecto.NoResultsError
      user -> user
    end
  end
end
