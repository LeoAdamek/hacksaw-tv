defmodule HacksawTvWeb.UserJSON do
  alias HacksawTv.Authentication.User

  def render("authenticated.json", %{user: user, token: token}) do
    %{user: user |> user_json, token: token}
  end


  @spec render(String.t, term) :: term
  def render("show.json", %{user: user}) do
    user |> user_json
  end

  @spec user_json(%User{}) :: map
  def user_json(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at,
    }
  end
end
