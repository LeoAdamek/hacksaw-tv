defmodule HacksawTv.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :token, :string
      add :expires_at, :utc_datetime_usec

      timestamps()
    end

    create unique_index(:invites, [:token])
  end
end
