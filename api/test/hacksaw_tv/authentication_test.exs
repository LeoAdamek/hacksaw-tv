defmodule HacksawTv.AuthenticationTest do
  use HacksawTv.DataCase

  alias HacksawTv.Authentication

  describe "users" do
    alias HacksawTv.Authentication.User

    import HacksawTv.AuthenticationFixtures

    @invalid_attrs %{}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Authentication.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Authentication.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{}

      assert {:ok, %User{} = user} = Authentication.create_user(valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{}

      assert {:ok, %User{} = user} = Authentication.update_user(user, update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_user(user, @invalid_attrs)
      assert user == Authentication.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Authentication.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Authentication.change_user(user)
    end
  end
end
