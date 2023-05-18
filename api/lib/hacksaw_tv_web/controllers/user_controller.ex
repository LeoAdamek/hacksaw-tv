defmodule HacksawTvWeb.UserController do
  use HacksawTvWeb, :controller

  alias HacksawTv.Authentication

  action_fallback HacksawTvWeb.FallbackController

  @type params :: %{String.t => String.t | params}

  @spec register(Plug.Conn.t, params) :: Plug.Conn.t
  def register(conn, %{"user" => user_params, "token" => tokenStr}) do
    {:ok, token} = HacksawTv.Authentication.find_invite_by_token(tokenStr)
    {:ok, user} = HacksawTv.Authentication.register_user_with_invite(user_params, token)

    conn
      |> assign(:user, user)
      |> render(:show)
  end

  @spec authenticate(Plug.Conn.t, params) :: Plug.Conn.t
  def authenticate(conn, %{"username" => username, "password" => password}) do
    user = Authentication.find_user_by_username!(username)
    case Authentication.User.check_password(user, password) do
      {:ok, _} ->
        token = Phoenix.Token.sign(conn, user.username, %{user: user})

        conn
          |> assign(:user, user)
          |> assign(:token, token)
          |> render(:authenticated)
      {:error, error} ->
        conn |> assign(:error, error) |> render(:fail)
    end
  end
end
