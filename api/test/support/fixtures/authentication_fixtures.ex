defmodule HacksawTv.AuthenticationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HacksawTv.Authentication` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{

      })
      |> HacksawTv.Authentication.create_user()

    user
  end
end
