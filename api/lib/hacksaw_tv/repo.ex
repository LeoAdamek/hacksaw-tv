defmodule HacksawTv.Repo do
  use Ecto.Repo,
    otp_app: :hacksaw_tv,
    adapter: Ecto.Adapters.Postgres
end
