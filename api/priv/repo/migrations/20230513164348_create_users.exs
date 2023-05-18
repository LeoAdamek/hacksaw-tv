defmodule HacksawTv.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string, size: 32, null: false
      add :password_hash, :binary, null: false
      add :last_sign_in_at, :utc_datetime_usec

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
