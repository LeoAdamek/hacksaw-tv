import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :hacksaw_tv, HacksawTv.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hacksaw_tv_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hacksaw_tv, HacksawTvWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5ATcF0NuJCPAf51IIhi6/V3TLSAUuNXW0ZE43tDEtSRTquduRpLWp2SY49R09NC2",
  server: false

# In test we don't send emails.
config :hacksaw_tv, HacksawTv.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
